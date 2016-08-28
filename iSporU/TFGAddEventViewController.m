//
//  TFGAddEventViewController.m
//  iSporU
//
//  Created by Pedro Gordillo Rios on 11/03/15.
//  Copyright (c) 2015 Pedro Gordillo Rios. All rights reserved.
//

#import "TFGAddEventViewController.h"


@interface TFGAddEventViewController (){
    MBProgressHUD *HUD;
}

@end

@implementation TFGAddEventViewController

// We need to synthesize the properties declared in the header file to initialize them. It's like the getter and setter in Java.
@synthesize EventName;
@synthesize EventDate;
@synthesize EventHour;
@synthesize Vacants;
@synthesize EventCity;
@synthesize SportTextField;
@synthesize Sport;
@synthesize EditMode;
@synthesize addEventButton;
@synthesize MapView;
@synthesize row;

// These are all the implementation codes for the Actions to be performed
- (IBAction)selectAHour:(UIControl *)sender {
    
    // We have an Array of Hours here declared an initialized with random cities
    NSArray *Hours = [NSArray arrayWithObjects:@"08:00", @"08:30", @"09:00", @"09:30", @"10:00", @"10:30", @"11:00", @"11:30", @"12:00", @"12:30", @"13:00", @"13:30",@"14:00", nil];
    
    // This is a Custom method that combines the UIActionSheet with a UIPickerView
    [ActionSheetStringPicker showPickerWithTitle:@"Select a hour" rows:Hours initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        
        EventHour.text = selectedValue; // Here we show the selected value from the "slot machine" in the city TextField
    }
     
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                     }
                                          origin:sender];
}
- (IBAction)CreateEvent:(id)sender{
    
    
    // We create the custom HUD progress View
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.dimBackground = YES;
    HUD.labelText = @"Creando Evento....";
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(CreateEventAction) onTarget:self withObject:nil animated:YES];
    
    
}
- (IBAction)selectDate:(id)sender{
    
    // We get today's date
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
        
        EventDate.text = selectedValue; // Here we show the selected value from the "slot machine" in the city TextField
    }
     
                                     cancelBlock:^(ActionSheetStringPicker *picker) { }
                                          origin:sender];
    
    
    
}
- (IBAction)selectVacants:(id)sender{
    
    // array with the number of vacants from 0 to 10.
    NSArray *numberofvacants = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];

    // This is a Custom method that combines the UIActionSheet with a UIPickerView
    [ActionSheetStringPicker showPickerWithTitle:@"Numero de Vacantes" rows:numberofvacants initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        
        Vacants.text = selectedValue; // Here we show the selected value from the "slot machine" in the city TextField
    }
     
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                     } origin:sender];
}


