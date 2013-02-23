//
//  CGGeometry+CMExtensions.h
//  CharMgr
//
//  Created by Leif Harrison on 11/19/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *
 * Extensions to CGGeometry.
 */

/**
 * A value representing one or more corners of a \c CGRect.
 */
typedef enum 
{
	/// No corners.
	CMCGRectCornerCornerNone		= 0x0U,

	/// The top-left corner of the rectangle.
	CMCGRectCornerCornerTopLeft		= 0x1U << 0,

	/// The top-right corner of the rectangle.
	CMCGRectCornerCornerTopRight	= 0x1U << 1,

	/// The bottom-left corner of the rectangle.
	CMCGRectCornerCornerBottomLeft	= 0x1U << 2,

	/// The bottom-right corner of the rectangle.
	CMCGRectCornerCornerBottomRight	= 0x1U << 3,

	/// All corners on the top edge of the rectangle.
	CMCGRectCornerCornerTopEdge    = CMCGRectCornerCornerTopLeft    | CMCGRectCornerCornerTopRight,

	/// All corners on the left edge of the rectangle.
	CMCGRectCornerCornerLeftEdge   = CMCGRectCornerCornerTopLeft    | CMCGRectCornerCornerBottomLeft,

	/// All corners on the right edge of the rectangle.
	CMCGRectCornerCornerRightEdge  = CMCGRectCornerCornerTopRight   | CMCGRectCornerCornerBottomRight,

	/// All corners on the bottom edge of the rectangle.
	CMCGRectCornerCornerBottomEdge = CMCGRectCornerCornerBottomLeft | CMCGRectCornerCornerBottomRight,
	
	/// All corners of the rectangle.
	CMCGRectCornerCornerAllCorners = ~0
} CMCGRectCorner;

/**
 * Clamps the value of \a t between \a a and \a b, inclusive.
 */
CGFloat CGFloatClamp(CGFloat a, CGFloat b, CGFloat t);

/**
 * Calculates the distance between \a a and \a b.
 */
CGFloat CGPointDistance(CGPoint a, CGPoint b);

CGPoint CGPointInterp(CGPoint a, CGPoint b, CGFloat t);

/**
 * Subtracts the coordinates of \a b from those of \a a.
 */
CGPoint CGPointSubtract(CGPoint a, CGPoint b);

/**
 * Adds the coordinates of \a a and \a b.
 */
CGPoint CGPointAdd(CGPoint a, CGPoint b);

CGFloat CGPointLengthSq(CGPoint a);
CGFloat CGPointLength(CGPoint a);

/**
 * Calculates the dot product of \a a and \a b.
 */
CGFloat CGPointDot(CGPoint a, CGPoint b);

/**
 * Multiplies the coordinates of \a a by the coordinates in \a b.
 */
CGPoint CGPointMul(CGPoint a, CGPoint b);

/**
 * Multiplies the coordinates of \a a by factor \a s.
 */
CGPoint CGPointScale(CGPoint a, CGFloat s);

/**
 * Extends non-zero vector \a a by the length \a n.
 */
CGPoint CGPointAddLength(CGPoint a, CGFloat n);

CGPoint CGPointNormalize(CGPoint a);
CGFloat CGPointProjectOntoLine(CGPoint l1, CGPoint l2, CGPoint p);
CGPoint CGPointUnitDirec(CGPoint start, CGPoint end);
CGPoint CGPointMoveInDirec(CGPoint start, CGPoint direc, CGFloat scale);

/**
 * Rounds the coordinates of \a p down to the nearest integer values, dropping
 * any fractional portion, and returns the new point.
 *
 * @note Rounding is done in a manner consistent with \c CGRectIntegral().
 */
CGPoint CGPointIntegral(CGPoint p);

/**
 * Returns whether \a p is at the origin. Note that very small (but still non-
 * zero) values will not satisfy this test. Keep this in mind when performing
 * floating-point calculations, as they may produce slightly inaccurate results.
 */
BOOL CGPointIsZero(CGPoint p);

/**
 * Returns the exact center point of \a rect.
 */
CGPoint CGRectCenterPoint(CGRect rect);

/**
 * Returns the subset of \a rect that does not fall within \a value pixels of
 * the specified edge.
 */
CGRect CGRectChop(CGRect rect, CGFloat value, CGRectEdge edge);

/**
 * Returns the subset of \a rect that falls within \a value pixels of 
 * the specified edge.
 *
 * \note The returned slice is the complement to the rect returned from \c CGrectChop.
 */
CGRect CGRectSlice(CGRect rect, CGFloat value, CGRectEdge edge);

/**
 * A macro for \c CGRectDivide() that allows \a SLICE and \a REM to be
 * properties (such as \c bounds or \c frame) on a \c UIView.
 *
 * \a SLICE and \a REM should be direct \c CGRect structures, not pointers.
 */
#define CGRectDivideFrames(RECT, SLICE, REM, AMOUNT, EDGE) \
	do { \
		CGRect slice_; \
		CGRect rem_; \
		CGRectDivide((RECT), &slice_, &rem_, (AMOUNT), (EDGE)); \
		(SLICE) = slice_; \
		(REM) = rem_; \
	} while (0)

/**
 * Divides \a rect into two component rectangles that are themselves separated
 * by \a padding logical points.
 *
 * @param rect The source rectangle.
 * @param slice If provided, this is set to the rectangle extending \a contentAmount points past \a edge.
 * @param remainder If provided, this is set to the rectangle \a padding points past \a slice, starting from \a edge.
 * @param contentAmount The number of logical points to include in \a slice, starting from \a edge.
 * @param padding The amount of padding, in logical points, to add between \a slice and \a remainder.
 * @param edge The edge to measure from.
 */
