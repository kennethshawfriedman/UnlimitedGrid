//
//  StartingVC.h
//  Unlimited Grid
//
//  Created by Kenneth Friedman on 1/19/15.
//  Copyright (c) 2015 Kenneth Friedman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UGAppearance.h"
#import "ViewController.h"
#import "UGAppearance.h"

@interface StartingVC : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *logoLabel;
@property (strong, nonatomic) IBOutlet UIButton *oneDeviceButton;

- (IBAction)playOnOneDevice:(UIButton *)sender;

@end
