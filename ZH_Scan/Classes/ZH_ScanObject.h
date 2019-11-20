//
//  ZH_ScanObject.h
//  Pods-ZH_Scan_Example
//
//  Created by 苗治会 on 2019/11/20.
//

#import <Foundation/Foundation.h>
#import "ZH_ScanResult.h"

NS_ASSUME_NONNULL_BEGIN

@class ZH_ScanObject;

@protocol ZH_ScanObjectDelegate <NSObject>

- (void)scanObject:(ZH_ScanObject *)scanObj scanResult:(NSArray<ZH_ScanResult *> *)scanResult;

- (void)scanObject:(ZH_ScanObject *)scanObj scanError:(NSString *)scanError;

@end

@interface ZH_ScanObject : NSObject

/// 是否开启自动对焦(默认开启YES)
@property(nonatomic, assign) BOOL openAutoFocus;

/// 扫描有效区域(默认全屏)
@property(nonatomic, assign) CGRect scanActiveArea;

/// 显示摄像机的Layer层
@property(nonatomic, readonly, strong) CALayer *previewLayer;

@property(nonatomic, weak) id<ZH_ScanObjectDelegate> delegate;

/// 打开手电筒
- (void)openTorch;

/// 关闭手电筒
- (void)closeTorch;

/// 开始扫描
- (void)startScan;

/// 停止扫描
- (void)stopScan;

@end

NS_ASSUME_NONNULL_END
