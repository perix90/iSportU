//
//  TFGResultsTableViewCell.m
//  iSporU
//
//  Created by Pedro Gordillo Rios on 12/03/15.
//  Copyright (c) 2015 Pedro Gordillo Rios. All rights reserved.
//

#import "TFGResultsTableViewCell.h"

@implementation TFGResultsTableViewCell


@synthesize eventnamelabel;
@synthesize userLabel;
@synthesize eventImage;
@synthesize sportLabel;
@synthesize eventHourLabel;
@synthesize eventDateLabel;
@synthesize cityLabel;
@synthesize vacantsLabel;




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    
    // Configure the view for the selected state
}

@end
