#import "ExpensesViewController.h"

#import "Expense.h"
#import "ConnectionManager.h"
#import "ExpenseAddViewController.h"
#import "ExpenseDetailViewController.h"

@interface ExpensesViewController ()
- (void)loadExpenses;
- (UIBarButtonItem *)newAddButton;
@end

@implementation ExpensesViewController

@synthesize expenses;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = @"Expenses";

    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [self newAddButton];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];  
    
    [self loadExpenses];
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //[[ConnectionManager sharedInstance] runJob:@selector(loadExpenses) 
    //                                onTarget:self]; 
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [expenses release];
    [super dealloc];
}

#pragma mark -
#pragma mark Actions

- (IBAction)add {
    ExpenseAddViewController *controller = 
        [[ExpenseAddViewController alloc] initWithStyle:UITableViewStyleGrouped];
    controller.delegate = self;
    Expense *expense = [[Expense alloc] init];
    controller.expense = expense;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    [expense release];
}

#pragma mark -
#pragma mark Table view methods

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    return [expenses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    static NSString *CellIdentifier = @"ExpenseCellId";
    
    UITableViewCell *cell = 
        [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                       reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    Expense *expense = [expenses objectAtIndex:indexPath.row];
    cell.textLabel.text = expense.name;
    cell.detailTextLabel.text = expense.amount;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView 
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView beginUpdates]; 
    if (editingStyle == UITableViewCellEditingStyleDelete) { 
        Expense *expense = [expenses objectAtIndex:indexPath.row];
        [expense destroyRemote];
        [expenses removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
                         withRowAnimation:UITableViewRowAnimationFade]; 
    }
    [tableView endUpdates]; 
}

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	ExpenseDetailViewController *controller = 
        [[ExpenseDetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
    controller.delegate = self;
	controller.expense = [expenses objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

#pragma mark -
#pragma mark Expense lifecycle delegates

- (void)didChangeExpense:(Expense *)expense {
    [self loadExpenses];
}

#pragma mark -
#pragma mark Private methods

- (void)loadExpenses {
    self.expenses = [Expense findAllRemote];
    [self.tableView reloadData];
    
//    [self.tableView performSelectorOnMainThread:@selector(reloadData) 
//                                     withObject:nil 
//                                  waitUntilDone:NO]; 
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (UIBarButtonItem *)newAddButton {
    return [[UIBarButtonItem alloc] 
            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  
                                 target:self 
                                 action:@selector(add)];    
}

@end
