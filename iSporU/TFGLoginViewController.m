//
//  TFGViewController.m
//  iSportU
//
//  Created by Pedro Gordillo Rios on 29/11/14.
//  Copyright (c) 2014 desales. All rights reserved.
//

#import "TFGLoginViewController.h"

@interface TFGLoginViewController ()

@end


@implementation TFGLoginViewController{
    
    MBProgressHUD *HUD;    
}

@synthesize Username;
@synthesize loginButton; // loginButton property (synthesized) used to modify the button's appereance.
@synthesize Password;
// This method is trigered when the login button is pressed.
- (IBAction)login:(id)sender{
    
    // We create a MBProgressHUD object in charge of the HUD activity indicator management
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // This block is just to customize teh MBProgressHUD
    HUD.dimBackground = YES;
    HUD.labelText = @"Login....";
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(loginAction) onTarget:self withObject:nil animated:YES];
    
    
    
    
}

- (void)loginAction {
    
    sleep(1);
    
    [PFUser logInWithUsernameInBackground:Username.text password:Password.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) [self performSegueWithIdentifier:@"toTabBarController" sender:self];
                                        else {
  
                                            [AZNotification showNotificationWithTitle:@"Error de login" controller:self notificationType:AZNotificationTypeError shouldShowNotificationUnderNavigationBar:YES];
                                            
                                        }
                                    }];
    
    

    
}
// The viewDidLoad methods is a special method. It triggers whatever is inside this methods just when the view has been lodaded
- (void)viewDidLoad{
    [super viewDidLoad];

    
    // This is to custom the textFields
    Username.lineDisabledColor = [UIColor cyanColor];
    Username.lineNormalColor = [UIColor grayColor];
    Username.lineSelectedColor = [UIColor blueColor];
    Username.inputTextColor = [UIColor blackColor];
    Username.inputPlaceHolderColor = [UIColor blackColor];
    Password.lineDisabledColor = [UIColor cyanColor];
    Password.lineNormalColor = [UIColor grayColor];
    Password.lineSelectedColor = [UIColor blueColor];
    Password.inputTextColor = [UIColor blackColor];
    Password.inputPlaceHolderColor = [UIColor blackColor];
 
}

// This method is just for hiding the keyboard by tapping anywhere in the screen
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
