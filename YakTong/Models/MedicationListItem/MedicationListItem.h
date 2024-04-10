#import <Foundation/Foundation.h>
#import "SeletedMediItem.h"

@import FirebaseCore;
@import FirebaseFirestore;

NS_ASSUME_NONNULL_BEGIN

@interface MedicationListItem : NSObject

@property (nonatomic, nullable, copy) NSString * identifier;
@property (nonatomic, nullable, copy) NSString * disease;
@property (nonatomic, nullable, copy) NSDate * startDate;
@property (nonatomic, nullable, copy) NSDate * endDate;
@property (nonatomic, nullable, copy) NSMutableArray<SeletedMediItem *> * mediItem;

- (id)initWithDatas:(NSString *)identifier
                   :(NSString *)disease
                   :(NSDate *)startDate
                   :(NSDate *)endDate
                   :(NSMutableArray<SeletedMediItem *> *)mediItem;

- (id)initWithSnapshot:(FIRDocumentSnapshot *)document;

@end

NS_ASSUME_NONNULL_END
