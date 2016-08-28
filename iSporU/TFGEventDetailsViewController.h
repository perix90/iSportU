//
//  TFGEventDetailsViewController.h
//  iSportU
//
//  Created by Pedro Gordillo Rios on 14/05/15.
//  Copyright (c) 2015 Pedro Gordillo Rios. All rights reserved.
//

@interface TFGEventDetailsViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,MBProgressHUDDelegate>{
    
    CLLocationCoordinate2D coordinates;
    
    
    
}

// Here we declare all the properties we will use
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ImageImageView;
@property (weak, nonatomic) IBOutlet MKMapView *MapView;
@property (weak, nonatomic) IBOutlet UIButton *joinButton;
@property (weak, nonatomic) IBOutlet UILabel *userjoinedornotLabel;

@property(nonatomic, retain) CLLocationManager *locationManager;
@property(weak,nonatomic) NSString *date;
@property(weak,nonatomic) NSString *hour;
@property(weak,nonatomic) NSString *city;
@property(weak,nonatomic) NSString *sport;
@property CLLocationCoordinate2D coordinates;
@property PFGeoPoint *pointNOmap;
@property BOOL comefromMap;

// Here we declare all the Actions triggered in the class
- (IBAction)joinUserAction:(id)sender;


@end
