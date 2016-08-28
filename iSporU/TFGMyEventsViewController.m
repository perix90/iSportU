//
//  TFGMyEventsViewController.m
//  iSportU
//
//  Created by Pedro Gordillo Ríos on 27/12/14.
//  Copyright (c) 2014 Pedro Gordillo. All rights reserved.
//

#import "TFGMyEventsViewController.h"

@interface TFGMyEventsViewController ()

@end

@implementation TFGMyEventsViewController

@synthesize userLabel;
@synthesize NavBarItem;
@synthesize joinedeventsButton;
@synthesize createdeventsButton;
@synthesize logoffButton;

- (IBAction)goToActionSheet:(id)sender{
   
    // If the current user is authenticated via the parse secure login, then go to the corresponding user profile. If not, show options of login/register
    PFUser *currentUser = [PFUser currentUser];
    
    if(!currentUser.isAuthenticated){
        
        UIActionSheet *showOptions = [[UIActionSheet alloc] initWithTitle:@"Que desea hacer?" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Login", @"Registrarse", nil];
        showOptions.actionSheetStyle = UIActionSheetStyleAutomatic;
        [showOptions showInView:self.view];
        
    }else [self performSegueWithIdentifier:@"ToUserProfile" sender:self];
}
- (IBAction)LogOut:(id)sender{
    
    PFUser *currentUser = [PFUser currentUser];
    
    if(currentUser){
        
        [PFUser logOut];
        userLabel.text = @"Invitado";
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:FALSE];
        createdeventsButton.enabled = NO;
        joinedeventsButton.enabled = NO;
        logoffButton.enabled = NO;
        
    }

    if(currentUser){
        
        [AZNotification showNotificationWithTitle:@"Usuario deslogueado " controller:self notificationType:AZNotificationTypeMessage shouldShowNotificationUnderNavigationBar:YES];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            
            [self performSegueWithIdentifier:@"ToLogin" sender:self];
            
            break;
            
        case 1:
            
            [self performSegueWithIdentifier:@"ToRegister" sender:self];
            
            
            break;
    }
    
}
// The viewDidLoad methods is a special method. It triggers whatever is inside this methods just when the view has been loaded
- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    // we call this method at the view's load to check whether there's an active internet connection. If there is not, some elements are disabled
    [self checkInternet:^(BOOL internet) {
         if (!internet){
             [PFUser logOut];
                 [AZNotification showNotificationWithTitle:@"Compruebe conexion a internet" controller:self notificationType:AZNotificationTypeWarning shouldShowNotificationUnderNavigationBar:YES];
             
            userLabel.text = @"Invitado";
            [[[[self.tabBarController tabBar]items]objectAtIndex:0]setEnabled:FALSE];
            [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:FALSE];
            
            createdeventsButton.enabled = NO;
            joinedeventsButton.enabled = NO;
            NavBarItem.enabled = YES;
            logoffButton.enabled = NO;
             
         }
     }];
    
    
    // This block is just to show the username in case the user is logged in. Otherwise, it shows a "guest" text
    PFUser *currentUser = [PFUser currentUser];
    if(currentUser && currentUser.isAuthenticated){
        userLabel.text = currentUser.username;
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:TRUE];
       
    }else{
        
        userLabel.text = @"Invitado";
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:FALSE]; // We disable the ADD function if theres no user logged on.
        logoffButton.enabled = NO;
        createdeventsButton.enabled = NO;
        joinedeventsButton.enabled = NO;
    }
    
    
    
}

// The wiewWillAppear methods is a special method. It triggers whatever is inside this methods just when the view will visually appear.
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    PFUser *currentUser = [PFUser currentUser];
    if(currentUser && currentUser.isAuthenticated){
        
        
        userLabel.text = currentUser.username;
        
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:TRUE];
        
    }else{
        
        userLabel.text = @"Invitado";
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:FALSE]; // We disable the ADD function if theres no user logged on.
        logoffButton.enabled = NO;
        createdeventsButton.enabled = NO;
        joinedeventsButton.enabled = NO;
    }
    
}



// This method is just for hiding the keyboard by tapping anywhere in the screen
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Block with method to check internet conectivity
typedef void(^connection)(BOOL);
- (void)checkInternet:(connection)block {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURL *url = [NSURL URLWithString:@"http://www.google.com/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"HEAD";
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    request.timeoutInterval = 10.0;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         block([(NSHTTPURLResponse *)response statusCode] == 200);
     }];
}



@end