//
//  ZH_ScanAnimation.h
//  Pods-ZH_Scan_Example
//
//  Created by 苗治会 on 2019/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZH_ScanAnimation <NSObject>

@required

/// 扫描动画协议
/// @param animationRect 扫描动画区域
/// @param parentView 扫描动画父视图
/// @param imageView 扫描动画图片
- (void)startAnimationWithRect:(CGRect)animationRect InView:(UIView *)parentView ImageView:(UIImageView *)imageView;

/// 停止动画
- (void)stopAnimation;

@end

NS_ASSUME_NONNULL_END
