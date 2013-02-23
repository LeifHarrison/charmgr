//
//  CGGeometry+CMExtensions.m
//  CharMgr
//
//  Created by Leif Harrison on 11/19/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "CGGeometry+CMExtensions.h"

CGFloat CGPointDistance(CGPoint a, CGPoint b) {
	CGFloat dx = (b.x - a.x), dy = (b.y - a.y);
	return sqrt(dx*dx + dy*dy);
}

CGPoint CGPointInterp(CGPoint a, CGPoint b, CGFloat t) {
	return CGPointMake( a.x * (1.0 - t) + b.x * t, a.y * (1.0 - t) + b.y * t );
}

CGPoint CGPointSubtract(CGPoint a, CGPoint b) {
	a.x -= b.x; a.y -= b.y;
	return a;
}

CGPoint CGPointAdd(CGPoint a, CGPoint b) {
	a.x += b.x; a.y += b.y;
	return a;
}

CGFloat CGPointLengthSq(CGPoint a) {
	return (a.x*a.x + a.y*a.y);
}

CGFloat CGPointLength(CGPoint a) {
	return sqrt(a.x*a.x + a.y*a.y);
}

CGFloat CGPointDot(CGPoint a, CGPoint b) {
	return (a.x*b.x + a.y*b.y);
}

CGPoint CGPointMul(CGPoint a, CGPoint b) {
	a.x *= b.x; a.y *= b.y;
	return a;
}

CGPoint CGPointScale(CGPoint a, CGFloat s) {
	a.x *= s; a.y *= s;
	return a;
}

CGPoint CGPointAddLength(CGPoint a, CGFloat n) {
    NSCAssert(!CGPointEqualToPoint(a, CGPointZero), @"the vector provided to CGPointAddLength must not be zero");

	CGPoint ans = a;
 	CGFloat len = sqrtf((a.x * a.x) + (a.y * a.y));
 	if (len > 0.0) {
 		ans = CGPointScale(a, (len + n)/len);
 	}
 	return ans;
}

CGPoint CGPointNormalize(CGPoint a) {
 	CGPoint ans = a;
 	CGFloat len = sqrtf((a.x * a.x) + (a.y * a.y));
 	if (len > 0.0) {
 		ans = CGPointScale(a, 1.0f/len);
 	}
 	return ans;
}

CGFloat CGFloatClamp(CGFloat a, CGFloat b, CGFloat t) {
	return (a > t) ? a : ((t < b) ? t : b);
}

CGFloat CGPointProjectOntoLine(CGPoint l1, CGPoint l2, CGPoint p) {
	CGPoint line = CGPointSubtract(l2, l1);
	CGPoint proj = CGPointSubtract(p, l1);
	
	return CGPointDot(proj, line) / CGPointLengthSq(line);
}

CGPoint CGPointUnitDirec(CGPoint start, CGPoint end) {
	CGPoint direc = CGPointSubtract(end, start);
	CGFloat len = CGPointLength(direc);
	return CGPointScale(direc, 1.0f/len);
}

CGPoint CGPointMoveInDirec(CGPoint start, CGPoint direc, CGFloat scale) {
	return CGPointAdd(start, CGPointScale(direc, scale));
}

CGPoint CGPointIntegral(CGPoint p) {
	return CGPointMake(floor(p.x), floor(p.y));
}

BOOL CGPointIsZero(CGPoint p) {
	return (p.x == 0.0f) && (p.y == 0.0f);
}

CGPoint CGRectCenterPoint(CGRect rect) {
	return CGPointMake(
		rect.origin.x + rect.size.width  / 2,
		rect.origin.y + rect.size.height / 2
	);
}

CGRect CGRectChop(CGRect rect, CGFloat value, CGRectEdge edge) {
	CGRect slice, remainder;
	CGRectDivide(rect, &slice, &remainder, value, edge);
	return remainder;
}

CGRect CGRectSlice(CGRect rect, CGFloat value, CGRectEdge edge) {
    CGRect slice, remainder;
    CGRectDivide(rect, &slice, &remainder, value, edge);
    return slice;
}

CGRect CGRectGrow(CGRect rect, CGFloat value, CGRectEdge edge) {
	switch (edge) {
	case CGRectMinXEdge: return CGRectMake(rect.origin.x - value, rect.origin.y        , rect.size.width + value, rect.size.height        );
	case CGRectMaxXEdge: return CGRectMake(rect.origin.x        , rect.origin.y        , rect.size.width + value, rect.size.height        );
	case CGRectMinYEdge: return CGRectMake(rect.origin.x        , rect.origin.y - value, rect.size.width        , rect.size.height + value);
	case CGRectMaxYEdge: return CGRectMake(rect.origin.x        , rect.origin.y        , rect.size.width        , rect.size.height + value);
	default:
		NSCAssert1(NO, @"invalid CGRectEdge %i provided to CGRectGrow()", (int)edge);
	}
	
	return rect;
}

CGRect CGRectOffsetAndShrink(CGRect rect, CGFloat dx, CGFloat dy)
{
	rect.size.width -= dx;
	rect.size.height -= dy;
	
	return CGRectOffset(rect, dx, dy);
}

void CGRectDivideWithPadding (CGRect rect, CGRect *slice, CGRect *remainder, CGFloat contentAmount, CGFloat padding, CGRectEdge edge) {
	CGRect outSlice;
	CGRect outRemainder;
	CGRectDivide(rect, &outSlice, &outRemainder, contentAmount, edge);
	
	if (slice)
		*slice = outSlice;
	
	if (remainder)
		*remainder = CGRectChop(outRemainder, padding, edge);
}

