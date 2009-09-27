#import "Expense.h"

@implementation Expense

@synthesize expenseId;
@synthesize name;
@synthesize amount;
@synthesize createdAt;
@synthesize updatedAt;

- (void)dealloc {
    [expenseId release];
    [name release];
    [amount release];
    [createdAt release];
    [updatedAt release];
    [super dealloc];
}

@end
