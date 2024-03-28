#import "MediItems.h"

@implementation MediItems

- (id)initWithDictionary:(NSDictionary<NSString *,id> *)jsonDictionary
{
    
    self = [super init];
    
    if (self) {
        _entpName = jsonDictionary[@"entpName"] ?: @"";
        _itemName = jsonDictionary[@"itemName"] ?: @"";
        _itemSeq = jsonDictionary[@"itemSeq"] ?: @"";
        _efcyQesitm = jsonDictionary[@"efcyQesitm"] ?: @"";
        _useMethodQesitm = jsonDictionary[@"useMethodQesitm"] ?: @"";
        _atpnWarnQesitm = jsonDictionary[@"atpnWarnQesitm"] ?: @"";
        _atpnQesitm = jsonDictionary[@"atpnQesitm"] ?: @"";
        _intrcQesitm = jsonDictionary[@"intrcQesitm"] ?: @"";
        _seQesitm = jsonDictionary[@"seQesitm"] ?: @"";
        _depositMethodQesitm = jsonDictionary[@"depositMethodQesitm"] ?: @"";
        _openDe = jsonDictionary[@"openDe"] ?: @"";
        _updateDe = jsonDictionary[@"updateDe"] ?: @"";
        _itemImage = jsonDictionary[@"itemImage"] ?: @"";
        _bizrno = jsonDictionary[@"bizrno"] ?: @"";
    }
    
    return self;
}

@end
