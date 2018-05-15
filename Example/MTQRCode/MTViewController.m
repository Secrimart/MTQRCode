//
//  MTViewController.m
//  MTQRCode
//
//  Created by rstx_reg@aliyun.com on 05/15/2018.
//  Copyright (c) 2018 rstx_reg@aliyun.com. All rights reserved.
//

#import "MTViewController.h"

@import MTQRCode;
@import Masonry;

@interface MTViewController ()
@property (nonatomic, strong) MTQRCodeScanViewController *scanVC;
@property (nonatomic, strong) MTQRCaptureViewController *captureVC;

@property (nonatomic, strong) UIButton *captureButton;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *generateButton;

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation MTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.textView];
    [self.view addSubview:self.captureButton];
    [self.view addSubview:self.generateButton];
    [self.view addSubview:self.imgView];
    
    __weak typeof(self) weakSelf = self;
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.top.mas_equalTo(64.f);
        make.right.mas_equalTo(- 15.f);
        make.height.mas_equalTo(64.f*2);
    }];
    
    
    [self.captureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.textView);
        make.height.mas_equalTo(44.f);
        make.top.mas_equalTo(weakSelf.textView.mas_bottom).mas_offset(10.f);
        make.right.mas_equalTo(weakSelf.generateButton.mas_left).mas_offset(-10.f);
    }];
    
    [self.generateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.textView);
        make.height.top.mas_equalTo(weakSelf.captureButton);
        make.left.mas_equalTo(weakSelf.captureButton.mas_right).mas_offset(10.f);
        make.width.mas_equalTo(weakSelf.captureButton.mas_width);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.captureButton.mas_bottom).mas_equalTo(10.f);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.width.mas_equalTo(weakSelf.imgView.mas_height);
        make.bottom.mas_lessThanOrEqualTo(- 8.f);
        make.left.mas_lessThanOrEqualTo(15.f);
        make.right.mas_lessThanOrEqualTo(-15.f);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: - Action
- (void)toOperCaptureButton {
    [self.imgView setHidden:YES];
    __weak typeof(self) weakSelf = self;
    self.captureVC = [MTQRCaptureViewController QRCapturePresentController:self withTitle:@"Scan QRCode" captureCompletion:^(NSString *codeString, BOOL isQRCode) {
        if (isQRCode) {
            weakSelf.textView.text = codeString;
        }
    }];
}

- (void)toOperGenerateButton {
    [self.view endEditing:YES];
    if (self.textView.text.length == 0) {
        [self.textView becomeFirstResponder];
        return;
    }
    
    [self.imgView setHidden:NO];
    UIImage *qrImage = [UIImage mt_QRCodeForString:self.textView.text size:CGRectGetHeight(self.imgView.bounds) - 10.f fillColor:[UIColor darkGrayColor]];
    [self.imgView setImage:qrImage];
}

//MARK: - Getter And Setter
- (MTQRCodeScanViewController *)scanVC {
    if (_scanVC) return _scanVC;
    _scanVC = [[MTQRCodeScanViewController alloc] init];
    
    return _scanVC;
}

- (UITextView *)textView {
    if (_textView) return _textView;
    _textView = [[UITextView alloc] init];
    _textView.text = @"will show capture QRCode string.";
    
    _textView.layer.borderColor = [UIColor blackColor].CGColor;
    _textView.layer.borderWidth = 0.5f;
    _textView.layer.cornerRadius = 4.f;
    
    return _textView;
}

- (UIButton *)captureButton {
    if (_captureButton) return _captureButton;
    _captureButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_captureButton setTitle:@"Capture" forState:UIControlStateNormal];
    
    _captureButton.layer.borderColor = [UIColor blackColor].CGColor;
    _captureButton.layer.borderWidth = 0.5f;
    _captureButton.layer.cornerRadius = 4.f;
    
    [_captureButton addTarget:self action:@selector(toOperCaptureButton) forControlEvents:UIControlEventTouchUpInside];
    
    return _captureButton;
}

- (UIButton *)generateButton {
    if (_generateButton) return _generateButton;
    _generateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_generateButton setTitle:@"Generate" forState:UIControlStateNormal];
    
    _generateButton.layer.borderColor = [UIColor blackColor].CGColor;
    _generateButton.layer.borderWidth = 0.5f;
    _generateButton.layer.cornerRadius = 4.f;
    
    [_generateButton addTarget:self action:@selector(toOperGenerateButton) forControlEvents:UIControlEventTouchUpInside];
    
    return _generateButton;
}

- (UIImageView *)imgView {
    if (_imgView) return _imgView;
    _imgView = [[UIImageView alloc] init];
    _imgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [_imgView setHidden:YES];
    
    return _imgView;
}

@end
