//
//  MTQRCodeScanViewController.m
//  MTQRCode
//
//  Created by Jason Li on 2018/5/15.
//

#import "MTQRCodeScanViewController.h"
#import <AVFoundation/AVFoundation.h>

#import "MTPreviewView.h"

static const char *kScanQRCodeQueueName = "ScanQRCodeQueue";

@interface MTQRCodeScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *captureMetadataOutput;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreivewLayer;

@property (nonatomic, strong) MTPreviewView *viewScan;

@end

@implementation MTQRCodeScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.viewScan];
    [self.view.layer insertSublayer:self.videoPreivewLayer atIndex:0];
    
    [self startRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [self.viewScan setFrame:self.view.bounds];
    [self.videoPreivewLayer setFrame:self.viewScan.layer.bounds];
    self.captureMetadataOutput.rectOfInterest = [self.viewScan previewRectOfInterest];
    
}

- (void)startRunning {
    if (![self.captureSession isRunning]) {
        [self.captureSession startRunning];
    }
}

- (void)stopRunning {
    if ([self.captureSession isRunning]) {
        [self.captureSession stopRunning];
    }
}

//MARK: - Getter And Setter
- (AVCaptureDeviceInput *)input {
    if (_input) return _input;
    // 获取 AVCaptureDevice 实例
    NSError * error;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 初始化输入流
    _input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!_input) {
        NSLog(@"%@", [error localizedDescription]);
        return nil;
    }
    return _input;
}

- (AVCaptureMetadataOutput *)captureMetadataOutput {
    if (_captureMetadataOutput) return _captureMetadataOutput;
    _captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    //设置扫描范围
    _captureMetadataOutput.rectOfInterest = [self.viewScan previewRectOfInterest];
    
    return _captureMetadataOutput;
}

- (AVCaptureSession *)captureSession {
    if (_captureSession) return _captureSession;
    if (!self.input) {
        return nil;
    }
    _captureSession = [[AVCaptureSession alloc] init];
    //提高图片质量为1080P，提高识别效果
    _captureSession.sessionPreset = AVCaptureSessionPreset1920x1080;
    // 添加输入流
    [_captureSession addInput:self.input];
    // 添加输出流
    [_captureSession addOutput:self.captureMetadataOutput];
    
    // 创建dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create(kScanQRCodeQueueName, NULL);
    [_captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    // 设置元数据类型 AVMetadataObjectTypeQRCode
    [self.captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    return _captureSession;
}

- (AVCaptureVideoPreviewLayer *)videoPreivewLayer {
    if (_videoPreivewLayer) return _videoPreivewLayer;
    _videoPreivewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    [_videoPreivewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreivewLayer setFrame:self.viewScan.layer.bounds];
    
    return _videoPreivewLayer;
}

- (MTPreviewView *)viewScan {
    if (_viewScan) return _viewScan;
    _viewScan = [[MTPreviewView alloc] initWithFrame:self.view.bounds];
    return _viewScan;
}

//MARK: - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        [self stopRunning];
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        NSString *result;
        BOOL isQRCode = NO;
        
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            isQRCode = YES;
            result = metadataObj.stringValue;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.blockCompletion) self.blockCompletion(result,isQRCode);
        });
        
    }
    return;
}

@end
