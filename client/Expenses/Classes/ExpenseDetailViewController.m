#import "ExpenseDetailViewController.h"

#import "Expense.h"
#import "DateHelper.h"

@interface ExpenseDetailViewController ()
- (UIBarButtonItem *)newEditButton;
@end

@implementation ExpenseDetailViewController

@synthesize expense;
@synthesize delegate;

enum ExpenseTableSections {
	kNameSection = 0,
    kAmountSection,
	kDateSection
};

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.allowsSelection = NO;
    
    UIBarButtonItem *editButton = [self newEditButton];
	self.navigationItem.rightBarButtonItem = editButton;
    [editButton release];    
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	self.title = expense.name;
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [expense release];
    [super dealloc];
}

#pragma mark -
#pragma mark Actions

- (IBAction)edit {
	ExpenseAddViewController *controller = 
        [[ExpenseAddViewController alloc] initWithStyle:UITableViewStyleGrouped];
    controller.delegate = delegate;
	controller.expense = expense;
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
}


#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView 
titleForHeaderInSection:(NSInteger)section {
    NSString *title = nil;
    switch (section) {
		case kNameSection:
			title = @"Name";
            break;
		case kAmountSection:
			title = @"Amount";
            break;
        case kDateSection:
			title = @"Date";
            break;
	}
  	return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"ExpenseCellId";
	
	UITableViewCell *cell = 
        [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier] autorelease];
	}
    
	switch (indexPath.section) {
		case kNameSection:
			cell.textLabel.text = expense.name;
			break;
		case kAmountSection:
            cell.textLabel.text = expense.amount;
            break;
        case kDateSection:
            cell.textLabel.text = [DateHelper formatDate:expense.createdAt];
            break;
	}

	return cell;
}

#pragma mark -
#pragma mark Private methods

- (UIBarButtonItem *)newEditButton {
    return [[UIBarButtonItem alloc] 
            initWithBarButtonSystemItem:UIBarButtonSystemItemEdit 
                                 target:self 
                                 action:@selector(edit)];
}

@end
