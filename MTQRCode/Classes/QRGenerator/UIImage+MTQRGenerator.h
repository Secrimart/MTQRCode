//
//  UIImage+MTQRGenerator.h
//  MTQRCode
//
//  Created by Jason Li on 2018/5/15.
//

#import <UIKit/UIKit.h>

@interface UIImage (MTQRGenerator)

+ (UIImage *)mt_QRCodeForString:(NSString *)qrString size:(CGFloat)size;
+ (UIImage *)mt_QRCodeForString:(NSString *)qrString size:(CGFloat)size fillColor:(UIColor *)fillColor;

@end
