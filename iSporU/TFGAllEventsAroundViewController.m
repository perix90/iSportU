//
//  TFGAllEventsAroundViewController.m
//  iSportU
//
//  Created by Pedro Gordillo Rios on 15/05/15.
//  Copyright (c) 2015 Pedro Gordillo Rios. All rights reserved.
//

#import "TFGAllEventsAroundViewController.h"

@interface TFGAllEventsAroundViewController ()
@end

@implementation TFGAllEventsAroundViewController


@synthesize MapView;
@synthesize tappedCoord;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    MapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    
    [self.locationManager startUpdatingLocation];
    
    MapView.showsUserLocation = YES;
    [MapView setMapType:MKMapTypeStandard];
    [MapView setZoomEnabled:YES];
    [MapView setScrollEnabled:YES];
    
    // This query is used to get the location of all events in the parse cloud database
    PFQuery *locationQuery = [PFQuery queryWithClassName:@"Event"];
    [locationQuery whereKeyExists:@"Eventlocation"];
    [locationQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
           
            
            // All the locations are stored in the objects NSArray
            
            for (PFObject *gp in objects) {
                
                // We store all the found locations in a PFGeoPoint object and then we have to transform this PFGeoPoints in real latitude/longitude coordinates via the CLLocationCoordinate2DMake method
                PFGeoPoint *location = [gp objectForKey:@"Eventlocation"];
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude);
                
                // Object used to make annotations on a map. TFGAnnotationMap is a custom superclass in which we store the annotations properties sucha as title,and thr coordinates
                TFGAnnotationMap *AllEventsAround = [[TFGAnnotationMap alloc]init];
                AllEventsAround.coordinate = coordinate; // We assign the coordinates got in CLLocationCoordinate2DMake to the coordinates of the TFGAnnotationMap superclass
                AllEventsAround.title = [gp valueForKey:@"Sportname"];
                
                // method call to point the annotations on the map
                [MapView addAnnotation:AllEventsAround];
                
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 5000, 5000);
    [self.MapView setRegion:[self.MapView regionThatFits:region] animated:YES];
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
    //In case a pin is selected, we perform a segue to the event's detail view. On the segue, the actual event coordinates are stored in tappedCoord and send to the details view controller
    
    TFGAnnotationMap *annotation=(TFGAnnotationMap*)view.annotation;
    self.tappedCoord = annotation.coordinate;
    
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKAnnotationView* pinView = [[MKPinAnnotationView alloc]
                                 initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
    pinView.canShowCallout=YES;
    //pinView.pinColor= MKPinAnnotationColorGreen;
    
    pinView.enabled = YES;
    pinView.canShowCallout = YES;
    
    
    pinView.image=[UIImage imageNamed:@"Icon.png"]; //here I am giving the image
    
    
    [self performSegueWithIdentifier:@"ToEventDetails" sender:self];   // Use your appropriate segue identifier
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Here we pass the bool value used in TFGResultsTableViewController to enable the Edit Event feature.
    if ([[segue identifier] isEqualToString:@"ToEventDetails"]){
        
        TFGEventDetailsViewController *controller = (TFGEventDetailsViewController *)segue.destinationViewController;
        controller.comefromMap = TRUE;
        controller.coordinates = tappedCoord;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
