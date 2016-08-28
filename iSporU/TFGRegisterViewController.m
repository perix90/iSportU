//
//  TFGRegisterViewController.m
//  iSportU
//
//  Created by Pedro Gordillo Ríos on 01/12/14.
//  Copyright (c) 2014 desales. All rights reserved.
//

#import "TFGRegisterViewController.h"


@interface TFGRegisterViewController ()

@end

@implementation TFGRegisterViewController

// We need to synthesize the properties declared in the header file
@synthesize usernameRegister;
@synthesize passwordRegister;
@synthesize emailRegister;


// These are all the implementation codes for the Actions to be performed
- (IBAction)Register:(id)sender{
    
    // We create a new PFUser with an username, password, and email. Right afterwars, a signup will be performed.
    PFUser *newuser = [PFUser user];
    newuser.username = usernameRegister.text;
    newuser.password = passwordRegister.text;
    newuser.email = emailRegister.text;
    [newuser signUp];
}

// The viewDidLoad methods is a special method. It triggers whatever is inside this methods just when the view has been lodaded
- (void)viewDidLoad{
    [super viewDidLoad];

    
}

// This method is to trigger an action when the application suddenly comes visible to the user from the background
- (void)applicationEnteredForeground:(NSNotification *)notification {


}

// This method is just for hiding the keyboard by tapping anywhere in the screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
