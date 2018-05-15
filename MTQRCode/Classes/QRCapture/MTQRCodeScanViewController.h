//
//  MTQRCodeScanViewController.h
//  MTQRCode
//
//  Created by Jason Li on 2018/5/15.
//

#import <UIKit/UIKit.h>
typedef void (^MTQRCaptureCompletion)(NSString *codeString, BOOL isQRCode);

@interface MTQRCodeScanViewController : UIViewController
@property (nonatomic, copy) MTQRCaptureCompletion blockCompletion;

- (void)startRunning;
- (void)stopRunning;

@end
