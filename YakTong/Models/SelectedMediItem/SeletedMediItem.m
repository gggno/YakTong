#import "SeletedMediItem.h"

@implementation SeletedMediItem

- (nonnull id)initWithString:(nonnull NSString *)name :(nonnull NSString *)image {
    
    self = [super init];
    
    if (self) {
        _itemName = name;
        _itemImage = image;
    }
    
    return self;
}

@end