// Selector of the custom HUD
- (void)CreateEventAction {
    
    sleep(2);
    
    // To create an Event, we have to initialize the current user logged in by using PFUSer from Parse.
    // Then we do the same but with an Event by using PFObject.
    // Then we just add it => Event[@"XXX"] represents a column XXX from the table named Event.
    // Then we call saveInBackgroundWithBlock to make the save function to work
    
    if([EventName.text length] > 25 ){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Demasiados caracteres en nombre del evento "
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"Vale"
                                              otherButtonTitles:nil];
        [alert show];
        
        
    }
    else{
        
        if(EditMode == 1){ // This means that an event will be edited
            
            // We perform the query to get the event that the User wants to edit
            PFQuery *getObjectIDforRow = [PFQuery queryWithClassName:@"Event"];
            [getObjectIDforRow selectKeys:@[@"objectId"]]; // We decide which fields to get
            [getObjectIDforRow whereKey:@"Username" equalTo:PFUser.currentUser.username];
            [getObjectIDforRow findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    
                    // We save the Object ID found in a NSString
                    NSString *ObjectID = [NSString stringWithFormat:@"%@", [objects[row] valueForKey:@"objectId"]];
                    
                    
                    // Now that we have The ObjectId to edit the event, let's edit it
                    PFObject *Event = [PFObject objectWithoutDataWithClassName:@"Event" objectId:ObjectID];
                    [Event setObject:EventName.text forKey:@"EventName"];
                    [Event setObject:EventDate.text forKey:@"Date"];
                    [Event setObject:EventHour.text forKey:@"Hour"];
                    [Event setObject:Event[@"Vacants"] = [NSNumber numberWithFloat: [self.Vacants.text intValue]] forKey:@"Vacants"];
                    [Event saveInBackground];
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }else{
            
            // Not being in Edit Mode means that the User will create a new event.
            
            // We get the latitude and longitude coordinates of the map which are obtained in the longpressbutton gesture method below
            TFGStorePinCoordinates *StoreCoordinates = [TFGStorePinCoordinates sharedInstance];
            
            
            // we initialize the current user and a new event to add. Also we need to store the geopoints as well
            PFUser *currentUser = [PFUser currentUser];
            PFObject *Event = [PFObject objectWithClassName:@"Event"];
            PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:[StoreCoordinates.latitude doubleValue] longitude:[StoreCoordinates.longitude doubleValue]];
            
            Event[@"EventName"] = EventName.text;
            Event[@"Date"] = EventDate.text;
            Event[@"City"] = EventCity.text;
            Event[@"Hour"] = EventHour.text;
            Event[@"Sportname"] = SportTextField.text;
            Event[@"Vacants"] = [NSNumber numberWithFloat: [self.Vacants.text intValue]];
            Event[@"Username"] = currentUser.username;
            Event[@"Eventlocation"] = point;
            [Event saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) [self performSegueWithIdentifier:@"toTabBarController" sender:self];
            }];
            
        }
    }
}

// This block is used to locate the user
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1500, 1500);
    [self.MapView setRegion:[self.MapView regionThatFits:region] animated:YES];
}

// The viewDidLoad methods is a special method. It triggers whatever is inside this methods just when the view has been lodaded
- (void)viewDidLoad{
    [super viewDidLoad];
    
    // At the time the view loads, the Sport name is assigned to the Sport TextField
    SportTextField.text = Sport;
    
    // This block is to start the location service
    self.locationManager = [[CLLocationManager alloc] init];
    MapView.delegate = self;
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    MapView.showsUserLocation = YES;
    [MapView setMapType:MKMapTypeStandard];
    [MapView setZoomEnabled:YES];
    [MapView setScrollEnabled:YES];
    
    
    
    // This block is to create a long press gesture recognizer. At a long pressure, the selector is trigerred
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self.MapView addGestureRecognizer:longPressGesture];
    
    
    // If we are editing an event, some fields will be disabled to be edited.
    if(EditMode == 1){
        
        [addEventButton setTitle:@"Edit Event" forState:UIControlStateNormal];
        EventCity.enabled = NO;
        EventCity.text = @"NOT EDITABLE";
        SportTextField.enabled = NO;
        SportTextField.text = @"NOT EDITABLE";
    }
    
}
- (void)handleLongPressGesture:(UIGestureRecognizer*)gesture {
    
    if (gesture.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gesture locationInView:self.MapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.MapView convertPoint:touchPoint toCoordinateFromView:self.MapView];
    
    TFGAnnotationMap *toAdd = [[TFGAnnotationMap alloc]init];
    toAdd.coordinate = touchMapCoordinate;
    toAdd.title = SportTextField.text;
    
    TFGStorePinCoordinates *StoreCoordinates = [TFGStorePinCoordinates sharedInstance];
    StoreCoordinates.latitude = [NSString stringWithFormat:@"%f",touchMapCoordinate.latitude];
    StoreCoordinates.longitude = [NSString stringWithFormat:@"%f",touchMapCoordinate.longitude];
    
    
    [self.MapView addAnnotation:toAdd];
    
    
    [[[CLGeocoder alloc]init] reverseGeocodeLocation:[[CLLocation alloc]initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude] completionHandler:^(NSArray *placemarks, NSError *error) {
                                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                                       
                                       
                                       EventCity.text = placemark.locality;
                                   }
     ];
    
    
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// This method is just for hiding the keyboard by tapping anywhere in the screen
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}







@end
