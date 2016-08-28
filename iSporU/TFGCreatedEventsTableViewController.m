//
//  TFGCreatedEventsTableViewController.m
//  iSportU
//
//  Created by Pedro Gordillo Rios on 27/03/15.
//  Copyright (c) 2015 Pedro Gordillo Rios. All rights reserved.
//

#import "TFGCreatedEventsTableViewController.h"

@interface TFGCreatedEventsTableViewController ()

@end

@implementation TFGCreatedEventsTableViewController

@synthesize eventnameArray;
@synthesize userArray;
@synthesize eventImageArray;
@synthesize sportArray;
@synthesize hourArray;
@synthesize vacantsArray;
@synthesize cityArray;
@synthesize dateArray;






// The viewDidLoad methods is a special method. It triggers whatever is inside this methods just when the view has been lodaded
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    eventnameArray = [[NSMutableArray alloc]init];
    userArray = [[NSMutableArray alloc]init];
    sportArray = [[NSMutableArray alloc]init];
    eventImageArray = [[NSMutableArray alloc]init];
    hourArray = [[NSMutableArray alloc]init];
    dateArray = [[NSMutableArray alloc]init];
    vacantsArray = [[NSMutableArray alloc]init];
    cityArray = [[NSMutableArray alloc]init];
    
    
    
   
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];

    [query whereKey:@"Username" equalTo:PFUser.currentUser.username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
        
            // Do something with the found objects
            
            
            for (NSObject *object in objects){
                
                [eventnameArray addObject:[object valueForKey:@"EventName"]];
                [userArray addObject:[object valueForKey:@"Username"]];
                [sportArray addObject:[object valueForKey:@"Sportname"]];
                [hourArray addObject:[object valueForKey:@"Hour"]];
                [dateArray addObject:[object valueForKey:@"Date"]];
                
                [vacantsArray addObject: [(NSNumber*)[object valueForKey:@"Vacants"] stringValue]];
                [cityArray addObject:[object valueForKey:@"City"]];
            }
            
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        [self.tableView reloadData];
    }];
    
    
    [self.tableView setBackgroundView:
     [[UIImageView alloc] initWithImage:
      [UIImage imageNamed:@"WallpaperTabs.jpg"]]];
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

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *EditEvent = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        [self performSegueWithIdentifier:@"ToEditEvent" sender:indexPath];
        
        
        
        
        [self.tableView setEditing:NO];
        
    }];
    
    EditEvent.backgroundColor = [UIColor grayColor];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        
        [eventnameArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        // DOWN HERE WE DELETE DE EVENT
        
        
        // We run 2 queries. One to get the Object ID of the object we want to delete
        //                   And the oher one to delete the object
        PFQuery *getObjectIDforRow = [PFQuery queryWithClassName:@"Event"];
        [getObjectIDforRow selectKeys:@[@"objectId"]]; // We decide which fields to get
        [getObjectIDforRow whereKey:@"Username" equalTo:PFUser.currentUser.username];
        
        // This method is to get the ObjectID for the selected row
        [getObjectIDforRow findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                
                // We save the Object ID found in a NSString
                NSString *ObjectID = [NSString stringWithFormat:@"%@", [objects[indexPath.row] valueForKey:@"objectId"]];
                
                
                // Now that we have The ObjectId to delete the row, let's delete it
                PFObject *Event = [PFObject objectWithoutDataWithClassName:@"Event" objectId:ObjectID];
                
                [Event deleteInBackground];
                
                
                
                
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    
    
    }];
    
    return @[deleteAction,EditEvent];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    static NSString *cellID = @"cell";
    
    TFGCreatedEventsTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = [[TFGCreatedEventsTableViewCell alloc]
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

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return TRUE;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // We have to leave this method in blank so that editActionsForRowAtIndexPath works!.
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Here we pass the bool value used in TFGResultsTableViewController to enable the Edit Event feature.
    if ([[segue identifier] isEqualToString:@"ToEditEvent"]){
        
        
        NSIndexPath* indexPath = (NSIndexPath*)sender;
        TFGAddEventViewController *controller = (TFGAddEventViewController *)segue.destinationViewController;
        controller.EditMode = TRUE;
        controller.row = (long)indexPath.row;
    }
}




@end

