#import "ExpensesAppDelegate.h"

#import "ObjectiveResourceConfig.h"

@implementation ExpensesAppDelegate

@synthesize window;
@synthesize navigationController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {        
    
#if TARGET_IPHONE_SIMULATOR
    [ObjectiveResourceConfig setSite:@"http://localhost:3000/"];
#else
    [ObjectiveResourceConfig setSite:@"https://your-server.com/"];
#endif  
    [ObjectiveResourceConfig setUser:@"John"];
    [ObjectiveResourceConfig setPassword:@"Appleseed"];
    [ObjectiveResourceConfig setResponseType:JSONResponse];
        
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
}

- (void)dealloc {
    [navigationController release];
    [window release];
    [super dealloc];
}

@end

