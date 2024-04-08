//
//  UIAlertController+PresentAlert.h
//  YakTong
//
//  Created by 정근호 on 4/8/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (PresentAlert)

+ (void)showCustomAlertWithTitle:(NSString *)title message:(NSString *)message inViewController:(UIViewController *)viewController;


@end

NS_ASSUME_NONNULL_END
