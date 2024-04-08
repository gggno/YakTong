#import <UIKit/UIKit.h>
#import "MedicationResponse.h"
#import "SearchMediTableViewCell.h"
#import "UIScrollView+Helpers.h"
#import "MediInfoViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchMedicationTableViewController : UIViewController <UISceneDelegate, UITableViewDelegate, UITableViewDataSource>

- (void)getMedicationAPI:(NSNumber *)pageNo
                        :(NSString *)searchTerm
                        :(void(^)(MedicationResponse *))completion;


@end

NS_ASSUME_NONNULL_END
