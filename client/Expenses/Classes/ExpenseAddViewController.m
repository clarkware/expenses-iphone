#import "ExpenseAddViewController.h"
#import "Expense.h"

@interface ExpenseAddViewController ()
- (UIBarButtonItem *)newCancelButton;
- (UIBarButtonItem *)newSaveButton;
- (UITextField *)newTextField;
- (void)showAlert:(NSString *)message;
@end

@implementation ExpenseAddViewController

@synthesize expense;
@synthesize nameField;
@synthesize amountField;
@synthesize delegate;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    nameField = [self newTextField];
    nameField.keyboardType = UIKeyboardTypeASCIICapable;
    [nameField becomeFirstResponder];
    
    amountField = [self newTextField];
    amountField.keyboardType = UIKeyboardTypeNumberPad;

    if (expense.expenseId) {
        nameField.text = expense.name;
        amountField.text = expense.amount;
    } else {
        nameField.placeholder = @"Name";
        amountField.placeholder = @"Amount";
    }
    
    self.tableView.allowsSelection = NO;
    
    UIBarButtonItem *cancelButton = [self newCancelButton];
    self.navigationItem.leftBarButtonItem = cancelButton;
    [cancelButton release];
    
    UIBarButtonItem *saveButton = [self newSaveButton];
    self.navigationItem.rightBarButtonItem = saveButton;
    [saveButton release];        
} 

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	if (expense.expenseId) {
		self.title = @"Edit Expense";
    } else {
        self.title = @"New Expense";
	}
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [expense release];
    [nameField release];
    [amountField release];
    [super dealloc];
}

#pragma mark -
#pragma mark Actions

- (IBAction)cancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)save {
    if (([nameField.text length] == 0) || ([amountField.text length] == 0)) {
        [self showAlert:@"Please enter a name and an amount."];
        return;
    }
    
    expense.name = nameField.text;
    expense.amount = amountField.text;
    
    // If the model is new, then create will be called.
    // Otherwise the model will be updated.
    [expense saveRemote];
    
    [self.delegate didChangeExpense:expense];

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Table methods

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = 
        [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                reuseIdentifier:nil] autorelease];

    if (indexPath.row == 0)  {
        [cell.contentView addSubview:nameField];	
    } else { 
        [cell.contentView addSubview:amountField];	
    }
    
    return cell;
}

#pragma mark - 
#pragma mark Text Field delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField { 
    [textField resignFirstResponder];
    return YES; 
} 

#pragma mark - 
#pragma mark Private methods

- (UIBarButtonItem *)newCancelButton {
    return [[UIBarButtonItem alloc] 
            initWithTitle:@"Cancel" 
                    style:UIBarButtonSystemItemCancel 
                   target:self 
                   action:@selector(cancel)];
}

- (UIBarButtonItem *)newSaveButton {
    return [[UIBarButtonItem alloc]
            initWithTitle:@"Save" 
                    style:UIBarButtonSystemItemSave
                   target:self 
                   action:@selector(save)];
}

- (UITextField *)newTextField {
    UITextField *textField = 
        [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 250, 25)];
    textField.font = [UIFont systemFontOfSize:16];
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeyDone;
    return textField;
}  

- (void)showAlert:(NSString *)message {
	UIAlertView *alertView = 
        [[UIAlertView alloc] initWithTitle:@"Whoops" 
                                   message:message
                                  delegate:nil 
                         cancelButtonTitle:@"OK" 
                         otherButtonTitles:nil];
    [alertView show];
	[alertView release];
}
@end
