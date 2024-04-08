//
//  SeletedMediItem.m
//  YakTong
//
//  Created by 정근호 on 4/8/24.
//

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
