#import "UIAlertController+PresentAlert.h"

@implementation UIAlertController (PresentAlert)

+ (void)showCustomAlertWithTitle:(NSString *)title message:(NSString *)message inViewController:(UIViewController *)viewController {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"확인"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [viewController presentViewController:alert animated:YES completion:nil];
}

@end
