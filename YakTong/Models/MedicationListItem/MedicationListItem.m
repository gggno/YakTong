#import "MedicationListItem.h"

@implementation MedicationListItem

- (id)initWithDatas:(NSString *)identifier :(NSString *)disease :(NSDate *)startDate :(NSDate *)endDate :(NSMutableArray<SeletedMediItem *> *)mediItem
{
    self = [super init];
    
    if (self) {
        _identifier = identifier;
        _disease = disease;
        _startDate = startDate;
        _endDate = endDate;
        _mediItem = mediItem;
    }
    
    return self;
}

- (id)initWithSnapshot:(FIRDocumentSnapshot *)document
{
    self = [super init];
    
    if (self != nil) {
        _identifier = document[@"identifier"] ?: @"";
        _disease = document[@"disease"] ?: @"";
        _startDate = ((FIRTimestamp *)document[@"startDate"]).dateValue;
        _endDate = ((FIRTimestamp *)document[@"endDate"]).dateValue;
        
        NSMutableArray<MedicationListItem *> *tempMediItem = [NSMutableArray new];
        NSArray *selectedItemNames = document[@"selectedItemName"];
        NSArray *selectedItemImages = document[@"selectedItemImage"];
        
        for (NSInteger i = 0 ; i<selectedItemNames.count ; i++) {
            SeletedMediItem * selectedItem = [[SeletedMediItem alloc] initWithString:selectedItemNames[i] :selectedItemImages[i]];
            [tempMediItem addObject:selectedItem];
        }
        _mediItem = tempMediItem;
        
    }
    
    return self;
}

@end
