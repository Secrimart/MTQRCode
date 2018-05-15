//
//  NSString+LocaliziedString.m
//  MTQRCode
//
//  Created by Jason Li on 2018/5/15.
//

#import "NSString+LocaliziedString.h"
#import "MTPreviewView.h"

@implementation NSString (LocaliziedString)

+ (NSString *)mt_LocaliziedStringForKey:(NSString *)key {
    NSString *bundleResourcePath = [NSBundle bundleForClass:[MTPreviewView class]].resourcePath;
    NSString *assetsPath = [bundleResourcePath stringByAppendingPathComponent:@"MTQRCodeAssets.bundle"];
    NSBundle *assetsBundle = [NSBundle bundleWithPath:assetsPath];
    if (assetsBundle) {
        return NSLocalizedStringFromTableInBundle(key, @"MTQRCodeLocalizable", assetsBundle, nil);
    }
    return key;
}

@end
