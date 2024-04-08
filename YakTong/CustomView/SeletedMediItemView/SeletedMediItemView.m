#import "SeletedMediItemView.h"

@implementation SeletedMediItemView

- (id)initWithItem:(NSString *)itemName :(NSString *)itemImage
{
    NSLog(@"%s, line: %d, itemName: %@ itemImage: %@",__func__, __LINE__, itemName, itemImage);

    self = [super init];
    
    if (self) {
        _itemName = itemName;
        _itemImage = itemImage;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");
    NSLog(@"_itemName: %@", _itemName);
    NSLog(@"_itemImage: %@", _itemImage);
    
    
    // UIImageView 생성 및 설정
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    self.imageView.layer.cornerRadius = 5;
    self.imageView.layer.masksToBounds = YES;
    [self.imageView setBackgroundColor:UIColor.systemGray5Color];
    [self.imageView setTintColor:UIColor.systemGray3Color];
    
    if (![_itemImage isKindOfClass:[NSNull class]]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_itemImage]
                          placeholderImage:[UIImage systemImageNamed:@"pills.fill"]];
    } else {
        self.imageView.image = [UIImage systemImageNamed:@"pills.fill"];
    }
    
    // UILabel 생성 및 설정
    self.label = [[UILabel alloc] init];
    self.label.text = _itemName;
    self.label.font = [UIFont systemFontOfSize:15];
    self.label.numberOfLines = 1;
    
    UIStackView * stackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.imageView, self.label]];
    
    stackView.layer.borderWidth = 1;
    stackView.layer.borderColor = UIColor.systemGrayColor.CGColor;
    stackView.layer.cornerRadius = 5;
    
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.distribution = UIStackViewDistributionFill;
    stackView.spacing = 8;
    
    [self addSubview:stackView];
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.imageView.widthAnchor constraintEqualToConstant:80].active = YES;
    [self.imageView.heightAnchor constraintEqualToConstant:60].active = YES;
    
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:20].active = YES;
    [stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-20].active = YES;
    [stackView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
}

@end
