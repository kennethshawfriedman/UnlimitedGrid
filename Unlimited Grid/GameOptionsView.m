//
//  GameOptionsView.m
//  Unlimited Grid
//
//  Created by Kenneth Friedman on 1/19/15.
//  Copyright (c) 2015 Kenneth Friedman. All rights reserved.
//

#import "GameOptionsView.h"
#import "ViewController.h"

@implementation GameOptionsView

- (id) initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	[self setBackgroundColor:[UIColor colorWithRed:.8 green:.823529412 blue:.847058824 alpha:1]];
	
	UITapGestureRecognizer *tapToExpand = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expand)];
	[self addGestureRecognizer:tapToExpand];
	expanded = NO;
	
	return self;
}

//animate up if not expanded, animate down if expanded
- (void) expand {
	CGRect screenRect = [[UIScreen mainScreen] bounds];
	CGFloat screenWidth = screenRect.size.width;
	CGFloat screenHeight = screenRect.size.height;
	
	if (expanded) {
		[UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
			[self setFrame:CGRectMake(0, screenHeight-60, screenWidth, 60)];
		} completion: nil];
	} else {
		[self setFrame:CGRectMake(0, screenHeight-60, screenWidth, screenHeight/2)];
		[UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
			[self setFrame:CGRectMake(0, screenHeight/2, screenWidth, screenHeight/2)];
		}completion: nil];
	}
	expanded = !expanded;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
