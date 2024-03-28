#import "MedicationResponse.h"

@implementation MedicationResponse

- (id)initWithDictionary:(NSDictionary<NSString *, id> *)jsonDictionary
{
    self = [super init];
    
    if (self) {
        _pageNo = [jsonDictionary[@"pageNo"] integerValue] ?: 0;
        _totalCount = [jsonDictionary[@"totalCount"] integerValue] ?: 0;
        
        NSMutableArray<MediItems *> * itemList = [[NSMutableArray alloc] init];
        
        for (NSMutableArray * mediItemDic in jsonDictionary[@"items"]) {
            MediItems * item = [[MediItems alloc] initWithDictionary:mediItemDic];
            [itemList addObject:item];
        }
        
        _items = itemList;
    }
    
    return  self;
}

@end
