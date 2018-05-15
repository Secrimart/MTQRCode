//
//  MTQRCaptureViewController.h
//  MTQRCode
//
//  Created by Jason Li on 2018/5/15.
//

#import <UIKit/UIKit.h>

@interface MTQRCaptureViewController : UIViewController

+ (instancetype)QRCapturePresentController:(UIViewController *)viewController
                                 withTitle:(NSString *)title
                         captureCompletion:(void (^)(NSString *codeString, BOOL isQRCode))completion;

@end
