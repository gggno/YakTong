#import "SeletedMediItem.h"

@protocol MediListDelegate <NSObject>

-(void)addMediList:(NSString *)disease
                  :(NSDate *)startDate
                  :(NSDate *)endDate
                  :(NSMutableArray<SeletedMediItem *> *)mediItem;

@end


