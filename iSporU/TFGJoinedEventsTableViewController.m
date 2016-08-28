//
//  TFGJoinedEventsTableViewController.m
//  iSportU
//
//  Created by Pedro Gordillo Rios on 24/04/15.
//  Copyright (c) 2015 Pedro Gordillo Rios. All rights reserved.
//

#import "TFGJoinedEventsTableViewController.h"

@interface TFGJoinedEventsTableViewController ()

@end

@implementation TFGJoinedEventsTableViewController

@synthesize eventnameArray;
@synthesize userArray;
@synthesize eventImageArray;
@synthesize sportArray;
@synthesize hourArray;
@synthesize vacantsArray;
@synthesize cityArray;
@synthesize dateArray;


// The viewDidLoad methods is a special method. It triggers whatever is inside this methods just when the view has been lodaded
- (void)viewDidLoad{
    [super viewDidLoad];
    
    eventnameArray = [[NSMutableArray alloc]init];
    userArray = [[NSMutableArray alloc]init];
    sportArray = [[NSMutableArray alloc]init];
    eventImageArray = [[NSMutableArray alloc]init];
    hourArray = [[NSMutableArray alloc]init];
    dateArray = [[NSMutableArray alloc]init];
    vacantsArray = [[NSMutableArray alloc]init];
    cityArray = [[NSMutableArray alloc]init];
    
    // We perfom a querty to get the User's event data
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    
    [query whereKey:@"Participants" equalTo:PFUser.currentUser.username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
    
            // The found objects will be stored in objects NSArray and with the followinf for loop, we will add the found objects to their corresponding NSMutableArray
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    // Return the number of rows in the section.
    return [eventnameArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cell";
    
    TFGJoinedEventsTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = [[TFGJoinedEventsTableViewCell alloc]
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
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView setEditing:NO];
    
    // We create a UITableViewRowAction to be able to perfom deleting actions over a tableview row
    
    UITableViewRowAction *UnjoinUserFromEvent = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Abandonar\nEvento"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
    
        [eventnameArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
  
        // We run 2 queries. One to get the Object ID of the object we want to delte
        //                   And the oher, once the Object ID is got, perfom the deletion
        
        PFQuery *getObjectIDforRow = [PFQuery queryWithClassName:@"Event"];
        [getObjectIDforRow selectKeys:@[@"objectId"]]; // We decide which fields to get
        [getObjectIDforRow whereKey:@"Participants" equalTo:PFUser.currentUser.username];
        
        // This method is to get the ObjectID for the selected row
        [getObjectIDforRow findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                
                // We save the Object ID found in a NSString
                NSString *ObjectID = [NSString stringWithFormat:@"%@", [objects[indexPath.row] valueForKey:@"objectId"]];
                
                PFQuery *forDeleteJoinedUser = [PFQuery queryWithClassName:@"Event"];
                [forDeleteJoinedUser getObjectInBackgroundWithId:ObjectID block:^(PFObject *Event, NSError *error) {
                    
                    PFUser *currentUser = [PFUser currentUser];
                    
                    // We create an array of participants of the event and we remove the current user from this array.
                    NSMutableArray *arrayofParticipants = [Event valueForKey:@"Participants"];
                    [arrayofParticipants removeObject:currentUser.username];
                    
                    // We assign the new array of participants to the Parse participants column. Afterwards we need to increment by 1 the number of vacants since an user has just unjoined. Afterwards we commit the changes
                    [Event setObject:arrayofParticipants forKey:@"Participants"];
                    [Event incrementKey:@"Vacants" byAmount:[NSNumber numberWithInt:+1]];
                    [Event saveInBackground];
                }];
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
        
        
    }];
    
    return @[UnjoinUserFromEvent];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // We need to implement this delegate method to actually be able to edit a row.
    
    return TRUE;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end