void CGRectDivideWithPadding (CGRect rect, CGRect *slice, CGRect *remainder, CGFloat contentAmount, CGFloat padding, CGRectEdge edge);

/**
 * A macro for CGRectDivideWithPadding() that allows \a SLICE and \a REM to be
 * properties (such as \c bounds or \c frame) on a \c UIView.
 *
 * \a SLICE and \a REM should be direct \c CGRect structures, not pointers.
 */
#define CGRectDivideFramesWithPadding(RECT, SLICE, REM, AMOUNT, PADDING, EDGE) \
	do { \
		CGRect slice_; \
		CGRect rem_; \
		CGRectDivideWithPadding((RECT), &slice_, &rem_, (AMOUNT), (PADDING), (EDGE)); \
		(SLICE) = slice_; \
		(REM) = rem_; \
	} while (0)

/**
 * Returns \a rect expanded \a value pixels in the direction of the specified
 * edge.
 */
CGRect CGRectGrow(CGRect rect, CGFloat value, CGRectEdge edge);

/**
 * Similar to CGRectOffset, but also shrinks/expands width/height as well
 */

CGRect CGRectOffsetAndShrink(CGRect rect, CGFloat dx, CGFloat dy);

/**
 * Returns a rectangle with the given center and of the given size.
 */
CGRect CGRectWithCenterAndSize(CGPoint center, CGSize size);

/**
 * Returns a rectangle with the given origin and of the given size.
 */
CGRect CGRectWithOriginAndSize(CGPoint origin, CGSize size);

/**
 * Returns a rectangle originating at (0, 0) with the given dimensions in size.
 */
CGRect CGRectWithSize(CGSize size);

/**
 * Centers \a rectToCenter upon the center position of \a parentRect. It is
 * considered valid for \a rectToCenter to be larger than \a parentRect.
 *
 * Note that older usages of this function (before it was included within this
 * framework) are more similar to CGRectCenteredInSize().
 */
CGRect CGRectCenteredInRect(CGRect rectToCenter, CGRect parentRect);

/**
 * Centers \a rectToCenter within the dimensions of \a size.
 */
CGRect CGRectCenteredInSize(CGRect rectToCenter, CGSize size);

/**
 * Centers \a rectToCenter upon \a point.
 */
CGRect CGRectCenteredOnPoint(CGRect rectToCenter, CGPoint point);

/**
 * Horizontally centers \a rectToCenter upon the center position of
 * \a parentRect. Vertical coordinates are not considered. It is considered
 * valid for \a rectToCenter to be larger than \a parentRect.
 *
 * Note that older usages of this function (before it was included within this
 * framework) are more similar to CGRectHorizontallyCenteredInSize().
 */
CGRect CGRectHorizontallyCenteredInRect(CGRect rectToCenter, CGRect parentRect);

/**
 * Horizontally centers \a rectToCenter within the width of \a size.
 */
CGRect CGRectHorizontallyCenteredInSize(CGRect rectToCenter, CGSize size);

/**
 * Multiplies the coordinates of \a rect by factor \a x horizontally and factor
 * \a y vertically.
 */
CGRect CGRectScale(CGRect rect, CGFloat x, CGFloat y);

/**
 * Vertically centers \a rectToCenter upon the center position of \a parentRect.
 * Horizontal coordinates are not considered. It is considered valid for
 * \a rectToCenter to be larger than \a parentRect.
 *
 * Note that older usages of this function (before it was included within this
 * framework) are more similar to CGRectVerticallyCenteredInSize().
 */
CGRect CGRectVerticallyCenteredInRect(CGRect rectToCenter, CGRect parentRect);

/**
 * Vertically centers \a rectToCenter within the height of \a size.
 */
CGRect CGRectVerticallyCenteredInSize(CGRect rectToCenter, CGSize size);

/**
 * Returns \c YES if \a rect is not infinite, null, or empty. If the rectangle
 * is any of aforementioned, \c NO is returned.
 */
BOOL CGRectIsValid(CGRect rect);

/**
 * Returns the smallest size that contains the two provided sizes.
 */
CGSize CGSizeUnion(CGSize a, CGSize b);

/**
 * Returns YES if \a a is greater than \a b in both dimensions.
 */
BOOL CGSizeGreaterThanSize(CGSize a, CGSize b);

/**
 * Returns YES if \a a is greater than or equal to \a b in both dimensions.
 */
BOOL CGSizeGreaterThanOrEqualToSize(CGSize a, CGSize b);

/**
 * Returns YES if \a a is less than \a b in both dimensions.
 */
BOOL CGSizeLessThanSize(CGSize a, CGSize b);

/**
 * Returns YES if \a a is less than or equal to \a b in both dimensions.
 */
BOOL CGSizeLessThanOrEqualToSize(CGSize a, CGSize b);

/**
 * Scales both dimensions of \a initial by factor \a amount.
 */
CGSize CGSizeScale(CGSize initial, CGFloat amount);

/**
 * Scales the dimensions of \a initial to fit within \a constraint while
 * preserving its aspect ratio.
 */
CGSize CGSizeScaleToFitWithinSize(CGSize initial, CGSize constraint);

/**
 * Scales the dimensions of \a initial to fit within \a constraint, even after
 * \a transform is applied. The aspect ratio of \a initial is preserved in the
 * returned size.
 */
CGSize CGSizeScaleToFitTransformedWithinSize (CGSize initial, CGAffineTransform transform, CGSize constraint);

/**
 * Rounds the dimensions of \a sz up to the nearest integer values, dropping any
 * fractional portion, and returns the new size.
 *
 * @note Rounding is done in a manner consistent with \c CGRectIntegral().
 */
CGSize CGSizeIntegral(CGSize sz);

/** @} */
