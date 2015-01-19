//
//  GameOptionsView.m
//  Unlimited Grid
//
//  Created by Kenneth Friedman on 1/19/15.
//  Copyright (c) 2015 Kenneth Friedman. All rights reserved.
//

#import "GameOptionsView.h"
#import "ViewController.h"
#import "UGAppearance.h"

static NSString *EXPANDED_BTN_TITLE = @"Options";
static NSString *COLLAPSED_BTN_TITLE = @"Close";
static NSString *DEFAULT_PLAYER_TEXT = @"Current Player: -";

@implementation GameOptionsView

- (id) initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	//Set Data
	expanded = NO;
	CGRect screenRect = [[UIScreen mainScreen] bounds];
	screenWidth = screenRect.size.width;
	screenHeight = screenRect.size.height;
	[self setBackgroundColor:[UGAppearance backgroundColor]];
	currentPlayerString = [[NSMutableAttributedString alloc] initWithString: DEFAULT_PLAYER_TEXT];
	[currentPlayerString addAttribute:NSForegroundColorAttributeName value:[UGAppearance deepColor] range:NSMakeRange(0, 16)];
	[currentPlayerString addAttribute:NSForegroundColorAttributeName value:[UGAppearance backgroundColor] range:NSMakeRange(16, 1)];
	
	//Start UI Elements
	moreButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[moreButton setTitle:EXPANDED_BTN_TITLE forState:UIControlStateNormal];
	[[moreButton titleLabel] setFont:[UIFont fontWithName:[UGAppearance fontName] size:15]];
	[moreButton setTintColor:[UGAppearance accentColor]];
	[[moreButton titleLabel] setTextAlignment:NSTextAlignmentLeft];
	[moreButton setFrame:CGRectMake(20, 8, 70, 44)];
	[moreButton addTarget:self action:@selector(expand) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:moreButton];
	
	currentPlayerLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth-170, 8, 150, 44)];
	[currentPlayerLabel setAttributedText: currentPlayerString];
	[currentPlayerLabel setFont:[UIFont fontWithName:[UGAppearance fontName] size:15]];
	[self addSubview:currentPlayerLabel];
	
	return self;
}

//animate up if not expanded, animate down if expanded
- (void) expand {
	
	if (expanded) {
		[UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
			[self setFrame:CGRectMake(0, screenHeight-60, screenWidth, 60)];
			[moreButton setTitle: EXPANDED_BTN_TITLE forState:UIControlStateNormal];
		} completion: nil];
	} else {
		[self makeRestartButton];
		[self makeBackButton];
		[self setFrame:CGRectMake(0, screenHeight-60, screenWidth, screenHeight/2)];
		[UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
			[self setFrame:CGRectMake(0, screenHeight/2, screenWidth, screenHeight/2)];
			[moreButton setTitle: COLLAPSED_BTN_TITLE forState:UIControlStateNormal];
		}completion: nil];
	}
	expanded = !expanded;
}

#pragma mark - Restart Button & Methods

- (void) makeRestartButton {
	UIButton *restartGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[restartGameButton setTitle:@"Restart Game" forState:UIControlStateNormal];
	[[restartGameButton titleLabel] setFont: [UIFont fontWithName:[UGAppearance fontName] size:15]];
	[restartGameButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	[restartGameButton setFrame:CGRectMake(20, 100, screenWidth-40, 44)];
	[restartGameButton addTarget:self action:@selector(restartGame) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:restartGameButton];
}

- (void) restartGame {
	[_delegate beginEraseProcess];
}

#pragma mark - Back Button & Methods

- (void) makeBackButton {
	UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[backButton setTitle:@"Close Game" forState:UIControlStateNormal];
	[[backButton titleLabel] setFont: [UIFont fontWithName:[UGAppearance fontName] size:15]];
	[backButton setTitleColor:[UGAppearance accentColor] forState:UIControlStateNormal];
	[backButton setFrame:CGRectMake(20, 150, screenWidth-40, 44)];
	[backButton addTarget:self action:@selector(closeGame) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:backButton];
}

- (void) closeGame {
	[_delegate goBack];
}

#pragma mark - Set Current Player

- (void) setXAsCurrentPlayer {
	[currentPlayerString replaceCharactersInRange:NSMakeRange(16, 1) withString:@"X"];
	[currentPlayerString addAttribute:NSForegroundColorAttributeName value:[UGAppearance accentColor] range:NSMakeRange(16, 1)];
	[currentPlayerLabel setAttributedText: currentPlayerString];
}

- (void) setOAsCurrentPlayer {
	[currentPlayerString replaceCharactersInRange:NSMakeRange(16, 1) withString:@"O"];
	[currentPlayerString addAttribute:NSForegroundColorAttributeName value:[UGAppearance neutralColor] range:NSMakeRange(16, 1)];
	[currentPlayerLabel setAttributedText: currentPlayerString];
}

@end
