//
//  ZH_ScanView.m
//  Pods-ZH_Scan_Example
//
//  Created by 苗治会 on 2019/11/20.
//

#import "ZH_ScanView.h"

// 获取当前bundle资源宏定义
#define kZH_ScanResourceName(file) [@"Frameworks/ZH_Scan.framework/ZH_Scan.bundle" stringByAppendingPathComponent:file]

@interface ZH_ScanView ()

@property(nonatomic, strong) UIImageView *scanImageView;

@property(nonatomic, strong) UIImageView *lineImageView;

/// 蒙层视图列表
@property(nonatomic, strong) NSMutableArray *overViewList;

@end

@implementation ZH_ScanView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 1、初始化页面
        self.scanRect = CGRectMake(0, 0, 300, 300);
        // 2、添加扫码框
        [self addSubview:self.scanImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 1、布局扫码框
    if (CGRectEqualToRect(self.scanRect, CGRectMake(0, 0, 300, 300))) {
        CGFloat scanX = (CGRectGetWidth(self.bounds) - CGRectGetWidth(self.scanRect)) / 2;
        CGFloat scanY = (CGRectGetHeight(self.bounds) - CGRectGetHeight(self.scanRect)) / 2;
        CGFloat scanWidth = self.scanRect.size.width;
        CGFloat scanHeight = self.scanRect.size.height;
        self.scanImageView.frame = CGRectMake(scanX, scanY, scanWidth, scanHeight);
    } else {
        self.scanImageView.frame = self.scanRect;
    }
    // 2、添加扫描框旁边蒙层
    [self setOverView];
}

#pragma mark - public method

- (void)startScanWithAnimation:(id<ZH_ScanAnimation>)animation {
    if (CGRectEqualToRect(self.scanRect, CGRectMake(0, 0, 300, 300))) {
       [animation startAnimationWithRect:self.scanRect InView:self.scanImageView ImageView:self.lineImageView];
    } else {
        [animation startAnimationWithRect:self.scanImageView.frame InView:self ImageView:self.lineImageView];
    }
}

- (void)stopScanWithAnimation:(id<ZH_ScanAnimation>)animation {
    [animation stopAnimation];
}

#pragma mark - tool method

- (void)setOverView {
    if (self.overViewList.count == 4) {
        return;
    }
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    CGFloat x = CGRectGetMinX(self.scanImageView.frame);
    CGFloat y = CGRectGetMinY(self.scanImageView.frame);
    CGFloat w = CGRectGetWidth(self.scanImageView.frame);
    CGFloat h = CGRectGetHeight(self.scanImageView.frame);
    
    [self creatView:CGRectMake(0, 0, width, y)];
    [self creatView:CGRectMake(0, y, x, h)];
    [self creatView:CGRectMake(0, y + h, width, height - y - h)];
    [self creatView:CGRectMake(x + w, y, width - x - w, h)];
}

- (void)creatView:(CGRect)rect {
    CGFloat alpha = 0.5;
    UIColor *backColor = [UIColor grayColor];
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = backColor;
    view.alpha = alpha;
    [self addSubview:view];
    [self.overViewList addObject:view];
}

#pragma mark - lazy load

- (UIImageView *)scanImageView {
    if (_scanImageView == nil) {
        NSString *path = [[NSBundle bundleForClass:self.class] pathForResource:@"ZH_Scan" ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:path];
        NSString *file = [bundle pathForResource:@"scanBG" ofType:@"png"];
        UIImage *img = [UIImage imageWithContentsOfFile:file];
        _scanImageView = [[UIImageView alloc] initWithImage:img];
        _scanImageView.backgroundColor = UIColor.clearColor;
    }
    return _scanImageView;
}

- (UIImageView *)lineImageView {
    if (_lineImageView == nil) {
        _lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kZH_ScanResourceName(@"scanLine")]];
    }
    return _lineImageView;
}

- (NSMutableArray *)overViewList {
    if (_overViewList == nil) {
        _overViewList = [NSMutableArray arrayWithCapacity:4];
    }
    return _overViewList;
}

@end
