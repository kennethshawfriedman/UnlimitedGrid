//
//  ViewController.m
//  Unlimited Grid
//
//  Created by Kenneth Friedman on 1/18/15.
//  Copyright (c) 2015 Kenneth Friedman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-80)];
	[self.view addSubview:scroller];
	
	int NUM_CELL_PER_ROW = 40;
	
	board = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NUM_CELL_PER_ROW*50, NUM_CELL_PER_ROW*50)];
	[scroller addSubview: board];
	
	[scroller setContentSize:CGSizeMake(NUM_CELL_PER_ROW*50, NUM_CELL_PER_ROW*50)];
	[scroller scrollRectToVisible:CGRectMake(NUM_CELL_PER_ROW*10-self.view.frame.size.width/2, NUM_CELL_PER_ROW*10-self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height) animated:NO];
	[scroller setDelegate:self];
	[scroller setMinimumZoomScale: 0.5];
	[scroller setMaximumZoomScale:2.0];
	
	arrayOfCells = [NSMutableArray new];
	
	for (int i=0; i<NUM_CELL_PER_ROW; i++) {
		NSMutableArray *innerArray = [NSMutableArray new];
		for (int j=0; j<NUM_CELL_PER_ROW; j++) {
			GridCell *singleCell = [[GridCell alloc] initWithFrame:CGRectMake(50*i, 50*j, 50, 50)];
			[innerArray addObject:singleCell];
			[board addSubview:singleCell];
		}
		[arrayOfCells addObject:innerArray];
	}
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
	[scroller addGestureRecognizer:tap];
	
	controller = [[GameOptionsView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width, 60)];
	[self.view addSubview: controller];
	currentTurnLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.view.frame.size.width-200, 8, 180, 44)];
	[currentTurnLabel setTextAlignment:NSTextAlignmentRight];
	[currentTurnLabel setText:@"Current Turn: X"];
	currentTurn = PLAYER_X;
	
	UIButton *eraseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[eraseButton setFrame:CGRectMake(20, 9, 50, 44)];
	[eraseButton setTitle:@"Erase" forState:UIControlStateNormal];
	[eraseButton addTarget:self action:@selector(erase) forControlEvents:UIControlEventTouchUpInside];
	[controller addSubview:eraseButton];
	
	UIColor *grayBackgroundColor = [UIColor colorWithRed:.8 green:.823529412 blue:.847058824 alpha:1];
	
	UIView *statusBarBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
	[statusBarBackground setBackgroundColor:grayBackgroundColor];
	[self.view addSubview: statusBarBackground];
	
	[self.view setBackgroundColor:grayBackgroundColor];
}

- (void) erase {
	for (NSMutableArray *mArray in arrayOfCells) {
		for (GridCell *cell in mArray) {
			[cell setCellAsEmpty];
		}
	}
}

- (void) cellTapped: (UITapGestureRecognizer *) tapRec {
	int iVal = [tapRec locationInView:board].x/50;
	int jVal = [tapRec locationInView:board].y/50;
	GridCell *tappedCell = [[arrayOfCells objectAtIndex:iVal] objectAtIndex:jVal];
	
	//make sure it is empty
	if ([tappedCell getCellType] != CELL_EMPTY) {
		return;
	}
	
	//alert tapped cell and switch turn
	if (currentTurn==PLAYER_X) {
		[tappedCell setCellAsX];
		[self setTurnForPlayerO];
	} else {
		[tappedCell setCellAsO];
		[self setTurnForPlayerX];
	}
	
	//check for in a row
	[self checkForWinWithX:iVal andY:jVal];

}

- (void) setTurnForPlayerX {
	currentTurn = PLAYER_X;
	[currentTurnLabel setText:@"Curent Turn: X"];
}

- (void) setTurnForPlayerO {
	currentTurn = PLAYER_O;
	[currentTurnLabel setText:@"Curent Turn: O"];
}

- (void) checkForWinWithX: (int) x andY: (int) y {
	
	int aboveCount = [self getAboveCountWithX:x andY: y];
	int belowCount = [self getBelowCountWithX:x andY: y];
	int vertical = aboveCount + belowCount;
		
	int leftCount = [self getLeftCountWithX:x andY: y];
	int rightCount = [self getRightCountWithX:x andY: y];
	int horizontal = leftCount + rightCount;
	
	int upperNorthEast = [self getUpperNorthEastCountWithX:x andY:y];
	int lowerNorthEast = [self getLowerNorthEastCountWithX:x andY:y];
	int northEast = upperNorthEast + lowerNorthEast;

	int upperSouthEast = [self getUpperSouthEastCountWithX:x andY:y];
	int lowerSouthEast = [self getLowerSouthEastCountWithX:x andY:y];
	int southEast = upperSouthEast + lowerSouthEast;
	
	if (vertical >= 4 || horizontal >= 4 || northEast >= 4 || southEast >= 4) {
		[self presentWinner];
	}
}

