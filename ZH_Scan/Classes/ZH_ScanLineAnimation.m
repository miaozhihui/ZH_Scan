//
//  ZH_ScanLineAnimation.m
//  Pods-ZH_Scan_Example
//
//  Created by 苗治会 on 2019/11/20.
//

#import "ZH_ScanLineAnimation.h"

@interface ZH_ScanLineAnimation ()

@property(nonatomic, assign) CGRect animationRect;

@property(nonatomic, strong) UIImageView *imageView;

/// 标识动画是否正在进行
@property(nonatomic, assign) BOOL animation;

@end

@implementation ZH_ScanLineAnimation

- (void)startAnimationWithRect:(CGRect)animationRect InView:(UIView *)parentView ImageView:(UIImageView *)imageView {
    if (self.animation) {
        return;
    }
    self.animationRect = animationRect;
    self.imageView = imageView;
    // 把扫描线添加到扫描框
    [parentView addSubview:imageView];
    // 开始循环动画
    [self loopAnimation];
    self.animation = YES;
}

- (void)stopAnimation {
    if (!self.animation) {
        return;
    }
    // 取消动画事件
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    // 恢复动画标识
    self.animation = NO;
    // 移除动画图片
    [self.imageView removeFromSuperview];
}

#pragma mark - 工具方法

- (void)loopAnimation {
    // 开始位置
    CGFloat startX = self.animationRect.origin.x;
    CGFloat startY = self.animationRect.origin.y;
    CGFloat startWidth = self.animationRect.size.width;
    CGFloat startHeight = 2;
    CGRect startRect = CGRectMake(startX, startY, startWidth, startHeight);
    // 结束位置
    CGFloat endX = self.animationRect.origin.x;
    CGFloat endY = CGRectGetMaxY(self.animationRect);
    CGFloat endWidth = self.animationRect.size.width;
    CGFloat endHeight = 2;
    CGRect endRect = CGRectMake(endX, endY, endWidth, endHeight);
    // 执行动画
    self.imageView.frame = startRect;
    [UIView animateWithDuration:2 animations:^{
        self.imageView.frame = endRect;
    } completion:^(BOOL finished) {
        [self loopAnimation];
    }];
}

@end
