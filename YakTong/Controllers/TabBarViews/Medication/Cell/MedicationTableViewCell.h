#import <UIKit/UIKit.h>
#import "MedicationListItem.h"
#import "NSDate+convertDateToString.h"
#import "SeletedMediItemView.h"
#import "MediItems.h"

NS_ASSUME_NONNULL_BEGIN

@interface MedicationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIStackView *selectedMediItemStackView;

- (void)configureCell:(MedicationListItem *)mediListItem;

@end

NS_ASSUME_NONNULL_END
