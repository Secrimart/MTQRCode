//
//  MTPreviewView.h
//  MTQRCode
//
//  Created by Jason Li on 2018/5/15.
//

#import <UIKit/UIKit.h>

#define kFillEdgeInsets UIEdgeInsetsMake(10, 10, 10, 10)
#define kBorderEdgeInsets UIEdgeInsetsMake(15, 15, 15, 15)

#define kFillColor [[UIColor alloc] initWithWhite:0.0f alpha:0.4]
#define kBorderColor [UIColor greenColor]
#define kScanColor [UIColor redColor]
#define keyLineWidth 1.0f

@interface MTPreviewView : UIView

- (CGRect)previewRect;
- (CGRect)previewRectOfInterest;

@end
