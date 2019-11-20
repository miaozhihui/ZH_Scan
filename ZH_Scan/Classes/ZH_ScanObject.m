//
//  ZH_ScanObject.m
//  Pods-ZH_Scan_Example
//
//  Created by 苗治会 on 2019/11/20.
//

#import "ZH_ScanObject.h"
#import <AVFoundation/AVFoundation.h>

@interface ZH_ScanObject ()<AVCaptureMetadataOutputObjectsDelegate>

/// 捕获会话
@property(nonatomic, strong) AVCaptureSession *captureSession;

/// 捕获设备
@property(nonatomic, strong) AVCaptureDevice *device;

/// 设备输入流
@property(nonatomic, strong) AVCaptureDeviceInput *deviceInput;

/// 设备输出流
@property(nonatomic, strong) AVCaptureMetadataOutput *deviceOutput;

/// 设备显示Layer
@property(nonatomic, strong) AVCaptureVideoPreviewLayer *showLayer;

@end

@implementation ZH_ScanObject

- (instancetype)init {
    if (self = [super init]) {
        _openAutoFocus = true;
        _scanActiveArea = CGRectZero;
        // 给session添加输入源
        if ([self.captureSession canAddInput:self.deviceInput]) {
            [self.captureSession addInput:self.deviceInput];
        }
        // 开启自动对焦
        [self openAutoFocus:_openAutoFocus];
        // 自动打开手电筒
        [self openAutoTorch];
        // 给session添加输出源
        if ([self.captureSession canAddOutput:self.deviceOutput]) {
            [self.captureSession addOutput:self.deviceOutput];
        }
        // 设置扫码支持的默认格式
        self.deviceOutput.metadataObjectTypes = [self defaultSupportTypesForOutput:self.deviceOutput];
    }
    return self;
}

#pragma mark - public method

- (void)openTorch {
    [self.device lockForConfiguration:nil];
    self.device.torchMode = AVCaptureTorchModeOn;
    [self.device unlockForConfiguration];
}

- (void)closeTorch {
    [self.device lockForConfiguration:nil];
    self.device.torchMode = AVCaptureTorchModeOff;
    [self.device unlockForConfiguration];
}

- (void)startScan {
    if (self.captureSession.isRunning) {
        return;
    }
    [self.captureSession startRunning];
}

- (void)stopScan {
    if (!self.captureSession.isRunning) {
        return;
    }
    [self.captureSession stopRunning];
}

#pragma mark - delegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count > 0) {
        NSMutableArray *resultArray = [NSMutableArray array];
        for (AVMetadataObject *metadataObject in metadataObjects) {
            if ([metadataObject isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
                ZH_ScanResult *scanResult = [[ZH_ScanResult alloc] init];
                scanResult.scanStr = ((AVMetadataMachineReadableCodeObject *)metadataObject).stringValue;
                scanResult.scanCodeType = metadataObject.type;
                [resultArray addObject:scanResult];
            }
        }
        if ([self.delegate respondsToSelector:@selector(scanObject:scanResult:)]) {
            [self.delegate scanObject:self scanResult:resultArray];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(scanObject:scanError:)]) {
            [self.delegate scanObject:self scanError:@"扫描失败"];
        }
    }
}

#pragma mark - setter/getter

- (void)setOpenAutoFocus:(BOOL)openAutoFocus {
    if (_openAutoFocus != openAutoFocus) {
        _openAutoFocus = openAutoFocus;
        [self openAutoFocus:openAutoFocus];
    }
}

- (void)setScanActiveArea:(CGRect)scanActiveArea {
    if (CGRectEqualToRect(CGRectZero, scanActiveArea)) {
        return;
    }
    _scanActiveArea = scanActiveArea;
    self.deviceOutput.rectOfInterest = scanActiveArea;
}

- (CALayer *)previewLayer {
    return self.showLayer;
}

#pragma mark - tool method

- (void)openAutoTorch {
    [self.device lockForConfiguration:nil];
    self.device.torchMode = AVCaptureTorchModeAuto;
    [self.device unlockForConfiguration];
}

- (void)openAutoFocus:(BOOL)autoFocus {
    if (autoFocus && self.device.isFocusPointOfInterestSupported && [self.device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        [self.device lockForConfiguration:nil];
        self.device.focusMode = AVCaptureFocusModeContinuousAutoFocus;
        [self.device unlockForConfiguration];
    } else {
        [self.device lockForConfiguration:nil];
        self.device.focusMode = AVCaptureFocusModeLocked;
        [self.device unlockForConfiguration];
    }
}

- (NSArray *)defaultSupportTypesForOutput:(AVCaptureMetadataOutput *)output {
    NSMutableArray *supportTypes = [NSMutableArray array];
    if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeFace]) {
        [supportTypes addObject:AVMetadataObjectTypeFace];
    }
    if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
        [supportTypes addObject:AVMetadataObjectTypeQRCode];
    }
    if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN8Code]) {
        [supportTypes addObject:AVMetadataObjectTypeEAN8Code];
    }
    if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeUPCECode]) {
        [supportTypes addObject:AVMetadataObjectTypeUPCECode];
    }
    if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeAztecCode]) {
        [supportTypes addObject:AVMetadataObjectTypeAztecCode];
    }
    if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN13Code]) {
        [supportTypes addObject:AVMetadataObjectTypeEAN13Code];
    }
    if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeITF14Code]) {
        [supportTypes addObject:AVMetadataObjectTypeITF14Code];
    }
    if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode39Code]) {
        [supportTypes addObject:AVMetadataObjectTypeCode39Code];
    }
    if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode93Code]) {
        [supportTypes addObject:AVMetadataObjectTypeCode93Code];
    }
    if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeDataMatrixCode]) {
        [supportTypes addObject:AVMetadataObjectTypeDataMatrixCode];
    }
    if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode39Mod43Code]) {
        [supportTypes addObject:AVMetadataObjectTypeCode39Mod43Code];
    }
    if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeInterleaved2of5Code]) {
        [supportTypes addObject:AVMetadataObjectTypeInterleaved2of5Code];
    }
    if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode128Code]) {
        [supportTypes addObject:AVMetadataObjectTypeCode128Code];
    }
    if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypePDF417Code]) {
        [supportTypes addObject:AVMetadataObjectTypePDF417Code];
    }
    return supportTypes.copy;
}

#pragma mark - lazy load

- (AVCaptureSession *)captureSession {
    if (_captureSession == nil) {
        _captureSession = [[AVCaptureSession alloc] init];
        if ([_captureSession canSetSessionPreset:AVCaptureSessionPresetHigh]) {
            _captureSession.sessionPreset = AVCaptureSessionPresetHigh;
        }
    }
    return _captureSession;
}

- (AVCaptureDevice *)device {
    if (_device == nil) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

- (AVCaptureDeviceInput *)deviceInput {
    if (_deviceInput == nil) {
        _deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return _deviceInput;
}

- (AVCaptureMetadataOutput *)deviceOutput {
    if (_deviceOutput == nil) {
        _deviceOutput = [[AVCaptureMetadataOutput alloc] init];
        [_deviceOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        _deviceOutput.rectOfInterest = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    }
    return _deviceOutput;
}

- (AVCaptureVideoPreviewLayer *)showLayer {
    if (_showLayer == nil) {
        _showLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        _showLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return _showLayer;
}

@end
