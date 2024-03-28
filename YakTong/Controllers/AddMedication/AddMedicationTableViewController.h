#import <UIKit/UIKit.h>
#import "MedicationResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddMedicationTableViewController : UIViewController <UISceneDelegate>

- (void)getMedicationAPI:(NSNumber *)pageNo 
                        :(NSString *)searchTerm;


@end

NS_ASSUME_NONNULL_END
