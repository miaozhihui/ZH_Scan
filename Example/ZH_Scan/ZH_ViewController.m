//
//  ZH_ViewController.m
//  ZH_Scan
//
//  Created by miaozhihui on 11/20/2019.
//  Copyright (c) 2019 miaozhihui. All rights reserved.
//

#import "ZH_ViewController.h"
#import <ZH_Scan/ZH_Scan.h>

@interface ZH_ViewController ()<ZH_ScanObjectDelegate>

@property(nonatomic, strong) ZH_ScanView *scanView;

@property(nonatomic, strong) ZH_ScanObject *scanObject;

@property(nonatomic, strong) ZH_ScanLineAnimation *scanLineAnimation;


@end

@implementation ZH_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scanObject.previewLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:self.scanObject.previewLayer atIndex:0];
    self.scanView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    CGFloat scanWidth = 300;
    CGFloat scanHeight = 300;
    CGFloat scanX = (self.scanView.bounds.size.width - 300) / 2;
    CGFloat scanY = (self.scanView.bounds.size.width - 300) / 2 + 88;
    self.scanView.scanRect = CGRectMake(scanX, scanY, scanWidth, scanHeight);
    [self.view addSubview:self.scanView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.scanView startScanWithAnimation:self.scanLineAnimation];
        [self.scanObject startScan];
    });
}

#pragma mark - delegate

- (void)scanObject:(ZH_ScanObject *)scanObj scanResult:(NSArray<ZH_ScanResult *> *)scanResult {
    // 停止扫描
    [scanObj stopScan];
    // 停止扫描动画
    [self.scanView stopScanWithAnimation:self.scanLineAnimation];
    
}

- (void)scanObject:(ZH_ScanObject *)scanObj scanError:(NSString *)scanError {
    [scanObj stopScan];
}

#pragma mark - lazy load

- (ZH_ScanView *)scanView {
    if (_scanView == nil) {
        _scanView = [[ZH_ScanView alloc] init];
//        _scanView.scanImageView.image = [UIImage imageNamed:@"scanBG"];
//        _scanView.lineImageView.image = [UIImage imageNamed:@"scanLine"];
    }
    return _scanView;
}

- (ZH_ScanObject *)scanObject {
    if (_scanObject == nil) {
        _scanObject = [[ZH_ScanObject alloc] init];
        _scanObject.delegate = self;
    }
    return _scanObject;
}

- (ZH_ScanLineAnimation *)scanLineAnimation {
    if (_scanLineAnimation == nil) {
        _scanLineAnimation = [[ZH_ScanLineAnimation alloc] init];
    }
    return _scanLineAnimation;
}


@end
