//
//  TFGMyEventsViewController.h
//  iSportU
//
//  Created by Pedro Gordillo Ríos on 27/12/14.
//  Copyright (c) 2014 Pedro Gordillo. All rights reserved.
//

@interface TFGMyEventsViewController : UIViewController <UIActionSheetDelegate>

// Here we declare all the properties we will use
@property (weak, nonatomic) IBOutlet UIBarButtonItem *NavBarItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoffButton;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UIButton *createdeventsButton;
@property (weak, nonatomic) IBOutlet UIButton *joinedeventsButton;
@property (strong, nonatomic) CLLocationManager *locationManager;
// Here we declare all the Actions triggered in the class
-(IBAction)goToActionSheet:(id)sender;
-(IBAction)LogOut:(id)sender;

@end
