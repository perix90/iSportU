//
//  TFGResultsTableViewController.m
//  iSporU
//
//  Created by Pedro Gordillo Rios on 12/03/15.
//  Copyright (c) 2015 Pedro Gordillo Rios. All rights reserved.
//

#import "TFGResultsTableViewController.h"

@interface TFGResultsTableViewController ()

@end

@implementation TFGResultsTableViewController

@synthesize eventnameArray;
@synthesize userArray;
@synthesize eventImageArray;
@synthesize sportArray;
@synthesize hourArray;
@synthesize vacantsArray;
@synthesize cityArray;
@synthesize dateArray;
@synthesize geopointsArray;
@synthesize showEventsMapButton;

@synthesize citysearchParameter;
@synthesize datesearchParameter;
@synthesize hoursearchParameter;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}









// The viewDidLoad methods is a special method. It triggers whatever is inside this methods just when the view has been lodaded
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setBackgroundView:
     [[UIImageView alloc] initWithImage:
      [UIImage imageNamed:@"WallpaperTabs.jpg"]]];
  
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [[showEventsMapButton layer] setBorderWidth:0.1f];
    [[showEventsMapButton layer] setBorderColor:[UIColor blackColor].CGColor];
    
    
    eventnameArray = [[NSMutableArray alloc]init];
    userArray = [[NSMutableArray alloc]init];
    sportArray = [[NSMutableArray alloc]init];
    eventImageArray = [[NSMutableArray alloc]init];
    hourArray = [[NSMutableArray alloc]init];
    dateArray = [[NSMutableArray alloc]init];
    vacantsArray = [[NSMutableArray alloc]init];
    cityArray = [[NSMutableArray alloc]init];
    geopointsArray = [[NSMutableArray alloc]init];
 
    
    
    // Parse Query for ALL events
   
        
        
        PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    
        
        
    
        // Here we filter the query results based on the data provided in TFGSearchViewController
        if(![citysearchParameter isEqualToString:@""]) [query whereKey:@"City" equalTo:citysearchParameter];
        if(![datesearchParameter isEqualToString:@""]) [query whereKey:@"Date" equalTo:datesearchParameter];
        if(![hoursearchParameter isEqualToString:@""]) [query whereKey:@"Hour" equalTo:hoursearchParameter];
        if(![citysearchParameter isEqualToString:@""] && ![datesearchParameter isEqualToString:@""]) {
        
            [query whereKey:@"City" equalTo:citysearchParameter];
            [query whereKey:@"Date" equalTo:datesearchParameter];
        
        }
        if(![citysearchParameter isEqualToString:@""] && ![hoursearchParameter isEqualToString:@""]){
        
            [query whereKey:@"City" equalTo:citysearchParameter];
            [query whereKey:@"Hour" equalTo:hoursearchParameter];
        
        }
        if(![datesearchParameter isEqualToString:@""] && ![hoursearchParameter isEqualToString:@""]){
        
            [query whereKey:@"Date" equalTo:datesearchParameter];
            [query whereKey:@"Hour" equalTo:hoursearchParameter];
        
        }
        if(![citysearchParameter isEqualToString:@""] && ![datesearchParameter isEqualToString:@""] && ![hoursearchParameter isEqualToString:@""]){
        
            [query whereKey:@"City" equalTo:citysearchParameter];
            [query whereKey:@"Date" equalTo:datesearchParameter];
            [query whereKey:@"Hour" equalTo:hoursearchParameter];
        
        }
    
    
    
       
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
               
                for (NSObject *object in objects){
                    [eventnameArray addObject:[object valueForKey:@"EventName"]];
                    [userArray addObject:[object valueForKey:@"Username"]];
                    [sportArray addObject:[object valueForKey:@"Sportname"]];
                    [hourArray addObject:[object valueForKey:@"Hour"]];
                    [dateArray addObject:[object valueForKey:@"Date"]];
                    [vacantsArray addObject: [(NSNumber*)[object valueForKey:@"Vacants"] stringValue]];
                    [cityArray addObject:[object valueForKey:@"City"]];
                    [geopointsArray addObject:[object valueForKey:@"Eventlocation"]];
                }
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
            
            [self.tableView reloadData];
        }];
    
    
    
    

    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [eventnameArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"cell";
    
    TFGResultsTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = [[TFGResultsTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:cellID];
    }
    
    // Configure the cell...
  
    cell.eventnamelabel.text = [eventnameArray objectAtIndex: [indexPath row]];
    
    cell.userLabel.text = [userArray objectAtIndex: [indexPath row]];
    cell.sportLabel.text = [sportArray objectAtIndex: [indexPath row]];
    cell.eventDateLabel.text = [dateArray objectAtIndex: [indexPath row]];
    cell.eventHourLabel.text = [hourArray objectAtIndex: [indexPath row]];
    cell.vacantsLabel.text = [vacantsArray objectAtIndex: [indexPath row]];
    cell.cityLabel.text = [cityArray objectAtIndex: [indexPath row]];
    
    
    
    
    
    if([cell.sportLabel.text isEqualToString:@"Futbol"])
        cell.eventImage.image = [UIImage imageNamed:@"SoccerBallIcon.png"];
    else if([cell.sportLabel.text isEqualToString:@"Correr"])
        cell.eventImage.image = [UIImage imageNamed:@"runIcon.png"];
    else if ([cell.sportLabel.text isEqualToString:@"Balonmano"])
        cell.eventImage.image = [UIImage imageNamed:@"HandballIcon.png"];
    else if ([cell.sportLabel.text isEqualToString:@"Baloncesto"])
        cell.eventImage.image = [UIImage imageNamed:@"BasketballIcon.png"];
    else if ([cell.sportLabel.text isEqualToString:@"Padel"])
        cell.eventImage.image = [UIImage imageNamed:@"TennisBallIcon.png"];
    else if ([cell.sportLabel.text isEqualToString:@"Tennis"])
        cell.eventImage.image = [UIImage imageNamed:@"TennisBallIcon.png"];
    else if ([cell.sportLabel.text isEqualToString:@"Senderismo"])
        cell.eventImage.image = [UIImage imageNamed:@"Senderismo.jpg"];

    return cell;
}

//This function is where all the magic happens
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (0.0*M_PI)/180, 0.0, 0.7, 0.4); // 0.0*M_PI produces a "ghost" appear
    rotation.m34 = 1.0/ -600;
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    //!!!FIX for issue #1 Cell position wrong------------
    if(cell.layer.position.x != 0){
        cell.layer.position = CGPointMake(0, cell.layer.position.y);
    }
    
    //4. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:1.5];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Here we pass the bool value used in TFGResultsTableViewController to enable the Edit Event feature.
    if ([[segue identifier] isEqualToString:@"ToEventDetails"]){
    
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        
        TFGEventDetailsViewController *controller = (TFGEventDetailsViewController *)segue.destinationViewController;
        controller.date = dateArray[indexPath.row];
        controller.hour = hourArray[indexPath.row];
        controller.city = cityArray[indexPath.row];
        controller.sport = sportArray[indexPath.row];
        controller.pointNOmap = geopointsArray[indexPath.row];
        
        
        
    }
}


@end