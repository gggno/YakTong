#import "YakTongCollectionViewCell.h"

@implementation YakTongCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.layer.cornerRadius = 10.0; // 원하는 값을 설정하세요
    self.contentView.layer.borderWidth = 1.0;
    self.contentView.layer.borderColor = [UIColor grayColor].CGColor;
    self.contentView.layer.masksToBounds = YES;
    
}

- (void)configureCellData:(MediItems *)cellData
{
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");
    
    if (![cellData.itemImage isKindOfClass:[NSNull class]]) {
        [_mediImageView sd_setImageWithURL:[NSURL URLWithString:cellData.itemImage]
                          placeholderImage:[UIImage systemImageNamed:@"pills.fill"]];
    } else {
        _mediImageView.image = [UIImage systemImageNamed:@"pills.fill"];
    }
    [_itemNameLabel setText:cellData.itemName];
    
}


@end
