//
//  TFGJoinedEventsTableViewCell.h
//  iSportU
//
//  Created by Pedro Gordillo Rios on 24/04/15.
//  Copyright (c) 2015 Pedro Gordillo Rios. All rights reserved.
//

@interface TFGJoinedEventsTableViewCell : UITableViewCell


// Here we declare all the properties we will use
@property (strong, nonatomic) IBOutlet UILabel *eventnamelabel;
@property (strong, nonatomic) IBOutlet UILabel *userLabel;
@property (strong, nonatomic) IBOutlet UIImageView *eventImage;
@property (strong, nonatomic) IBOutlet UILabel *sportLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventHourLabel;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *vacantsLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventDateLabel;


@end
