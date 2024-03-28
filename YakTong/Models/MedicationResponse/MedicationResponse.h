#import <Foundation/Foundation.h>
#import "MediItems.h"

NS_ASSUME_NONNULL_BEGIN

@interface MedicationResponse: NSObject

@property (nonatomic, assign) NSInteger * pageNo;
@property (nonatomic, assign) NSInteger * totalCount;
@property (nonatomic, nullable, copy) NSMutableArray<MediItems *> * items;

- (id)initWithDictionary:(NSDictionary<NSString *, id> *)jsonDictionary;

@end

NS_ASSUME_NONNULL_END