- (void) presentWinner {
	NSString *winningPlayer;
	if (currentTurn==PLAYER_O) {
		winningPlayer = @"Xs win!";
	} else {
		winningPlayer = @"Os win!";
	}
	
	UIAlertView *newAlert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:winningPlayer delegate:self cancelButtonTitle:nil otherButtonTitles: @"New Game", nil];
	[newAlert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {     // and they clicked OK.
		[self erase];
	}
}

- (int) getAboveCountWithX: (int) x andY: (int) y {
	int aboveCount = 0;
	CELLTYPE type = [self cellTypeForCellAt:x and:y];
	while (type == [self cellTypeForCellAt:x and:y-1]) {
		aboveCount++;
		y--;
	}
	return aboveCount;
}

- (int) getBelowCountWithX: (int) x andY: (int) y {
	int belowCount = 0;
	CELLTYPE type = [self cellTypeForCellAt:x and:y];
	while (type == [self cellTypeForCellAt:x and:y+1]) {
		belowCount++;
		y++;
	}
	return belowCount;
}

- (int) getLeftCountWithX: (int) x andY: (int) y {
	int leftCount = 0;
	CELLTYPE type = [self cellTypeForCellAt:x and:y];
	while (type == [self cellTypeForCellAt:x-1 and:y]) {
		leftCount++;
		x--;
	}
	return leftCount;
}

- (int) getRightCountWithX: (int) x andY: (int) y {
	int rightCount = 0;
	CELLTYPE type = [self cellTypeForCellAt:x and:y];
	while (type == [self cellTypeForCellAt:x+1 and:y]) {
		rightCount++;
		x++;
	}
	return rightCount;
}

- (int) getUpperNorthEastCountWithX: (int) x andY: (int) y {
	int uppperNE = 0;
	CELLTYPE type = [self cellTypeForCellAt:x and:y];
	while (type == [self cellTypeForCellAt:x+1 and:y-1]) {
		uppperNE++;
		x++;
		y--;
	}
	return uppperNE;
}

- (int) getLowerNorthEastCountWithX: (int) x andY: (int) y {
	int lowerNE = 0;
	CELLTYPE type = [self cellTypeForCellAt:x and:y];
	while (type == [self cellTypeForCellAt:x-1 and:y+1]) {
		lowerNE++;
		x--;
		y++;
	}
	return lowerNE;
}

- (int) getUpperSouthEastCountWithX: (int) x andY: (int) y {
	int upperSE = 0;
	CELLTYPE type = [self cellTypeForCellAt:x and:y];
	while (type == [self cellTypeForCellAt:x-1 and:y-1]) {
		upperSE++;
		x--;
		y--;
	}
	return upperSE;
}

- (int) getLowerSouthEastCountWithX: (int) x andY: (int) y {
	int lowerSE = 0;
	CELLTYPE type = [self cellTypeForCellAt:x and:y];
	while (type == [self cellTypeForCellAt:x+1 and:y+1]) {
		lowerSE++;
		x++;
		y++;
	}
	return lowerSE;
}


- (CELLTYPE) cellTypeForCellAt: (int) x and: (int) y {
	if (x<0 || y<0 || x>=[arrayOfCells count] || y>= [[arrayOfCells objectAtIndex:x] count]) {
		NSLog(@"OH NO SOMETHING WENT WRONG at (%d, %d)", x,y);
		return CELL_EMPTY;
	} else {
		return [[[arrayOfCells objectAtIndex:x] objectAtIndex:y] getCellType];
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return [scroller.subviews objectAtIndex:0];
}

//Should be used for debugging only
- (void) printBoard {
	NSMutableString *string = [NSMutableString stringWithFormat: @"\n"];
	for (int i=0; i<20; i++) {
		for (int j=0;j<20; j++) {
			[string appendString: [NSString stringWithFormat:@"%ld, ", [self cellTypeForCellAt:j and:i]]];
		}
		[string appendString:@"\n"];
	}
	NSLog(@"%@",string);
}


@end
