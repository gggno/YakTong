#import <UIKit/UIKit.h>

@import SDWebImage;

NS_ASSUME_NONNULL_BEGIN

@interface SeletedMediItemView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *itemImage;

- (id)initWithItem:(NSString *)itemName :(NSString *)itemImage;

@end

NS_ASSUME_NONNULL_END
