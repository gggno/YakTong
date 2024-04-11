#import "MedicationTableViewCell.h"

@implementation MedicationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.layer.cornerRadius = 5;
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.borderColor = UIColor.tintColor.CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell:(MedicationListItem *)mediListItem
{
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");
    
    [_titleLabel setText:mediListItem.disease];
    if (_selectedMediItemStackView.arrangedSubviews.count == 0) {
        for (MediItems *mediItem in mediListItem.mediItem) {
            SeletedMediItemView *itemView = [[SeletedMediItemView alloc]
                                             initWithItem:mediItem.itemName :mediItem.itemImage :40 :30];
            [_selectedMediItemStackView addArrangedSubview:itemView];
        }
    }
    NSString * startDate = [NSDate convertDateToString:mediListItem.startDate];
    NSString * endDate = [NSDate convertDateToString:mediListItem.endDate];
    NSString * dateString = [[startDate stringByAppendingString:@" - "] stringByAppendingString:endDate];
    [_dateLabel setText: dateString];
    
}

@end
