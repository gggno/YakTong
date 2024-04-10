#import "UIScrollView+Helpers.h"

@implementation UIScrollView (Helpers)

- (BOOL)reachedBottom
{
    CGFloat height = self.frame.size.height;
    CGFloat contentYOffset = self.contentOffset.y;
    CGFloat distanceFromBottom = self.contentSize.height - contentYOffset;
    
    BOOL reachedBottom = distanceFromBottom - 300 < height;
    
    return reachedBottom;
}

- (BOOL)reachedBottom:(CGFloat)threshHold
{
    CGFloat height = self.frame.size.height;
    CGFloat contentYOffset = self.contentOffset.y;
    CGFloat distanceFromBottom = self.contentSize.height - contentYOffset;
    
    BOOL reachedBottom = distanceFromBottom - threshHold < height;
    
    return reachedBottom;
}

@end
