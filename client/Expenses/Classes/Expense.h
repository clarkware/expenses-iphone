#import "ObjectiveResource.h"

@interface Expense : NSObject {
    NSString *expenseId;
    NSString *name;
    NSString *amount;
    NSDate *createdAt;
    NSDate *updatedAt;
}

@property (nonatomic, copy) NSString *expenseId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, retain) NSDate *createdAt;
@property (nonatomic, retain) NSDate *updatedAt;
    
@end