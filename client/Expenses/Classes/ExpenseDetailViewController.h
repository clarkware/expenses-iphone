#import <UIKit/UIKit.h>

#import "ExpenseAddViewController.h"

@class Expense;

@interface ExpenseDetailViewController : UITableViewController {
    Expense *expense;
    id <ExpenseChangeDelegate> delegate;
}

@property (nonatomic, retain) Expense *expense;
@property (nonatomic, assign) id <ExpenseChangeDelegate> delegate;

- (IBAction)edit;

@end
