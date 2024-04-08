#import <UIKit/UIKit.h>
#import "MediItems.h"

@import SDWebImage;

NS_ASSUME_NONNULL_BEGIN

@interface SearchMediTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mediImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *efcyQesitmLabel;

-(void)configureCell:(MediItems *)cellData;

@end

NS_ASSUME_NONNULL_END
