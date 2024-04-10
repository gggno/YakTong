//
//  MedicationTableViewController.h
//  YakTong
//
//  Created by 정근호 on 3/27/24.
//

#import <UIKit/UIKit.h>
#import "SeletedMediItem.h"
#import "MediListDelegate.h"
#import "AddMedicationViewController.h"
#import "MedicationListItem.h"
#import "MedicationTableViewCell.h"

@import FirebaseCore;
@import FirebaseFirestore;

NS_ASSUME_NONNULL_BEGIN

@interface MedicationTableViewController : UIViewController <MediListDelegate, UITableViewDelegate, UITableViewDataSource>

- (void)initialSetting;

- (void)mediListBtnTapped:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