CGRect CGRectWithCenterAndSize(CGPoint center, CGSize size) {
	return CGRectMake(center.x - (size.width / 2), center.y - (size.height / 2),
					  size.width, size.height);
}

CGRect CGRectWithOriginAndSize(CGPoint origin, CGSize size) {
	return CGRectMake(origin.x, origin.y, size.width, size.height);
}

CGRect CGRectWithSize(CGSize size) {
    return CGRectMake(0, 0, size.width, size.height);
}

CGRect CGRectCenteredInRect(CGRect rectToCenter, CGRect parentRect) {
    return CGRectMake(
        parentRect.origin.x + floor(parentRect.size.width  / 2 - rectToCenter.size.width  / 2),
        parentRect.origin.y + floor(parentRect.size.height / 2 - rectToCenter.size.height / 2),
        rectToCenter.size.width,
        rectToCenter.size.height
    );
}

CGRect CGRectCenteredInSize(CGRect rectToCenter, CGSize size) {
    return CGRectMake(
        floor(size.width  / 2 - rectToCenter.size.width  / 2),
        floor(size.height / 2 - rectToCenter.size.height / 2),
        rectToCenter.size.width,
        rectToCenter.size.height
    );
}

CGRect CGRectCenteredOnPoint(CGRect rectToCenter, CGPoint point) {
	return CGRectMake(
		floor(point.x - rectToCenter.size.width  / 2),
		floor(point.y - rectToCenter.size.height / 2),
		rectToCenter.size.width,
		rectToCenter.size.height
	);
}

CGRect CGRectHorizontallyCenteredInRect(CGRect rectToCenter, CGRect parentRect) {
    return CGRectMake(
        parentRect.origin.x + floor(parentRect.size.width  / 2 - rectToCenter.size.width  / 2),
        rectToCenter.origin.y,
        rectToCenter.size.width,
        rectToCenter.size.height
    );
}

CGRect CGRectHorizontallyCenteredInSize(CGRect rectToCenter, CGSize size) {
    return CGRectMake(
        floor(size.width  / 2 - rectToCenter.size.width  / 2),
        rectToCenter.origin.y,
        rectToCenter.size.width,
        rectToCenter.size.height
    );
}

CGRect CGRectScale(CGRect rect, CGFloat x, CGFloat y) {
	return CGRectMake(
		rect.origin.x *= x,
		rect.origin.y *= y,
		rect.size.width  *= x,
		rect.size.height *= y
	);
}

CGRect CGRectVerticallyCenteredInRect(CGRect rectToCenter, CGRect parentRect) {
    return CGRectMake(
        rectToCenter.origin.x,
        parentRect.origin.y + floor(parentRect.size.height / 2 - rectToCenter.size.height / 2),
        rectToCenter.size.width,
        rectToCenter.size.height
    );
}

CGRect CGRectVerticallyCenteredInSize(CGRect rectToCenter, CGSize size) {
    return CGRectMake(
        rectToCenter.origin.x,
        floor(size.height / 2 - rectToCenter.size.height / 2),
        rectToCenter.size.width,
        rectToCenter.size.height
    );
}

BOOL CGRectIsValid(CGRect rect) {
	return
		!CGRectIsEmpty(rect) &&
		!CGRectIsInfinite(rect) &&
		!CGRectIsNull(rect)
	;
}

CGSize CGSizeScale(CGSize initial, CGFloat amount) {
	return CGSizeMake(initial.width * amount, initial.height * amount);
}

CGSize CGSizeUnion(CGSize a, CGSize b) {
    return CGSizeMake(fmax(a.width, b.width), fmax(a.height, b.height));
}

BOOL CGSizeGreaterThanSize(CGSize a, CGSize b) {
    return a.width >  b.width && a.height >  b.height;
}

BOOL CGSizeGreaterThanOrEqualToSize(CGSize a, CGSize b) {
    return a.width >= b.width && a.height >= b.height;
}

BOOL CGSizeLessThanSize(CGSize a, CGSize b) {
    return a.width <  b.width && a.height <  b.height;
}

BOOL CGSizeLessThanOrEqualToSize(CGSize a, CGSize b) {
    return a.width <= b.width && a.height <= b.height;
}

CGSize CGSizeScaleToFitWithinSize(CGSize initial, CGSize constraint) {
	return CGSizeScaleToFitTransformedWithinSize(initial, CGAffineTransformIdentity, constraint);
}

CGSize CGSizeScaleToFitTransformedWithinSize (CGSize initial, CGAffineTransform transform, CGSize constraint) {
	if (initial.width == 0 || initial.height == 0) {
		// zero scaled is still going to be zero
		return CGSizeZero;
	}

	// use a faux rectangle of the initial size so that we get a bounding box
	// after transforming, not just the transformed width/height
	CGRect initialRect = CGRectWithSize(initial);
	CGRect transformedRect = CGRectApplyAffineTransform(initialRect, transform);

	// now use the size of the transformed bounding box
	CGSize transformedSize = transformedRect.size;
	
	// use whichever dimension requires the least scaling for the final result,
	// thus preserving the aspect ratio
	CGFloat horizontalRatio = constraint.width / transformedSize.width;
	CGFloat verticalRatio = constraint.height / transformedSize.height;
	CGFloat ratio = fmin(horizontalRatio, verticalRatio);

	// and finally, return the scaled size
	return CGSizeMake(
		initial.width * ratio,
		initial.height * ratio
	);
}

CGSize CGSizeIntegral(CGSize sz) {
	return CGSizeMake(ceil(sz.width), ceil(sz.height));
}
