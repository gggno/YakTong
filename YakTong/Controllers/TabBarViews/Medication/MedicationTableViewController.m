#import "MedicationTableViewController.h"

@interface MedicationTableViewController ()

@property (strong, nonatomic) UIBarButtonItem *mediListBtn;

@end

@implementation MedicationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialSetting];
}

- (void)initialSetting
{
    
    _mediListBtn = [[UIBarButtonItem alloc]
                                    initWithImage:[UIImage systemImageNamed:@"plus"]
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(mediListBtnTapped:)];
    [_mediListBtn setTintColor:UIColor.blueColor];
    
    self.navigationItem.rightBarButtonItem = _mediListBtn;
}

- (void)mediListBtnTapped:(UIButton *)sender
{
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"AddMedicationViewController" bundle:nil];
    
    UIViewController * popVC = [storyboard instantiateViewControllerWithIdentifier:@"AddMedicationViewController"];
    
    UINavigationController * naviVC = [[UINavigationController alloc] initWithRootViewController:popVC];
    
    [naviVC setModalPresentationStyle:UIModalPresentationFullScreen];
    
    [self presentViewController:naviVC animated:YES completion:nil];
}

@end
