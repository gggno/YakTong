#import <UIKit/UIKit.h>
#import "MediItems.h"
#import "UIAlertController+PresentAlert.h"

@import SDWebImage;
@import FirebaseCore;
@import FirebaseFirestore;

NS_ASSUME_NONNULL_BEGIN

@interface MediInfoViewController : UIViewController

@property (nonatomic, strong) MediItems * mediItem;

- (void)initialSetting;
- (void)applyData:(UILabel *)label
                 :(NSString *)reciviedData;
- (void)mediListBtnTapped:(UIButton *)sender;
- (void)yakTongBtnTapped:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
