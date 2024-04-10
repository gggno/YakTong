#import <UIKit/UIKit.h>
#import "AddSearchTableViewController.h"
#import "SeletedMediItemView.h"
#import "SeletedMediItem.h"
#import "UIAlertController+PresentAlert.h"
#import "MediListDelegate.h"

@import FirebaseCore;
@import FirebaseFirestore;
@import SDWebImage;

NS_ASSUME_NONNULL_BEGIN

@interface AddMedicationViewController : UIViewController

@property (weak, nonatomic) id<MediListDelegate> delegate;

- (void)initialSetting;

@end

NS_ASSUME_NONNULL_END
