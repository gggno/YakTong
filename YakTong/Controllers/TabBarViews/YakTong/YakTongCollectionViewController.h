#import <UIKit/UIKit.h>
#import "YakTongCollectionViewCell.h"
#import "MediItems.h"
#import "MediInfoViewController.h"

@import SDWebImage;
@import FirebaseCore;
@import FirebaseFirestore;

NS_ASSUME_NONNULL_BEGIN

@interface YakTongCollectionViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

- (void)initialSetting;

@end

NS_ASSUME_NONNULL_END
