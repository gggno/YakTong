#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SeletedMediItem : NSObject

@property (nonatomic, nullable, copy) NSString * itemName;
@property (nonatomic, nullable, copy) NSString * itemImage;

- (id)initWithString:(NSString *)name :(NSString *)image;

@end

NS_ASSUME_NONNULL_END
