//
//  TFGRegisterViewController.h
//  iSportU
//
//  Created by Pedro Gordillo Ríos on 01/12/14.
//  Copyright (c) 2014 desales. All rights reserved.
//

@interface TFGRegisterViewController : UIViewController


// Here we declare all the properties we will use

// SingleLineTextField is a custom class that gets the UITextFields a new appereance
@property (weak, nonatomic) IBOutlet SingleLineTextField *usernameRegister;
@property (weak, nonatomic) IBOutlet SingleLineTextField *passwordRegister;
@property (weak, nonatomic) IBOutlet SingleLineTextField *emailRegister;

// Here we declarea all the actions performed by the class
-(IBAction)Register:(id)sender;




@end
