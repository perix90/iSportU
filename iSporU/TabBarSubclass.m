//
//  TabBarSubclass.m
//  iSportU
//
//  Created by Pedro Gordillo Ríos on 28/12/14.
//  Copyright (c) 2014 Pedro Gordillo. All rights reserved.
//

#import "TabBarSubclass.h"
@interface TabBarSubclass ()

@end

@implementation TabBarSubclass

// The viewDidLoad methods is a special method. It triggers whatever is inside this methods just when the view has been lodaded
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedIndex = 1;
    
    
}
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
