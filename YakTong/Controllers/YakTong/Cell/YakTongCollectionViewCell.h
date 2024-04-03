#import <UIKit/UIKit.h>
#import "MediItems.h"

@import SDWebImage;

NS_ASSUME_NONNULL_BEGIN

@interface YakTongCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mediImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (void)configureCellData:(MediItems *)cellData;

@end

NS_ASSUME_NONNULL_END
