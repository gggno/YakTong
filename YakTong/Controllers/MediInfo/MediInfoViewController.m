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
    [self setTitle:@"상세정보"];

    // 내비게이션 아이템 설정
    UIBarButtonItem *mediListBtn = [[UIBarButtonItem alloc]
                                    initWithImage:[UIImage systemImageNamed:@"plus"]
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(mediListBtnTapped:)];
    [mediListBtn setTintColor:UIColor.blueColor];
    
    UIBarButtonItem *yakTongBtn = [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage systemImageNamed:@"plus"]
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(yakTongBtnTapped:)];
    [yakTongBtn setTintColor:UIColor.greenColor];
    
    self.navigationItem.rightBarButtonItems = @[yakTongBtn, mediListBtn];
    
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

}

@end
