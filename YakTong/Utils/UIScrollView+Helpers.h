#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (Helpers)

- (BOOL)reachedBottom;

- (BOOL)reachedBottom:(CGFloat)threshHold;

@end

NS_ASSUME_NONNULL_END
