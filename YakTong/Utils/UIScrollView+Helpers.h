//
//  UIScrollView+Helpers.h
//  SNS-Objc
//
//  Created by 정근호 on 3/21/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (Helpers)

- (BOOL)reachedBottom;

- (BOOL)reachedBottom:(CGFloat)threshHold;

@end

NS_ASSUME_NONNULL_END
