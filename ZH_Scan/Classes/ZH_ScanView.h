//
//  ZH_ScanView.h
//  Pods-ZH_Scan_Example
//
//  Created by 苗治会 on 2019/11/20.
//

#import <UIKit/UIKit.h>
#import "ZH_ScanAnimation.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZH_ScanView : UIView

/// 可以设置图片替换默认扫描框
@property(nonatomic, readonly, strong) UIImageView *scanImageView;

/// 可以设置图片替换默认扫描线条
@property(nonatomic, readonly, strong) UIImageView *lineImageView;

/// 扫码区域大小(默认300x300)
@property(nonatomic, assign) CGRect scanRect;

/// 开始扫描动画
- (void)startScanWithAnimation:(id<ZH_ScanAnimation>)animation;

/// 结束扫描动画
- (void)stopScanWithAnimation:(id<ZH_ScanAnimation>)animation;

@end

NS_ASSUME_NONNULL_END
