#import "AddMedicationViewController.h"

@interface AddMedicationViewController ()
{
    NSMutableArray<SeletedMediItem *> * selectedMediItemList;
}

@property (weak, nonatomic) IBOutlet UITextField *diseaseTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *mediSearchBtn;

@property (strong, nonatomic) UIBarButtonItem *backBtn;
@property (strong, nonatomic) UIBarButtonItem *addBtn;

@property (weak, nonatomic) IBOutlet UIStackView *selectedMediItemStackView;

@property (weak, nonatomic, nullable) FIRFirestore *db;

@end

@implementation AddMedicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialSetting];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"selectedMediItem" object:nil];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"selectedMediItem" object:nil];
}

- (void)initialSetting
{
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");
    
    _db = [FIRFirestore firestore];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"뒤로가기" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    _backBtn = [[UIBarButtonItem alloc] initWithTitle:@"취소"
                                                style:UIBarButtonItemStylePlain target:self
                                               action:@selector(backBtnTapped:)];
    
    self.navigationItem.leftBarButtonItem = _backBtn;
    
    _addBtn = [[UIBarButtonItem alloc] initWithTitle:@"추가"
                                                   style:UIBarButtonItemStylePlain
                                                  target:self action:@selector(addBtnTapped:)];
    
    self.navigationItem.rightBarButtonItem = _addBtn;
    
    selectedMediItemList = [NSMutableArray new];
}

#pragma mark IBActions
- (void)backBtnTapped:(UIButton *)sender
{
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addBtnTapped:(UIButton *)sender
{
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");
    
    if ([_diseaseTextField.text length] == 0 || selectedMediItemList.count == 0) {
        [UIAlertController showCustomAlertWithTitle:@"추가할 수 없음" message:@"추가하지 않은 항목이 있습니다.\n다시 한번 확인해주세요." inViewController:self];
        
    } else {
        NSString *uuid = [[NSUUID new] UUIDString];
        FIRDocumentReference *mediItemListRef = [[self.db collectionWithPath:@"mediItemList"] documentWithPath:uuid];
        
        NSMutableArray<NSString *> * selectedItemNameArr = [NSMutableArray new];
        NSMutableArray<NSString *> * selectedItemImageArr = [NSMutableArray new];
        
        for (SeletedMediItem * mediItem in selectedMediItemList) {
            [selectedItemNameArr addObject:mediItem.itemName];
            [selectedItemImageArr addObject:mediItem.itemImage];
        }
        
        NSDictionary *meidListData = @{
            @"identifier": uuid,
            @"disease": _diseaseTextField.text,
            @"startDate": _startDatePicker.date,
            @"endDate": _endDatePicker.date,
            @"selectedItemName": selectedItemNameArr,
            @"selectedItemImage": selectedItemImageArr
        };
        
        [mediItemListRef setData:meidListData completion:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"복약리스트에 추가하는 과정에서 에러가 발생하였습니다. 에러내용: %@", error);
                
            } else {
                NSLog(@"복약리스트에 추가되었습니다.");
                __weak AddMedicationViewController * weakSelf = self;
                
                AddMedicationViewController * strongSelf = weakSelf;
                
                if (strongSelf) {
                    [strongSelf->_delegate addMediList:strongSelf->_diseaseTextField.text
                                          :strongSelf->_startDatePicker.date
                                          :strongSelf->_endDatePicker.date
                                          :strongSelf->selectedMediItemList];
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }
        }];
    }
}

- (IBAction)mediSearchBtnTapped:(UIButton *)sender {
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"AddSearchTableViewController" bundle:nil];
    
    AddSearchTableViewController * addSearchVC = [storyboard instantiateViewControllerWithIdentifier:@"AddSearchTableViewController"];
    
    [[self navigationController] pushViewController:addSearchVC animated:YES];
}

#pragma mark Selector Methods
- (void)handleNotification:(NSNotification *)notification
{
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");
    
    if ([notification.name isEqualToString:@"selectedMediItem"]) {
        NSDictionary * userInfo = notification.userInfo;
        NSString * itemName = userInfo[@"itemName"];
        NSString * itemImage = userInfo[@"itemImage"];
        
        SeletedMediItemView *itemView = [[SeletedMediItemView alloc] initWithItem:itemName :itemImage :80 :60];
        
        SeletedMediItem *tempSelectedMediItem = [[SeletedMediItem alloc] initWithString:itemName :itemImage];
        
        [selectedMediItemList addObject:tempSelectedMediItem];
        
        [_selectedMediItemStackView addArrangedSubview:itemView];
    }
}

@end
