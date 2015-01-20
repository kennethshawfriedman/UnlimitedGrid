//
//  GameOptionsView.h
//  Unlimited Grid
//
//  Created by Kenneth Friedman on 1/19/15.
//  Copyright (c) 2015 Kenneth Friedman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameOptionsView;
@protocol GameOptionsDelegate <NSObject>
	- (void) beginEraseProcess;
	- (void) goBack;
@end

@interface GameOptionsView : UIView {
	
	//UI Elements
	UIButton *moreButton;
	UILabel *currentPlayerLabel;
	
	//State data
	BOOL expanded;
	CGFloat screenWidth;
	CGFloat screenHeight;
	NSMutableAttributedString *currentPlayerString;
	
}

//Modifying current players
- (void) setXAsCurrentPlayer;
- (void) setOAsCurrentPlayer;

//Delegate
@property (nonatomic, weak) id <GameOptionsDelegate> delegate;



@end
