//
//  TFGStorePinCoordinates.h
//  iSportU
//
//  Created by Pedro Gordillo Rios on 15/05/15.
//  Copyright (c) 2015 Pedro Gordillo Rios. All rights reserved.
//

@interface TFGStorePinCoordinates : NSObject{
    
    NSString * latitude;
    NSString * longitude;
    
}

+ (TFGStorePinCoordinates *)sharedInstance;



@property (nonatomic, copy) NSString * latitude;
@property (nonatomic, copy) NSString * longitude;
@end
