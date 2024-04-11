#import "NSDate+convertDateToString.h"

@implementation NSDate (convertDateToString)

+ (NSString *)convertDateToString:(NSDate *)date
{
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *stringFromDate = [dateFormatter stringFromDate:date];
    
    return stringFromDate;
}

@end
