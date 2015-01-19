//
//  GridCell.h
//  Unlimited Grid
//
//  Created by Kenneth Friedman on 1/18/15.
//  Copyright (c) 2015 Kenneth Friedman. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, CELLTYPE) {
	CELL_EMPTY,
	CELL_X,
	CELL_O
};

@interface GridCell : UIView {
	CELLTYPE currentCellType;
	UILabel *label;
}

- (void) setCellAsX;
- (void) setCellAsO;
- (void) setCellAsEmpty;

- (enum CELLTYPE) getCellType;

@end
