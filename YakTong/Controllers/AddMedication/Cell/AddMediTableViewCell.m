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
    if (![cellData.itemName isKindOfClass:[NSNull class]]) {
        [_itemNameLabel setText:cellData.itemName];
    } else {
        [_itemNameLabel setText:@"정보없음"];
    }
    
    if (![cellData.efcyQesitm isKindOfClass:[NSNull class]]) {
        [_efcyQesitmLabel setText:cellData.efcyQesitm];
    } else {
        [_efcyQesitmLabel setText:@"정보없음"];
    }    
}

@end
