#import <Foundation/Foundation.h>

@interface DateHelper : NSObject {
}

+ (NSString *)formatDate:(NSDate *)date;
+ (NSDate *)parseDateTime:(NSString *)dateTimeString;

@end
