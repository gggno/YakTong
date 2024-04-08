#import "MediInfoViewController.h"

@interface MediInfoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *mediImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *entpNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemSeqLabel;
@property (weak, nonatomic) IBOutlet UILabel *efcyQesitmLabel;
@property (weak, nonatomic) IBOutlet UILabel *useMethodQesitm;
@property (weak, nonatomic) IBOutlet UILabel *atpnWarnQesitmLabel;
@property (weak, nonatomic) IBOutlet UILabel *atpnQesitmLabel;
@property (weak, nonatomic) IBOutlet UILabel *intrcQesitmLabel;
@property (weak, nonatomic) IBOutlet UILabel *seQesitmLabel;
@property (weak, nonatomic) IBOutlet UILabel *depositMethodQesitm;

@property (strong, nonatomic) UIBarButtonItem *mediListBtn;
@property (strong, nonatomic) UIBarButtonItem *yakTongBtn;

@property (weak, nonatomic, nullable) FIRFirestore *db;

@property (nonatomic, assign) BOOL yakTongState;

@end

@implementation MediInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");
    
    [self initialSetting];
    
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");

    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated {
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");

    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (void)initialSetting
{
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");

    [self setTitle:@"상세정보"];
    
    _db = [FIRFirestore firestore];
    
    FIRCollectionReference *yakTongCollection = [self.db collectionWithPath:@"yakTong"];
    FIRQuery *query = [yakTongCollection queryWhereField:@"itemSeq" isEqualTo:_mediItem.itemSeq];

    [query getDocumentsWithCompletion:^(FIRQuerySnapshot *snapshot, NSError *error) {
        if (error != nil) {
            NSLog(@"Error getting documents: %@", error);
        } else {
            __weak MediInfoViewController * weakSelf = self;
            
            MediInfoViewController * strongSelf = weakSelf;
            
            if (strongSelf) {
                // 내비게이션 아이템 설정
                strongSelf->_mediListBtn = [[UIBarButtonItem alloc]
                                                initWithImage:[UIImage systemImageNamed:@"plus"]
                                                style:UIBarButtonItemStylePlain
                                                target:self
                                                action:@selector(mediListBtnTapped:)];
                [strongSelf->_mediListBtn setTintColor:UIColor.blueColor];
                
                strongSelf->_yakTongBtn = [[UIBarButtonItem alloc]
                                               initWithImage:[UIImage systemImageNamed:@"pill.fill"]
                                               style:UIBarButtonItemStylePlain
                                               target:self
                                               action:@selector(yakTongBtnTapped:)];
                [strongSelf->_yakTongBtn setTintColor:UIColor.greenColor];
                
                if ([snapshot.documents count] > 0) {
                    NSLog(@"이미 해당 의약품이 약통에 존재합니다.");
                    strongSelf->_yakTongState = NO;
                    [strongSelf->_yakTongBtn setTintColor:UIColor.greenColor];
                    
                } else {
                    NSLog(@"해당 의약품이 약통에 존재하지 않습니다. 추가할 수 있습니다.");
                    strongSelf->_yakTongState = YES;
                    [strongSelf->_yakTongBtn setTintColor:UIColor.grayColor];
                }
                
                // 복약리스트 if 문도 넣어야됨
                
                self.navigationItem.rightBarButtonItems = @[strongSelf->_yakTongBtn, strongSelf->_mediListBtn];
            }
        }
    }];
    
    // 약 상세정보 세팅
    if (![_mediItem.itemImage isKindOfClass:[NSNull class]]) {
        [_mediImageView sd_setImageWithURL:[NSURL URLWithString:_mediItem.itemImage]
                          placeholderImage:[UIImage systemImageNamed:@"pills.fill"]];
    }
    
    [_itemNameLabel setText:_mediItem.itemName];
    [_entpNameLabel setText:[@"업체명: " stringByAppendingString:_mediItem.entpName ?: @"정보없음"]];
    [_itemSeqLabel setText:[@"품목기준코드: " stringByAppendingString:_mediItem.itemSeq ?: @"정보없음"]];
    [self applyData:_efcyQesitmLabel :_mediItem.efcyQesitm];
    [self applyData:_useMethodQesitm :_mediItem.useMethodQesitm];
    [self applyData:_atpnWarnQesitmLabel :_mediItem.atpnWarnQesitm];
    [self applyData:_atpnQesitmLabel :_mediItem.atpnQesitm];
    [self applyData:_intrcQesitmLabel :_mediItem.intrcQesitm];
    [self applyData:_seQesitmLabel :_mediItem.seQesitm];
    [self applyData:_depositMethodQesitm :_mediItem.depositMethodQesitm];
}

#pragma mark Instance Methods
- (void)applyData:(UILabel *)label :(NSString *)reciviedData
{
    if (![reciviedData isKindOfClass:[NSNull class]]) {
        [label setText:reciviedData];
    } else {
        [label setText:@"정보없음"];
    }
}

- (void)mediListBtnTapped:(UIButton *)sender
{
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");
    
    
}

- (void)yakTongBtnTapped:(UIButton *)sender
{
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");
    
    if (_yakTongState) { // 추가
        FIRDocumentReference *newyakTongRef = [[self.db collectionWithPath:@"yakTong"] documentWithPath:_mediItem.itemSeq];
        
        NSDictionary *yakTongData = @{
            @"itemSeq": _mediItem.itemSeq,
            @"entpName": _mediItem.entpName,
            @"itemName": _mediItem.itemName,
            @"efcyQesitm": _mediItem.efcyQesitm,
            @"useMethodQesitm": _mediItem.useMethodQesitm,
            @"atpnWarnQesitm": _mediItem.atpnWarnQesitm,
            @"atpnQesitm": _mediItem.atpnQesitm,
            @"intrcQesitm": _mediItem.intrcQesitm,
            @"seQesitm": _mediItem.seQesitm,
            @"depositMethodQesitm": _mediItem.depositMethodQesitm,
            @"itemImage": _mediItem.itemImage
        };
        
        [newyakTongRef setData:yakTongData completion:^(NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"약통에 추가하는 과정에서 에러가 발생하였습니다. 에러내용: %@", error);
            } else {
                NSLog(@"약통에 추가되었습니다.");
                __weak MediInfoViewController * weakSelf = self;
                
                MediInfoViewController * strongSelf = weakSelf;
                if (strongSelf) {
                    strongSelf->_yakTongState = NO;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [strongSelf->_yakTongBtn setTintColor:UIColor.greenColor];
                    });
                }
                
                NSString *message = [NSString stringWithFormat:@"%@이(가) 약통에 추가되었습니다.", self->_mediItem.itemName];
                
                [UIAlertController showCustomAlertWithTitle:@"약통에 추가" message:message inViewController:self];
            }
        }];
        
    } else { // 삭제
        [[[self.db collectionWithPath:@"yakTong"] documentWithPath:_mediItem.itemSeq]
            deleteDocumentWithCompletion:^(NSError * _Nullable error) {
            if (error != nil) {
                NSLog(@"약통에 삭제하는 과정에서 에러가 발생하였습니다. 에러내용: %@", error);
                
            } else {
                NSLog(@"약통에서 해당 약품이 삭제되었습니다.");
                __weak MediInfoViewController * weakSelf = self;
                
                MediInfoViewController * strongSelf = weakSelf;
                if (strongSelf) {
                    strongSelf->_yakTongState = YES;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [strongSelf->_yakTongBtn setTintColor:UIColor.grayColor];
                    });
                }
                
                NSString *message = [NSString stringWithFormat:@"%@이(가) 약통에서 삭제되었습니다.", self->_mediItem.itemName];
                
                [UIAlertController showCustomAlertWithTitle:@"약통에서 삭제" message:message inViewController:self];
              }
        }];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"yakTongDataReLoad" object:self];
}

@end
