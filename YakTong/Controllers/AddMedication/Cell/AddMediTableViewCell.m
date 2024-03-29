#import "AddMediTableViewCell.h"

@implementation AddMediTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)configureCell:(MediItems *)cellData
{   
    
    if (![cellData.itemImage isKindOfClass:[NSNull class]]) {
        [_mediImageView sd_setImageWithURL:[NSURL URLWithString:cellData.itemImage]
                          placeholderImage:[UIImage systemImageNamed:@"pills.fill"]];
    } else {
        _mediImageView.image = [UIImage systemImageNamed:@"pills.fill"];
    }
    [_itemNameLabel setText:cellData.itemName];
    [_efcyQesitmLabel setText:cellData.efcyQesitm];
}

@end
