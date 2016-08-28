//
//  TFGSelectSportTableViewController.m
//  iSporU
//
//  Created by Pedro Gordillo Rios on 11/03/15.
//  Copyright (c) 2015 Pedro Gordillo Rios. All rights reserved.
//

#import "TFGSelectSportTableViewController.h"

@interface TFGSelectSportTableViewController ()

@end

@implementation TFGSelectSportTableViewController

// We need to synthesize the properties declared in the header file
@synthesize SportsList;


// The viewDidLoad methods is a special method. It triggers whatever is inside this methods just when the view has been lodaded
- (void)viewDidLoad{
    [super viewDidLoad];
    
    // We create an array of Sports so that the query performed can store the results in this array
    SportsList = [[NSMutableArray alloc]init];
    [SportsList addObject:@"Futbol"];
    [SportsList addObject:@"Correr"];
    [SportsList addObject:@"Balonmano"];
    [SportsList addObject:@"Baloncesto"];
    [SportsList addObject:@"Padel"];
    [SportsList addObject:@"Tennis"];
    [SportsList addObject:@"Senderismo"];
    
    // We set a Wallpaper
    [self.tableView setBackgroundView:
     [[UIImageView alloc] initWithImage:
      [UIImage imageNamed:@"WallpaperTabs.jpg"]]];
    
    
    

}

// These are the tableview delegate methods. Mandatory to created them
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    // Return the number of rows in the section.
    return [SportsList count];
}

// This method is to handle the table cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"SportCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
   
    
    cell.textLabel.text = [SportsList objectAtIndex:indexPath.row];
    
    
    return cell;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"pass"]) {
       
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        TFGAddEventViewController *destViewController = segue.destinationViewController;
        destViewController.Sport = [SportsList objectAtIndex:indexPath.row];
        
    }
    
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
