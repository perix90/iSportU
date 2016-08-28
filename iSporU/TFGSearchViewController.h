//
//  TFGSearchViewController.h
//  iSportU
//
//  Created by Pedro Gordillo Ríos on 3/1/15.
//  Copyright (c) 2015 Pedro Gordillo. All rights reserved.
//

@interface TFGSearchViewController : UIViewController <UIActionSheetDelegate,CLLocationManagerDelegate,UITextFieldDelegate>{
    
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    
    
}
@property (weak, nonatomic) IBOutlet SingleLineTextField *searchCity;
@property (weak, nonatomic) IBOutlet SingleLineTextField *searchDate;
@property (weak, nonatomic) IBOutlet SingleLineTextField *searchHour;

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) NSDate *selectedTime;
@property (nonatomic, assign) NSInteger selectedBigUnit;
@property (nonatomic, assign) NSInteger selectedSmallUnit;
@property (nonatomic, strong) AbstractActionSheetPicker *actionSheetPicker;



-(IBAction)goToActionSheet:(id)sender;
-(IBAction)selectADate:(id)sender;
-(IBAction)selectCity:(id)sender;
-(IBAction)SearchButton:(id)sender;
@end
