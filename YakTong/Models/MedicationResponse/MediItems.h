#import <Foundation/Foundation.h>

@import FirebaseCore;
@import FirebaseFirestore;

NS_ASSUME_NONNULL_BEGIN

@interface MediItems : NSObject

@property (nonatomic, nullable, copy) NSString * entpName;
@property (nonatomic, nullable, copy) NSString * itemName;
@property (nonatomic, nullable, copy) NSString * itemSeq;
@property (nonatomic, nullable, copy) NSString * efcyQesitm;
@property (nonatomic, nullable, copy) NSString * useMethodQesitm;
@property (nonatomic, nullable, copy) NSString * atpnWarnQesitm;
@property (nonatomic, nullable, copy) NSString * atpnQesitm;
@property (nonatomic, nullable, copy) NSString * intrcQesitm;
@property (nonatomic, nullable, copy) NSString * seQesitm;
@property (nonatomic, nullable, copy) NSString * depositMethodQesitm;
@property (nonatomic, nullable, copy) NSString * openDe;
@property (nonatomic, nullable, copy) NSString * updateDe;
@property (nonatomic, nullable, copy) NSString * itemImage;
@property (nonatomic, nullable, copy) NSString * bizrno;

- (id)initWithDictionary:(NSDictionary<NSString *, id> *)jsonDictionary;
- (id)initWithSnapshot:(FIRDocumentSnapshot *)document;

@end

NS_ASSUME_NONNULL_END
