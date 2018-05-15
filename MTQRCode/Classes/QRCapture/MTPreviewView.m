//
//  MTPreviewView.m
//  MTQRCode
//
//  Created by Jason Li on 2018/5/15.
//

#import "MTPreviewView.h"

@implementation MTPreviewView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (CGRect)previewRect {
    CGRect scanRect = CGRectZero;
    scanRect.size.width = CGRectGetWidth(self.bounds) - kFillEdgeInsets.left - kFillEdgeInsets.right - kBorderEdgeInsets.left - kBorderEdgeInsets.right;
    scanRect.size.height = scanRect.size.width;
    scanRect.origin.x = kFillEdgeInsets.left + kBorderEdgeInsets.left;
    scanRect.origin.y = (CGRectGetHeight(self.bounds) - CGRectGetHeight(scanRect))/2.f;
    
    return scanRect;
}

- (CGRect)previewRectOfInterest {
    CGRect scanRect = [self previewRect];
    CGRect interest = CGRectZero;
    interest.origin.x = (scanRect.origin.y - 10)/CGRectGetHeight(self.bounds);
    interest.origin.y = (scanRect.origin.x - 10)/CGRectGetWidth(self.bounds);
    interest.size.width = (scanRect.size.width + 10)/CGRectGetHeight(self.bounds);
    interest.size.height = (scanRect.size.height + 10)/CGRectGetWidth(self.bounds);
    
    return interest;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, kFillColor.CGColor);
    CGContextFillRect(ctx, self.bounds);
    
    CGRect clearRect = CGRectZero;
    clearRect.size.width = CGRectGetWidth(rect) - kFillEdgeInsets.left - kFillEdgeInsets.right;
    clearRect.size.height = clearRect.size.width;
    clearRect.origin.x = kFillEdgeInsets.left;
    clearRect.origin.y = (CGRectGetHeight(rect) - CGRectGetHeight(clearRect))/2;
    
    CGContextClearRect(ctx, clearRect);
    
    //Drawing Border
    CGContextSetLineWidth(ctx, keyLineWidth);//制定了线的宽度
    CGContextSetStrokeColorWithColor(ctx, kBorderColor.CGColor);
    
    CGPoint startPoint = CGPointMake(CGRectGetMinX(clearRect) + kBorderEdgeInsets.left, CGRectGetMinY(clearRect) + (3*kBorderEdgeInsets.top));
    CGPoint endPoint = CGPointMake(startPoint.x, CGRectGetMinY(clearRect) + kBorderEdgeInsets.top);
    CGContextMoveToPoint(ctx, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(ctx, endPoint.x, endPoint.y);
    CGContextStrokePath(ctx);
    
    startPoint = endPoint;
    endPoint = CGPointMake(CGRectGetMinX(clearRect) + (3*kBorderEdgeInsets.left), startPoint.y);
    CGContextMoveToPoint(ctx, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(ctx, endPoint.x, endPoint.y);
    CGContextStrokePath(ctx);
    
    startPoint = CGPointMake(CGRectGetMaxX(clearRect) - (3*kBorderEdgeInsets.left), CGRectGetMinY(clearRect) + kBorderEdgeInsets.top);
    endPoint = CGPointMake(CGRectGetMaxX(clearRect) - kBorderEdgeInsets.left, startPoint.y);
    CGContextMoveToPoint(ctx, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(ctx, endPoint.x, endPoint.y);
    CGContextStrokePath(ctx);
    
    startPoint = endPoint;
    endPoint = CGPointMake(startPoint.x, CGRectGetMinY(clearRect) + (3*kBorderEdgeInsets.top));
    CGContextMoveToPoint(ctx, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(ctx, endPoint.x, endPoint.y);
    CGContextStrokePath(ctx);
    
    startPoint = CGPointMake(CGRectGetMaxX(clearRect) - kBorderEdgeInsets.left, CGRectGetMaxY(clearRect) - (3*kBorderEdgeInsets.top));
    endPoint = CGPointMake(startPoint.x, CGRectGetMaxY(clearRect) - kBorderEdgeInsets.top);
    CGContextMoveToPoint(ctx, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(ctx, endPoint.x, endPoint.y);
    CGContextStrokePath(ctx);
    
    startPoint = endPoint;
    endPoint = CGPointMake(CGRectGetMaxX(clearRect) - (3*kBorderEdgeInsets.left), startPoint.y);
    CGContextMoveToPoint(ctx, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(ctx, endPoint.x, endPoint.y);
    CGContextStrokePath(ctx);
    
    startPoint = CGPointMake(CGRectGetMinX(clearRect) + (3*kBorderEdgeInsets.left), CGRectGetMaxY(clearRect) - kBorderEdgeInsets.top);
    endPoint = CGPointMake(CGRectGetMinX(clearRect) + kBorderEdgeInsets.left, startPoint.y);
    CGContextMoveToPoint(ctx, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(ctx, endPoint.x, endPoint.y);
    CGContextStrokePath(ctx);
    
    startPoint = endPoint;
    endPoint = CGPointMake(startPoint.x, CGRectGetMaxY(clearRect) - (3*kBorderEdgeInsets.top));
    CGContextMoveToPoint(ctx, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(ctx, endPoint.x, endPoint.y);
    CGContextStrokePath(ctx);
    
    //Drawing Scan
    CGContextSetLineWidth(ctx, keyLineWidth);//制定了线的宽度
    CGContextSetStrokeColorWithColor(ctx, kScanColor.CGColor);
    
    startPoint = CGPointMake(CGRectGetMinX(clearRect) + kBorderEdgeInsets.left, CGRectGetMidY(clearRect));
    endPoint = CGPointMake(CGRectGetMaxX(clearRect) - kBorderEdgeInsets.left, startPoint.y);
    CGContextMoveToPoint(ctx, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(ctx, endPoint.x, endPoint.y);
    CGContextStrokePath(ctx);
    
}

@end
