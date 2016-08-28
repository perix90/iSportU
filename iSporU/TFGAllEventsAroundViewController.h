//
//  TFGAllEventsAroundViewController.h
//  iSportU
//
//  Created by Pedro Gordillo Rios on 15/05/15.
//  Copyright (c) 2015 Pedro Gordillo Rios. All rights reserved.
//

@interface TFGAllEventsAroundViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>

// Here we declare all the properties we will use
@property (weak, nonatomic) IBOutlet MKMapView *MapView;
@property(nonatomic, retain) CLLocationManager *locationManager;
@property CLLocationCoordinate2D tappedCoord;
@property(nonatomic) NSString *SportPin;

@end
