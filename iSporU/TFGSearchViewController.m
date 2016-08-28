//
//  TFGSearchViewController.m
//  iSportU
//
//  Created by Pedro Gordillo Ríos on 3/1/15.
//  Copyright (c) 2015 Pedro Gordillo. All rights reserved.
//

#import "TFGSearchViewController.h"



@interface TFGSearchViewController ()

@end

@implementation TFGSearchViewController

@synthesize searchCity;
@synthesize searchDate;
@synthesize searchHour;

- (IBAction)SearchButton:(id)sender{
    
    
}

- (IBAction)selectADate:(UIControl *)sender {
   

    NSDate *today= [NSDate date];
    NSMutableArray *listofdates = [[NSMutableArray alloc]init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"dd-MM-yyyy"];
    
    // Loop through 7 days
    for (int i = 0; i < 7; i++) {
        
        NSDateComponents *componentsForFireDate = [[NSDateComponents alloc] init];
        [componentsForFireDate setWeekday: 1] ; // Add 7 days
        today = [[NSCalendar currentCalendar] dateByAddingComponents:componentsForFireDate toDate:today options:0];
        NSString *dateString = [formatter stringFromDate:today];
        [listofdates addObject:dateString];
    }
    
    
    // This is a Custom method that combines the UIActionSheet with a UIPickerView
    [ActionSheetStringPicker showPickerWithTitle:@"Select a date" rows:listofdates initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        
        searchDate.text = selectedValue; // Here we show the selected value from the "slot machine" in the city TextField
    }
     
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                     } origin:sender];

}

- (IBAction)selectCity:(id)sender {
    
    
    NSArray *listCities = [NSArray arrayWithObjects:@"Alicante", @"Barcelona", @"Ceuta", @"Madrid", @"Murcia",@"Valencia",nil];
    [ActionSheetStringPicker showPickerWithTitle:@"Select a date" rows:listCities initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        
        searchCity.text = selectedValue;
    }
     
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                     } origin:sender]; // You can also use self.view if you don't have a sender
}




- (IBAction)selectAHour:(UIControl *)sender {
    
    
    NSArray *Hours = [NSArray arrayWithObjects:@"08:00", @"08:30", @"09:00", @"09:30", @"10:00", @"10:30", @"11:00", @"11:30", @"12:00", @"12:30", @"13:00", @"13:30",@"14:00", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select a date" rows:Hours initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        
        searchHour.text = selectedValue;
    }
     
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                     } origin:sender]; // You can also use self.view if you don't have a sender
    
}





-(IBAction)goToActionSheet:(id)sender{
    
    
    PFUser *currentUser = [PFUser currentUser];
    
    if(currentUser == nil){
        
        
        UIActionSheet *showOptions = [[UIActionSheet alloc] initWithTitle:@"Que desea hacer?" delegate:self cancelButtonTitle:@"Cancel Button" destructiveButtonTitle:nil otherButtonTitles:@"Login", @"Register", nil];
        showOptions.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [showOptions showInView:self.view];
        
    }else{
        
        [self performSegueWithIdentifier:@"ToUserProfile" sender:self];
        
    }
    
   
    
    
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    switch (buttonIndex) {
        case 0:
            
           [self performSegueWithIdentifier:@"ToLogin" sender:self];
            
            break;
            
        case 1:
            
            [self performSegueWithIdentifier:@"ToRegister" sender:self];
            
            
            break;
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc]init];
    geocoder = [[CLGeocoder alloc] init];
    /*
     
     usernameRegister.lineDisabledColor = [UIColor cyanColor];
     usernameRegister.lineNormalColor = [UIColor grayColor];
     usernameRegister.lineSelectedColor = [UIColor blueColor];
     usernameRegister.inputTextColor = [UIColor blackColor];
     usernameRegister.inputPlaceHolderColor = [UIColor blackColor];
     
     */
    searchCity.lineDisabledColor = [UIColor cyanColor];
    searchCity.lineNormalColor = [UIColor grayColor];
    searchCity.lineSelectedColor = [UIColor blueColor];
    searchCity.inputTextColor = [UIColor blackColor];
    searchCity.inputPlaceHolderColor = [UIColor blackColor];
    
    searchDate.lineDisabledColor = [UIColor cyanColor];
    searchDate.lineNormalColor = [UIColor grayColor];
    searchDate.lineSelectedColor = [UIColor blueColor];
    searchDate.inputTextColor = [UIColor blackColor];
    searchDate.inputPlaceHolderColor = [UIColor blackColor];
    
    searchHour.lineDisabledColor = [UIColor cyanColor];
    searchHour.lineNormalColor = [UIColor grayColor];
    searchHour.lineSelectedColor = [UIColor blueColor];
    searchHour.inputTextColor = [UIColor blackColor];
    searchHour.inputPlaceHolderColor = [UIColor blackColor];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// This method is just for hiding the keyboard by tapping anywhere in the screen

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - Navigation



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
    // Here we pass the 3 TextFields as parameters for the queries
    
    
    if ([[segue identifier] isEqualToString:@"toSearchResults"]){
        
        TFGResultsTableViewController *controller = (TFGResultsTableViewController *)segue.destinationViewController;
        controller.citysearchParameter = searchCity.text;
        
        TFGResultsTableViewController *controller2 = (TFGResultsTableViewController *)segue.destinationViewController;
        controller2.datesearchParameter = searchDate.text;
        
        TFGResultsTableViewController *controller3 = (TFGResultsTableViewController *)segue.destinationViewController;
        controller3.hoursearchParameter = searchHour.text;
    }
    
    
    
    
    
}
 



@end
