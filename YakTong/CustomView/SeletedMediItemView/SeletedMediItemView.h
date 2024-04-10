#import <UIKit/UIKit.h>

@import SDWebImage;

NS_ASSUME_NONNULL_BEGIN

@interface SeletedMediItemView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *itemImage;

@property (nonatomic, assign) NSInteger imageWitdh;
@property (nonatomic, assign) NSInteger imageHeight;

- (id)initWithItem:(NSString *)itemName :(NSString *)itemImage :(NSInteger)imageWitdh :(NSInteger)imageHeight;

@end

NS_ASSUME_NONNULL_END
