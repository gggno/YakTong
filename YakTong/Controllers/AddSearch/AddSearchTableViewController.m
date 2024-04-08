#import "AddSearchTableViewController.h"

@interface AddSearchTableViewController ()
{
    NSString * currentSearchTerm; // 검색어
    NSNumber * pageNo;
    NSInteger selectedIndex;
    NSMutableArray<MediItems *> * mediItemList;
}

@property (weak, nonatomic) IBOutlet UISearchBar *medicationSearchBar;
@property (weak, nonatomic) IBOutlet UITableView *addSearchTableView;
@property (weak, nonatomic) IBOutlet UILabel *searchResultLabel;

@property (strong, nullable) dispatch_block_t debounceSearchInputTask;

@property (strong, nonatomic) UIBarButtonItem *addBtn;

@end

@implementation AddSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initialSetting];
}

- (void)initialSetting
{
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"뒤로가기" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    _addBtn = [[UIBarButtonItem alloc] initWithTitle:@"약품 추가"
                                                   style:UIBarButtonItemStylePlain
                                                  target:self action:@selector(addBtnTapped:)];
    _addBtn.enabled = NO;
    self.navigationItem.rightBarButtonItem = _addBtn;
    
    pageNo = [[NSNumber alloc] initWithInt:1];
    currentSearchTerm = @"";
    
    _addSearchTableView.delegate = self;
    _addSearchTableView.dataSource = self;
    _addSearchTableView.rowHeight = 100;
    
    UINib * searchMediCellNib = [UINib nibWithNibName:@"SearchMediTableViewCell" bundle:nil];
    [_addSearchTableView registerNib:searchMediCellNib forCellReuseIdentifier:@"SearchMediTableViewCell"];
    
}

#pragma mark Instance Methods
/// 검색한 약품에 대한 정보 불러오기
- (void)getMedicationAPI:(NSNumber *)pageNo
                        :(NSString *)searchTerm
                        :(void(^)(MedicationResponse *))completion
{
    NSLog(@"%s, line: %d, pageNo: %@ searchTerm: %@",__func__, __LINE__, pageNo, searchTerm);
    
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession * sesson = [NSURLSession sessionWithConfiguration:config];
    
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [components setHost:@"apis.data.go.kr"];
    [components setPath:@"/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList"];
    
    NSMutableArray<NSURLQueryItem *> * queries = [NSMutableArray arrayWithCapacity:4];
    
    NSString * serviceKey = @"9VBxnn9VcIqdtalgPSI5zqG7AMUdC+UTLn5vsuIZAg6rgotq7vhCiXYcJlccWi4UMMX8q78xS0s0SnHKpMSPiQ==";
    NSString * pageString = [@([pageNo integerValue]) stringValue];
    
    [queries addObject:[NSURLQueryItem queryItemWithName:@"serviceKey" value:serviceKey]];
    [queries addObject:[NSURLQueryItem queryItemWithName:@"pageNo" value:pageString]];
    [queries addObject:[NSURLQueryItem queryItemWithName:@"itemName" value:searchTerm]];
    [queries addObject:[NSURLQueryItem queryItemWithName:@"type" value:@"json"]];
    
    [components setQueryItems:queries];
    
    NSString *encodeQuery = [components.percentEncodedQuery stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    [components setPercentEncodedQuery:encodeQuery];
    
    NSURL *url = [components URL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSURLSessionDataTask *dataTask = [sesson dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"%s, line: %d , error: %@",__func__, __LINE__, error);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        
        if (jsonDict) {
            NSLog(@"JSON 디코딩 성공");
            
            // JSON 데이터를 MedicationResponse 객체로 변환
            MedicationResponse *mediData = [[MedicationResponse alloc] initWithDictionary:jsonDict[@"body"]];
            
            completion(mediData);
            
        } else {
            NSLog(@"JSON 디코딩 오류: %@", jsonError);
        }
    }];
    
    [dataTask resume];
}

#pragma mark SearchDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    // 글자 입력 시 디바운스 작업 초기화
    if (_debounceSearchInputTask != nil) {
        dispatch_block_cancel(_debounceSearchInputTask);
        _debounceSearchInputTask = nil;
    }
    
    if (searchText.length < 1) {
        self->mediItemList = nil;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_searchResultLabel setText:@""];
            [self->_addSearchTableView reloadData];
        });
        
        return;
    }
    
    dispatch_block_t task = dispatch_block_create_with_qos_class(DISPATCH_BLOCK_ENFORCE_QOS_CLASS, QOS_CLASS_USER_INITIATED, 0, ^{
        NSLog(@"%s, line: %d, 디바운스 된 글자: %@",__func__, __LINE__, searchText);
        self->pageNo = [NSNumber numberWithInt:1];
        self->currentSearchTerm = searchText;
        
        [self getMedicationAPI:self->pageNo
                              :searchText
                              :^(MedicationResponse *response) {
            
            self->mediItemList = response.items;
            
            NSString *stringCnt = [[NSString stringWithFormat:@"%d", response.totalCount] stringByAppendingString:@"개"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->_searchResultLabel setText:stringCnt];
                [self->_addSearchTableView reloadData];
            });
        }];
    });
    
    _debounceSearchInputTask = task;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.7 * NSEC_PER_SEC), dispatch_get_main_queue(), task);
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return mediItemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MediItems * cellData = [mediItemList objectAtIndex:indexPath.row];
    
    SearchMediTableViewCell * cell = (SearchMediTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"SearchMediTableViewCell" forIndexPath:indexPath];
    
    [cell configureCell:cellData];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s, line: %d, indexPath.row: %ld",__func__, __LINE__, (long)indexPath.row);
    
    selectedIndex = indexPath.row;
    _addBtn.enabled = YES;
    
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView reachedBottom:200]) {
        self->pageNo = [NSNumber numberWithInt: [pageNo intValue] + 1];
        
        [self getMedicationAPI:pageNo
                              :currentSearchTerm
                              :^(MedicationResponse *response) {
            [self->mediItemList addObjectsFromArray:response.items];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->_addSearchTableView reloadData];
            });
        }];
    }
}

#pragma mark IBAction
- (void)addBtnTapped:(UIButton *)sender
{
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");
    
    NSLog(@"%@", mediItemList[selectedIndex].itemName);
    NSDictionary *mediItemDic = @{@"itemName":mediItemList[selectedIndex].itemName,
                                  @"itemImage":mediItemList[selectedIndex].itemImage
    };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedMediItem" object:self userInfo:mediItemDic];
//    [[self navigationController] popViewControllerAnimated:YES];
}

@end
