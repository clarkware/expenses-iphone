#import <UIKit/UIKit.h>

@class Expense;

@protocol ExpenseChangeDelegate <NSObject>
- (void)didChangeExpense:(Expense *)expense;
@end

@interface ExpenseAddViewController : UITableViewController <UITextFieldDelegate> {
    UITextField *nameField;
    UITextField *amountField;
    Expense     *expense;
    id <ExpenseChangeDelegate> delegate;
}

@property (nonatomic, retain) UITextField *nameField;
@property (nonatomic, retain) UITextField *amountField;
@property (nonatomic, retain) Expense *expense;
@property (nonatomic, assign) id <ExpenseChangeDelegate> delegate;

- (IBAction)cancel;
- (IBAction)save;

@end
