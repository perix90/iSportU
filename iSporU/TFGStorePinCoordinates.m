//
//  TFGStorePinCoordinates.m
//  iSportU
//
//  Created by Pedro Gordillo Rios on 15/05/15.
//  Copyright (c) 2015 Pedro Gordillo Rios. All rights reserved.
//

#import "TFGStorePinCoordinates.h"

@implementation TFGStorePinCoordinates


@synthesize latitude;
@synthesize longitude;


+ (TFGStorePinCoordinates *)sharedInstance {
    static dispatch_once_t onceToken;
    static TFGStorePinCoordinates *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[TFGStorePinCoordinates alloc] init];
    });
    return instance;
}



@end
