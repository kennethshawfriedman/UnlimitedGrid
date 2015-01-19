//
//  ViewController.h
//  Unlimited Grid
//
//  Created by Kenneth Friedman on 1/18/15.
//  Copyright (c) 2015 Kenneth Friedman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridCell.h"

typedef NS_ENUM(NSInteger, PLAYERTYPE) {
	PLAYER_X,
	PLAYER_O
};

@interface ViewController : UIViewController <UIScrollViewDelegate> {
	
	PLAYERTYPE currentTurn;
	UIScrollView *scroller;
	UIView *board;
	NSMutableArray *arrayOfCells;
	UILabel *currentTurnLabel;
	
}


@end

