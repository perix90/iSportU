//
//  TFGAddEventViewController.h
//  iSporU
//
//  Created by Pedro Gordillo Rios on 11/03/15.
//  Copyright (c) 2015 Pedro Gordillo Rios. All rights reserved.
//

@interface TFGAddEventViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate,MBProgressHUDDelegate>{
    IBOutlet UIScrollView *scroller;
}


// Here we declare all the properties we will use
@property (weak, nonatomic) IBOutlet MKMapView *MapView;
@property(nonatomic, retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet SingleLineTextField *EventName;
@property (weak, nonatomic) IBOutlet SingleLineTextField *EventDate;
@property (weak, nonatomic) IBOutlet SingleLineTextField *EventHour;
@property (weak, nonatomic) IBOutlet SingleLineTextField *SportTextField;
@property (weak, nonatomic) IBOutlet SingleLineTextField *Vacants;
@property (weak, nonatomic) IBOutlet SingleLineTextField *EventCity;
@property (weak, nonatomic) IBOutlet UIButton *addEventButton;
@property (nonatomic) long int row;
// Properties used as a receiver of the actual Sport selected in the TFGSelectSportTableViewController Class
@property (weak, nonatomic) NSString *Sport;
@property (nonatomic) bool EditMode;


// Here we declare all the Actions triggered in the class
-(IBAction)CreateEvent:(id)sender;
-(IBAction)selectAHour:(UIControl *)sender;
-(IBAction)selectDate:(id)sender;
-(IBAction)selectVacants:(id)sender;
@end
