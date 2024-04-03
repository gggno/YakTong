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

- (id)initWithSnapshot:(FIRDocumentSnapshot *)document
{
    self = [super init];
    
    if (self != nil) {
        _entpName = document[@"entpName"] ?: @"";
        _itemName = document[@"itemName"] ?: @"";
        _itemSeq = document[@"itemSeq"] ?: @"";
        _efcyQesitm = document[@"efcyQesitm"] ?: @"";
        _useMethodQesitm = document[@"useMethodQesitm"] ?: @"";
        _atpnWarnQesitm = document[@"atpnWarnQesitm"] ?: @"";
        _atpnQesitm = document[@"atpnQesitm"] ?: @"";
        _intrcQesitm = document[@"intrcQesitm"] ?: @"";
        _seQesitm = document[@"seQesitm"] ?: @"";
        _depositMethodQesitm = document[@"depositMethodQesitm"] ?: @"";
        _openDe = document[@"openDe"] ?: @"";
        _updateDe = document[@"updateDe"] ?: @"";
        _itemImage = document[@"itemImage"] ?: @"";
        _bizrno = document[@"bizrno"] ?: @"";
    }
    
    return self;
}

@end
