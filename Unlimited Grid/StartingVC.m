//
//  StartingVC.m
//  Unlimited Grid
//
//  Created by Kenneth Friedman on 1/19/15.
//  Copyright (c) 2015 Kenneth Friedman. All rights reserved.
//

#import "StartingVC.h"

@interface StartingVC ()

@end

@implementation StartingVC

- (void)viewDidLoad {
    [super viewDidLoad];
	[_logoLabel setTextColor: [UGAppearance deepColor]];
	[_oneDeviceButton setTintColor:[UGAppearance accentColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playOnOneDevice:(UIButton *)sender {
	
}


@end
