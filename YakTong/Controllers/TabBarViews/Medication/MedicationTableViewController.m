#import "MedicationTableViewController.h"

@interface MedicationTableViewController ()
{
    NSMutableArray<SeletedMediItem *> * selectedMediItemList;
    
    // 화면에 보여지는 최종 데이터
    NSMutableArray<MedicationListItem *> * mediDatasList;
}

@property (strong, nonatomic) UIBarButtonItem *mediListBtn;

@property (weak, nonatomic) IBOutlet UITableView *medicationTableView;

@property (weak, nonatomic, nullable) FIRFirestore *db;

@end

@implementation MedicationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialSetting];
}

- (void)initialSetting
{
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");
    
    _db = [FIRFirestore firestore];
    
    _medicationTableView.dataSource = self;
    _medicationTableView.delegate = self;
    
    UINib * mediCellNib = [UINib nibWithNibName:@"MedicationTableViewCell" bundle:nil];
    [_medicationTableView registerNib:mediCellNib forCellReuseIdentifier:@"MedicationTableViewCell"];
    
    _mediListBtn = [[UIBarButtonItem alloc]
                                    initWithImage:[UIImage systemImageNamed:@"plus"]
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(mediListBtnTapped:)];
    [_mediListBtn setTintColor:UIColor.blueColor];
    
    self.navigationItem.rightBarButtonItem = _mediListBtn;
    
    mediDatasList = [NSMutableArray new];
    
    [self getMediItemList];
}

- (void)mediListBtnTapped:(UIButton *)sender
{
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"AddMedicationViewController" bundle:nil];
    
    AddMedicationViewController * popVC = [storyboard instantiateViewControllerWithIdentifier:@"AddMedicationViewController"];
    
    
    popVC.delegate = self;
    
    UINavigationController * naviVC = [[UINavigationController alloc] initWithRootViewController:popVC];
    
    [naviVC setModalPresentationStyle:UIModalPresentationFullScreen];
    
    [self presentViewController:naviVC animated:YES completion:nil];
    
    
}

#pragma mark Delegate
- (void)addMediList:(NSString *)disease :(NSDate *)startDate :(NSDate *)endDate :(NSMutableArray<SeletedMediItem *> *)mediItem
{
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");
    
    NSString * identifier = [[NSUUID new] UUIDString];
    MedicationListItem * mediList = [[MedicationListItem alloc] initWithDatas
                                     :identifier
                                     :disease
                                     :startDate
                                     :endDate 
                                     :mediItem];
    
    [mediDatasList addObject:mediList];
    
    [_medicationTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return mediDatasList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MedicationListItem * cellData = [mediDatasList objectAtIndex:indexPath.section];
    
    MedicationTableViewCell * cell = (MedicationTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"MedicationTableViewCell" forIndexPath:indexPath];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [cell configureCell:cellData];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

// 삭제
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[[self.db collectionWithPath:@"mediItemList"] documentWithPath:mediDatasList[indexPath.section].identifier]
            deleteDocumentWithCompletion:^(NSError * _Nullable error) {
            if (error != nil) {
                NSLog(@"복약리스트 삭제하는 과정에서 에러가 발생하였습니다. 에러내용: %@", error);
                
            } else {
                NSLog(@"복약리스트에서 해당 리스트가 삭제되었습니다.");
                
                __weak MedicationTableViewController * weakSelf = self;
                
                MedicationTableViewController * strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf->mediDatasList removeObjectAtIndex:indexPath.section];
                    [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
                }
              }
        }];
    }
}

#pragma mark Instance Methods
- (void)getMediItemList
{
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");

    [[[self.db collectionWithPath:@"mediItemList"] queryOrderedByField:@"startDate" descending:(NO)]
    getDocumentsWithCompletion:^(FIRQuerySnapshot *snapshot, NSError *error) {
        
        if (error != nil) {
            NSLog(@"Error getting documents: %@", error);
            
        } else {
            NSMutableArray<MedicationListItem *> * tempMediItemList = [NSMutableArray new];
            
            for (FIRDocumentSnapshot *document in snapshot.documents) {
                MediItems * tempMediItem = [[MedicationListItem alloc] initWithSnapshot:document];
                [tempMediItemList addObject: tempMediItem];
            }
            
            self->mediDatasList = tempMediItemList;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->_medicationTableView reloadData];
            });
        }
        
    }];
}

@end
