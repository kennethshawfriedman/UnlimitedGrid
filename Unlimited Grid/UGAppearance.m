//
//  UGAppearance.m
//  Unlimited Grid
//
//  Created by Kenneth Friedman on 1/19/15.
//  Copyright (c) 2015 Kenneth Friedman. All rights reserved.
//

#import "UGAppearance.h"

@implementation UGAppearance


#pragma mark - Fonts & Styles

+ (NSString *) fontName {
	return @"Chalkduster";
}

#pragma mark - Colors

+ (UIColor *) backgroundColor {
	return [UIColor colorWithRed:.8 green:.823529412 blue:.847058824 alpha:1];
}

+ (UIColor *) deepColor {
	return [UIColor colorWithRed:0 green:.125490196 blue:.250980392 alpha:1];
}

+ (UIColor *) neutralColor {
	return [UIColor colorWithRed:0 green:.274509804 blue:.552941176 alpha:1];
}

+ (UIColor *) accentColor {
	return [UIColor colorWithRed:1 green:.454901961 blue:.156862745 alpha:1];
}

@end
