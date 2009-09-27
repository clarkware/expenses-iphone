#import <UIKit/UIKit.h>

#import "ExpenseAddViewController.h"

@interface ExpensesViewController : UITableViewController <ExpenseChangeDelegate> {
    NSMutableArray *expenses;
}

@property (nonatomic, retain) NSArray *expenses;

- (IBAction)add;

@end
