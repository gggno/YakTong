//
//  AddMediTableViewCell.h
//  YakTong
//
//  Created by 정근호 on 3/29/24.
//

#import <UIKit/UIKit.h>
#import "MediItems.h"

@import SDWebImage;

NS_ASSUME_NONNULL_BEGIN

@interface AddMediTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mediImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *efcyQesitmLabel;

-(void)configureCell:(MediItems *)cellData;

@end

NS_ASSUME_NONNULL_END
