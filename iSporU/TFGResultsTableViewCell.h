//
//  TFGResultsTableViewCell.h
//  iSporU
//
//  Created by Pedro Gordillo Rios on 12/03/15.
//  Copyright (c) 2015 Pedro Gordillo Rios. All rights reserved.
//

@interface TFGResultsTableViewCell : UITableViewCell<MKMapViewDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *eventnamelabel;
@property (strong, nonatomic) IBOutlet UILabel *userLabel;
@property (strong, nonatomic) IBOutlet UIImageView *eventImage;
@property (strong, nonatomic) IBOutlet UILabel *sportLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventHourLabel;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *vacantsLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventDateLabel;




@end
