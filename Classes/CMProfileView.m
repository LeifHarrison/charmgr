//
//  CMProfileView.m
//  CharMgr
//
//  Created by Leif Harrison on 4/28/10.
//  Copyright 2010 Ubermind, Inc. All rights reserved.
//

#import "CMProfileView.h"

#define COLUMN_COUNT	8
#define ROW_COUNT		4

@implementation CMProfileView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
/*
    CGRect	myBounds = self.bounds;
	CGRect	drawBounds = CGRectInset(myBounds, 1.0f, 1.0f);

	CGContextRef context = UIGraphicsGetCurrentContext();

	//[[UIColor whiteColor] set];
	//UIRectFill(myBounds);

	UIColor *strokeColor = [UIColor blackColor];
	//[[UIColor blackColor] set];
    CGContextSetFillColorWithColor(context, [strokeColor CGColor]);
    CGContextSetStrokeColorWithColor(context, [strokeColor CGColor]);
	//CGContextSetRGBStrokeColor(context, 0.0f, 0.0f, 0.0f, 1.0f);
	CGContextSetLineWidth(context, 2.0f);

	//CGContextSaveGState(context);
	//CGContextSetShadowWithColor(context,CGSizeMake(1.0, -1.0), 0.4, [UIColor whiteColor].CGColor);
	CGContextStrokeRect(context, drawBounds);
	//CGContextRestoreGState(context);
	
	//CGContextSaveGState(context);

	CGContextBeginPath(context);
	
	CGFloat columnWidth = myBounds.size.width / COLUMN_COUNT;
	CGFloat rowHeight = myBounds.size.height / ROW_COUNT;

	for (int rowIndex = 1; rowIndex < ROW_COUNT; rowIndex++) {
		CGFloat rowY = floor(rowIndex * rowHeight);
		CGContextMoveToPoint(context, 0.0f, rowY);
		CGContextAddLineToPoint(context, myBounds.size.width, rowY);
	}

	for (int columnIndex = 1; columnIndex < COLUMN_COUNT; columnIndex++) {
		CGFloat rowX = floor(columnIndex * columnWidth);
		CGContextMoveToPoint(context, rowX, 0.0f);
		CGContextAddLineToPoint(context, rowX, myBounds.size.height);
	}
	
	//CGContextStrokePath(context);
	CGContextDrawPath(context, kCGPathFillStroke);        

	//CGContextRestoreGState(context);

	UIFont *titleFont = [UIFont fontWithName:@"Marker Felt" size:12.0f];
	NSArray *titles = @[@"WS", @"BS", @"S", @"T", @"Ag", @"Int", @"WP", @"Fel"];
	CGRect headerRect = CGRectMake(0.0f, 0.0f, columnWidth, rowHeight);
	headerRect = CGRectInset(headerRect, 1.0f, 1.0f);
	for (NSString *title in titles) {
		[[UIColor blackColor] set];
		UIRectFill(headerRect);
		[[UIColor whiteColor] set];
		CGRect titleRect = CGRectInset(headerRect, 1.0f, 3.0f);
		[title drawInRect:titleRect withFont:titleFont lineBreakMode:UILineBreakModeCharacterWrap alignment:UITextAlignmentCenter];
		headerRect = CGRectOffset(headerRect, columnWidth, 0.0);
	}
*/
	[super drawRect:rect];
}



@end
