//
//  GridCell.m
//  Unlimited Grid
//
//  Created by Kenneth Friedman on 1/18/15.
//  Copyright (c) 2015 Kenneth Friedman. All rights reserved.
//

#import "GridCell.h"
#import "UGAppearance.h"
@import QuartzCore;

@implementation GridCell

- (id) initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	//UI Setup
	[self setUI];
	
	//Type Representation
	label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
	[label setTextAlignment:NSTextAlignmentCenter];
	[label setFont:[UIFont fontWithName:[UGAppearance fontName] size:40]];
	[self addSubview:label];
	
	//set cell as empty to begin with
	[self setCellAsEmpty];
	
	return self;
}

//Sets up basic UI, which includes background color and cell border
- (void) setUI {
	[self setBackgroundColor:[UIColor whiteColor]];
	[self.layer setBorderWidth:2.0];
	UIColor *borderColor = [UGAppearance deepColor];
	[self.layer setBorderColor: borderColor.CGColor];
}

- (void) setCellAsX {
	currentCellType = CELL_X;
	[label setText:@"X"];
	[label setTextColor: [UGAppearance accentColor]];
}

- (void) setCellAsO {
	currentCellType = CELL_O;
	[label setText:@"O"];
	[label setTextColor: [UGAppearance neutralColor]];
}

- (void) setCellAsEmpty {
	currentCellType = CELL_EMPTY;
	[label setText:@""];
	[label setTextColor: [UIColor grayColor]];
}

- (enum CELLTYPE) getCellType {
	return currentCellType;
}

@end
