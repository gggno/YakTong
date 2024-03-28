#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MediItems : NSObject

@property (nonatomic, assign) NSString * entpName;
@property (nonatomic, assign) NSString * itemName;
@property (nonatomic, assign) NSString * itemSeq;
@property (nonatomic, assign) NSString * efcyQesitm;
@property (nonatomic, assign) NSString * useMethodQesitm;
@property (nonatomic, assign) NSString * atpnWarnQesitm;
@property (nonatomic, assign) NSString * atpnQesitm;
@property (nonatomic, assign) NSString * intrcQesitm;
@property (nonatomic, assign) NSString * seQesitm;
@property (nonatomic, assign) NSString * depositMethodQesitm;
@property (nonatomic, assign) NSString * openDe;
@property (nonatomic, assign) NSString * updateDe;
@property (nonatomic, assign) NSString * itemImage;
@property (nonatomic, assign) NSString * bizrno;

- (id)initWithDictionary:(NSDictionary<NSString *, id> *)jsonDictionary;

@end

NS_ASSUME_NONNULL_END
