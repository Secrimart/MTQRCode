//
//  UIImage+MTQRGenerator.m
//  MTQRCode
//
//  Created by Jason Li on 2018/5/15.
//

#import "UIImage+MTQRGenerator.h"

CIImage * MTQRCodeImageForString(NSString *qrString, UIColor *fillColor) {
    NSData *qrData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:qrData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
    [colorFilter setValue:qrFilter.outputImage forKey:@"inputImage"];
    [colorFilter setValue:[CIColor colorWithCGColor:fillColor.CGColor] forKey:@"inputColor0"];
    [colorFilter setValue:[CIColor colorWithCGColor:[UIColor clearColor].CGColor] forKey:@"inputColor1"];
    
    return colorFilter.outputImage;
}

@implementation UIImage (MTQRGenerator)

+ (UIImage *)mt_QRCodeForString:(NSString *)qrString size:(CGFloat)size {
    return [UIImage mt_QRCodeForString:qrString size:size fillColor:[UIColor blackColor]];
}

+ (UIImage *)mt_QRCodeForString:(NSString *)qrString size:(CGFloat)size fillColor:(UIColor *)fillColor {
    if (qrString.length == 0) {
        return nil;
    }
    
    CIImage *qrImage = MTQRCodeImageForString(qrString, fillColor);
    
    CGSize redrawSize = CGSizeMake(size, size);
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(redrawSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    return codeImage;
}

@end
