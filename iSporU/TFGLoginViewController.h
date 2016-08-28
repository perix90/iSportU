//
//  TFGViewController.h
//  iSportU
//
//  Created by Pedro Gordillo Rios on 29/11/14.
//  Copyright (c) 2014 desales. All rights reserved.
//

@interface TFGLoginViewController : UIViewController <MBProgressHUDDelegate>


// We declare the properties in order to use it in the login screen
@property (weak, nonatomic) IBOutlet SingleLineTextField *Username; // The Username
@property (weak, nonatomic) IBOutlet SingleLineTextField *Password; // The password
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

// Here we declare all the Actions triggered in the class
-(IBAction)login:(id)sender;



@end




