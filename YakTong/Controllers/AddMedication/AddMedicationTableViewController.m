#import "AddMedicationTableViewController.h"

@interface AddMedicationTableViewController ()
{
    NSString * currentSearchTerm; // 검색어
    NSNumber * pageNo;
    NSMutableArray<MediItems *> * mediItemList;
}

@property (weak, nonatomic) IBOutlet UISearchBar *medicationSearchBar;

@end

@implementation AddMedicationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pageNo = [[NSNumber alloc] initWithInt:1];
    currentSearchTerm = @"";
    
    
}

#pragma mark Instance Methods
/// 검색한 약품에 대한 정보 불러오기
- (void)getMedicationAPI:(NSNumber *)pageNo
                        :(NSString *)searchTerm
{
    NSLog(@"%s, line: %d, pageNo: %@ searchTerm: %@",__func__, __LINE__, pageNo, searchTerm);
    
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession * sesson = [NSURLSession sessionWithConfiguration:config];
    
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [components setHost:@"apis.data.go.kr"];
    [components setPath:@"/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList"];
    
    NSMutableArray<NSURLQueryItem *> * queries = [NSMutableArray arrayWithCapacity:4];
    
    NSString * pageString = [@([pageNo integerValue]) stringValue];
    
    [queries addObject:[NSURLQueryItem queryItemWithName:@"serviceKey" value:@"MXeg4k90bO3y47G4O%2F5DTg1S9OmMB%2BUUh8k%2BOLoX96qUae8mvDLTWXASHiIPn0HzjLqsmj7jr7n%2FlUL00YNkIQ%3D%3D"]];
    [queries addObject:[NSURLQueryItem queryItemWithName:@"pageNo" value:pageString]];
    [queries addObject:[NSURLQueryItem queryItemWithName:@"itemName" value:searchTerm]];
    [queries addObject:[NSURLQueryItem queryItemWithName:@"type" value:@"json"]];
    
    [components setQueryItems:queries];
    
    NSURL *url = [components URL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [sesson dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"%s, line: %d , error: %@",__func__, __LINE__, error);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        
        if (jsonDict) {
            NSLog(@"JSON 디코딩 성공");
            
            __weak AddMedicationTableViewController * weakSelf = self;
            AddMedicationTableViewController * strongSelf = weakSelf;
            
            // JSON 데이터를 MedicationResponse 객체로 변환
            MedicationResponse *mediData = [[MedicationResponse alloc] initWithDictionary:jsonDict[@"body"]];
            
            if (strongSelf) {
                strongSelf->mediItemList = mediData.items;
                NSLog(@"mediList: %lu", (unsigned long)strongSelf->mediItemList.count);
            }
            
        } else {
            NSLog(@"JSON 디코딩 오류: %@", jsonError);
        }
    }];
    
    [dataTask resume];
}

#pragma mark IBAction
- (IBAction)medicationSearchBtnClicked:(UIButton *)sender {
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");
    [self getMedicationAPI:pageNo :currentSearchTerm];
}

#pragma mark SearchDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    currentSearchTerm = searchText;
    
}




@end
