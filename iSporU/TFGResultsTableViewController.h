//
//  TFGResultsTableViewController.h
//  iSporU
//
//  Created by Pedro Gordillo Rios on 12/03/15.
//  Copyright (c) 2015 Pedro Gordillo Rios. All rights reserved.
//

@interface TFGResultsTableViewController : UITableViewController<MKMapViewDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) NSMutableArray *eventnameArray;
@property (nonatomic, strong) NSMutableArray *userArray;
@property (nonatomic, strong) NSMutableArray *eventImageArray;
@property (nonatomic, strong) NSMutableArray *sportArray;
@property (nonatomic, strong) NSMutableArray *hourArray;
@property (nonatomic, strong) NSMutableArray *dateArray;
@property (nonatomic, strong) NSMutableArray *vacantsArray;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *geopointsArray;
@property (weak, nonatomic) IBOutlet UIButton *showEventsMapButton;




// This NSStrings are to perform a search query based on the textfields provided in the SearchView. Passed by segue.
@property (nonatomic, strong) NSString *citysearchParameter;
@property (nonatomic, strong) NSString *datesearchParameter;
@property (nonatomic, strong) NSString *hoursearchParameter;


@end





