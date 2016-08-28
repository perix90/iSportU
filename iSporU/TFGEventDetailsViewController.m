//
//  TFGEventDetailsViewController.m
//  iSportU
//
//  Created by Pedro Gordillo Rios on 14/05/15.
//  Copyright (c) 2015 Pedro Gordillo Rios. All rights reserved.
//

#import "TFGEventDetailsViewController.h"


#define MINIMUM_ZOOM_ARC 0.014 //approximately 1 miles (1 degree of arc ~= 69 miles)
#define ANNOTATION_REGION_PAD_FACTOR 1.15
#define MAX_DEGREES_ARC 360
@interface TFGEventDetailsViewController (){
    
    MBProgressHUD *HUD;
}

@end

@implementation TFGEventDetailsViewController
@synthesize date;
@synthesize dateLabel;
@synthesize hour;
@synthesize hourLabel;
@synthesize city;
@synthesize cityLabel;
@synthesize sport;
@synthesize ImageImageView;
@synthesize comefromMap;
@synthesize coordinates;
@synthesize pointNOmap;
@synthesize MapView;
@synthesize joinButton;
@synthesize userjoinedornotLabel;

- (void)checkUserJoinedOrCreateEventNOmap {
    
    // We run 3 queries (from outside to inside)
    // 1.- We get the Object ID of the event for which we want to perform the check
    // 2.- Once we have the ObjectID, we perform the second and third query which both of them make the actual check.
    PFQuery *getObjectWithLocationPoint = [PFQuery queryWithClassName:@"Event"];
    [getObjectWithLocationPoint selectKeys:@[@"objectId"]]; // We decide which fields to get
    [getObjectWithLocationPoint findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            PFQuery *checkUserHasJoined = [PFQuery queryWithClassName:@"Event"];
            PFQuery *checkUserisCreator = [PFQuery queryWithClassName:@"Event"];
            
            [getObjectWithLocationPoint selectKeys:@[@"Participants"]];
            [checkUserHasJoined whereKey:@"Eventlocation" equalTo:pointNOmap];
            [checkUserHasJoined whereKey:@"Participants" equalTo:[PFUser currentUser].username];
            
            [getObjectWithLocationPoint selectKeys:@[@"Participants"]];
            [checkUserisCreator whereKey:@"Eventlocation" equalTo:pointNOmap];
            [checkUserisCreator whereKey:@"Username" equalTo:[PFUser currentUser].username];
            
            // Here we get all the events which are located in a -previosly determined- location and for which the current user is a participant. If the query returns at least 1 value, it means that the user has joined the event
            [checkUserHasJoined findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                   if(objects.count == 1) {
                            userjoinedornotLabel.hidden = NO;
                            joinButton.hidden = YES;
                            [userjoinedornotLabel setText:[NSString stringWithFormat:@"%@, ya estas unido a este evento :)",[PFUser currentUser].username]];
                        }
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
            
            // Here we get all the events which are located in a -previosly determined- location and for which the current user is the creator. If the query returns at least 1 value, it means that the user has created that event
            [checkUserisCreator findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                        
                        if(objects.count == 1) {
                            userjoinedornotLabel.hidden = NO;
                            joinButton.hidden = YES;
                            [userjoinedornotLabel sizeToFit];
                            [userjoinedornotLabel setText:[NSString stringWithFormat:@"%@,no puedes unirte a tu propio evento :)",[PFUser currentUser].username]];
                        }
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}
- (void)checkUserJoinedOrCreateEventFROMmap:(PFGeoPoint *)point {
   
    
    // We run 3 queries (from outside to inside)
    // 1.- We get the Object ID of the event for which we want to perform the check
    // 2.- Once we have the ObjectID, we perform the second and third query which both of them make the actual check.
    PFQuery *getObjectWithLocationPoint = [PFQuery queryWithClassName:@"Event"];
    [getObjectWithLocationPoint selectKeys:@[@"objectId"]]; // We decide which fields to get
    [getObjectWithLocationPoint findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            PFQuery *checkUserHasJoined = [PFQuery queryWithClassName:@"Event"];
            PFQuery *checkUserisCreator = [PFQuery queryWithClassName:@"Event"];
            
            [getObjectWithLocationPoint selectKeys:@[@"Participants"]];
            [checkUserHasJoined whereKey:@"Eventlocation" equalTo:point];
            [checkUserHasJoined whereKey:@"Participants" equalTo:[PFUser currentUser].username];
            
            [getObjectWithLocationPoint selectKeys:@[@"Participants"]];
            [checkUserisCreator whereKey:@"Eventlocation" equalTo:point];
            [checkUserisCreator whereKey:@"Username" equalTo:[PFUser currentUser].username];
            
            // Here we get all the events which are located in a -previosly determined- location and for which the current user is a participant. If the query returns at least 1 value, it means that the user has joined the event
            
            [checkUserHasJoined findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    
                        if(objects.count == 1) {
                            userjoinedornotLabel.hidden = NO;
                            joinButton.hidden = YES;
                            [userjoinedornotLabel setText:[NSString stringWithFormat:@"%@, ya estas unido a este evento :)",[PFUser currentUser].username]];
                        }
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
            
            
            // Here we get all the events which are located in a -previosly determined- location and for which the current user is the creator. If the query returns at least 1 value, it means that the user has created that event
            [checkUserisCreator findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {

                        if(objects.count == 1) {
                            userjoinedornotLabel.hidden = NO;
                            joinButton.hidden = YES;
                            [userjoinedornotLabel sizeToFit];
                            [userjoinedornotLabel setText:[NSString stringWithFormat:@"%@,no puedes unirte a tu propio evento :)",[PFUser currentUser].username]];
  
                        }
                    
                    
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
   
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}
- (void)findPinLocationNOmap {
    
    
    PFQuery *locationQuery = [PFQuery queryWithClassName:@"Event"];
    [locationQuery whereKey:@"Eventlocation" equalTo:pointNOmap];
    [locationQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            
            
            for (PFObject *gp in objects) {
                
                //How to get PFGeoPoint and then a location out of an object
                PFGeoPoint *location = [gp objectForKey:@"Eventlocation"];
                
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude);
                
                TFGAnnotationMap *AllEventsAround = [[TFGAnnotationMap alloc]init];
                
                
                
                AllEventsAround.coordinate = coordinate;
                AllEventsAround.title = [gp valueForKey:@"Sportname"];
                [MapView addAnnotation:AllEventsAround];
                
                
                
            }
            
            
            
            [self checkUserJoinedOrCreateEventNOmap];
            
            dateLabel.text = date;
            hourLabel.text = hour;
            cityLabel.text = city;
            
            
            
            if([sport isEqualToString:@"Futbol"])
                ImageImageView.image = [UIImage imageNamed:@"SoccerBallIcon.png"];
            else if([sport isEqualToString:@"Correr"])
                ImageImageView.image = [UIImage imageNamed:@"runIcon.png"];
            else if ([sport isEqualToString:@"Balonmano"])
                ImageImageView.image = [UIImage imageNamed:@"HandballIcon.png"];
            else if ([sport isEqualToString:@"Baloncesto"])
                ImageImageView.image = [UIImage imageNamed:@"BasketballIcon.png"];
            else if ([sport isEqualToString:@"Padel"])
                ImageImageView.image = [UIImage imageNamed:@"TennisBallIcon.png"];
            else if ([sport isEqualToString:@"Tennis"])
                ImageImageView.image = [UIImage imageNamed:@"TennisBallIcon.png"];
            else if ([sport isEqualToString:@"Senderismo"])
                ImageImageView.image = [UIImage imageNamed:@"Senderismo.jpg"];
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}
- (void)findPinLocationWITHmap:(PFGeoPoint *)point {
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query whereKey:@"Eventlocation" equalTo:point];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            for (PFObject *object in objects) {
                
                PFGeoPoint *location = [object objectForKey:@"Eventlocation"];
                

                
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude);
                
                TFGAnnotationMap *AllEventsAround = [[TFGAnnotationMap alloc]init];
                
                
                
                AllEventsAround.coordinate = coordinate;
                AllEventsAround.title = [object valueForKey:@"Sportname"];
                [MapView addAnnotation:AllEventsAround];
                
                
                
                
                
                [self checkUserJoinedOrCreateEventFROMmap:point];
                
                
                
                
                
                
                
                dateLabel.text = [object valueForKey:@"Date"];
                hourLabel.text = [object valueForKey:@"Hour"];
                cityLabel.text = [object valueForKey:@"City"];
                
                if([[object valueForKey:@"Sportname"] isEqualToString:@"Futbol"])
                    ImageImageView.image = [UIImage imageNamed:@"SoccerBallIcon.png"];
                else if([[object valueForKey:@"Sportname"] isEqualToString:@"Correr"])
                    ImageImageView.image = [UIImage imageNamed:@"runIcon.png"];
                else if ([[object valueForKey:@"Sportname"] isEqualToString:@"Balonmano"])
                    ImageImageView.image = [UIImage imageNamed:@"HandballIcon.png"];
                else if ([[object valueForKey:@"Sportname"] isEqualToString:@"Baloncesto"])
                    ImageImageView.image = [UIImage imageNamed:@"BasketballIcon.png"];
                else if ([[object valueForKey:@"Sportname"] isEqualToString:@"Padel"])
                    ImageImageView.image = [UIImage imageNamed:@"TennisBallIcon.png"];
                else if ([[object valueForKey:@"Sportname"] isEqualToString:@"Tennis"])
                    ImageImageView.image = [UIImage imageNamed:@"TennisBallIcon.png"];
                else if ([[object valueForKey:@"Sportname"] isEqualToString:@"Senderismo"])
                    ImageImageView.image = [UIImage imageNamed:@"Senderismo.jpg"];
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.dimBackground = YES;
    HUD.labelText = @"Cargando Evento....";
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(LoadEventDetails) onTarget:self withObject:nil animated:YES];
    

    if(![PFUser currentUser].isAuthenticated) {
        joinButton.hidden = YES;
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Debe estar logueado par unirse a un evento"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"Vale"
                                              otherButtonTitles:nil];
        [alert show];
        
        
    }
  
    
}

-(void)LoadEventDetails{
    
    PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:coordinates.latitude longitude:coordinates.longitude];
    
    userjoinedornotLabel.hidden = YES;
    MapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
    MapView.showsUserLocation = YES;
    [MapView setMapType:MKMapTypeStandard];
    [MapView setZoomEnabled:YES];
    [MapView setScrollEnabled:YES];
    
    
    if(comefromMap == TRUE)[self findPinLocationWITHmap:point];
    else [self findPinLocationNOmap];
    
    sleep(5);
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
   [self zoomMapViewToFitAnnotations:self.MapView animated:YES];
}

- (void)zoomMapViewToFitAnnotations:(MKMapView *)mapView animated:(BOOL)animated{
    NSArray *annotations = mapView.annotations;
    unsigned long count = [MapView.annotations count];
    if ( count == 0) { return; } //bail if no annotations
    
    //convert NSArray of id <MKAnnotation> into an MKCoordinateRegion that can be used to set the map size
    //can't use NSArray with MKMapPoint because MKMapPoint is not an id
    MKMapPoint points[count]; //C array of MKMapPoint struct
    for( int i=0; i<count; i++ ) //load points C array by converting coordinates to points
    {
        CLLocationCoordinate2D coordinate = [(id <MKAnnotation>)[annotations objectAtIndex:i] coordinate];
        points[i] = MKMapPointForCoordinate(coordinate);
    }
    //create MKMapRect from array of MKMapPoint
    MKMapRect mapRect = [[MKPolygon polygonWithPoints:points count:count] boundingMapRect];
    //convert MKCoordinateRegion from MKMapRect
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(mapRect);
    
    //add padding so pins aren't scrunched on the edges
    region.span.latitudeDelta  *= ANNOTATION_REGION_PAD_FACTOR;
    region.span.longitudeDelta *= ANNOTATION_REGION_PAD_FACTOR;
    //but padding can't be bigger than the world
    if( region.span.latitudeDelta > MAX_DEGREES_ARC ) { region.span.latitudeDelta  = MAX_DEGREES_ARC; }
    if( region.span.longitudeDelta > MAX_DEGREES_ARC ){ region.span.longitudeDelta = MAX_DEGREES_ARC; }
    
    //and don't zoom in stupid-close on small samples
    if( region.span.latitudeDelta  < MINIMUM_ZOOM_ARC ) { region.span.latitudeDelta  = MINIMUM_ZOOM_ARC; }
    if( region.span.longitudeDelta < MINIMUM_ZOOM_ARC ) { region.span.longitudeDelta = MINIMUM_ZOOM_ARC; }
    //and if there is a sample of 1 we want the max zoom-in instead of max zoom-out
    if( count == 1 )
    {
        region.span.latitudeDelta = MINIMUM_ZOOM_ARC;
        region.span.longitudeDelta = MINIMUM_ZOOM_ARC;
    }
    [mapView setRegion:region animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)joinUserAction:(id)sender {
    
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.dimBackground = YES;
    HUD.labelText = @"Uniendote al evento...";
    HUD.detailsLabelText = @"Por favor, espere";
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(joinUserAction) onTarget:self withObject:nil animated:YES]; 
}

-(void)joinUserAction{
    
    
    PFGeoPoint *pointWithMap = [PFGeoPoint geoPointWithLatitude:coordinates.latitude longitude:coordinates.longitude];
    PFQuery *locationQuery = [PFQuery queryWithClassName:@"Event"];
    if(comefromMap == TRUE) [locationQuery whereKey:@"Eventlocation" equalTo:pointWithMap];
    else [locationQuery whereKey:@"Eventlocation" equalTo:pointNOmap];
    
    
    [locationQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
   
            for (PFObject *gp in objects) {
                
                //How to get PFGeoPoint and then a location out of an object
                PFGeoPoint *location = [gp objectForKey:@"Eventlocation"];
                
            
                
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude);
                
                TFGAnnotationMap *AllEventsAround = [[TFGAnnotationMap alloc]init];
                
                
                
                AllEventsAround.coordinate = coordinate;
                
                
                // We run 2 queries. One to get the Object ID of the object we want to update
                //                   And the oher one to update the vacants number
                PFQuery *getObjectWithLocationPoint = [PFQuery queryWithClassName:@"Event"];
                [getObjectWithLocationPoint selectKeys:@[@"objectId"]]; // We decide which fields to get
                if(comefromMap == TRUE) [getObjectWithLocationPoint whereKey:@"Eventlocation" equalTo:pointWithMap];
                else [getObjectWithLocationPoint whereKey:@"Eventlocation" equalTo:pointNOmap];
                
                
                
                
                // This method is to get the ObjectID for the selected row
                [getObjectWithLocationPoint findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if (!error) {
                        
            
        
                        PFQuery *updateVacants = [PFQuery queryWithClassName:@"Event"];
                        if(comefromMap == TRUE) [updateVacants whereKey:@"Eventlocation" equalTo:pointWithMap];
                        else [updateVacants whereKey:@"Eventlocation" equalTo:pointNOmap];
                        // Now that we have the Object we want to update by ObjectID, then let's update it
                        
                        [updateVacants findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                            if (!error) {
                                    for (PFObject *Event in objects) {
                                
                                    
                                    // We store the current vacants value
                                    int vacants = [[Event valueForKey:@"Vacants"]intValue];
                            
                                    
                                    PFUser *currentuser = [PFUser currentUser];
                                    
                                    
                                    if (currentuser.isAuthenticated) {
                                        
                                        if(vacants > 0){
                                            
                                            
                                            
                                            // We upload the new vacant number
                                            Event[@"Vacants"] = [NSNumber numberWithInt:vacants-1];
                                            [Event addUniqueObject:currentuser.username forKey:@"Participants"];
                                            [Event saveInBackground];
                                            
                                            
                                            // We upload the current user details
                                            
                                            
                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Te has unido al evento :) "
                                                                                            message:@""
                                                                                           delegate:self
                                                                                  cancelButtonTitle:@"Vale"
                                                                                  otherButtonTitles:nil];
                                            [alert show];
                                            
                                        
                                            [self viewDidLoad];
                                            
                                            
                                            
                                            
                                            
                                        }else{ // This else belongs to the If vacants > 0
                                            
                                            
                                            
                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No hay plazas para este evento :( "
                                                                                            message:@"Elija otro"
                                                                                           delegate:self
                                                                                  cancelButtonTitle:@"Vale"
                                                                                  otherButtonTitles:nil];
                                            [alert show];
                                            
                                            
                                        }
                                        
                                    }else{ // This else belongs to the if currentuser is authenticated
                                        
                                        
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Debes estar logueado para unirte a un evento :( "
                                                                                        message:@"Elija otro"
                                                                                       delegate:self
                                                                              cancelButtonTitle:@"Vale"
                                                                              otherButtonTitles:nil];
                                        
                                        [alert show];
                                        
                                    }
                                    
                                    
                                }
                            } else {
                                // Log details of the failure
                                NSLog(@"Error: %@ %@", error, [error userInfo]);
                            }
                        }];
                        
                        
                    } else {
                        // Log details of the failure
                        NSLog(@"Error: %@ %@", error, [error userInfo]);
                    }
                }];
                
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    sleep(6);
    
    
}




@end
