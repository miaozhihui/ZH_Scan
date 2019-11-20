//
//  ZH_ScanResult.h
//  Pods-ZH_Scan_Example
//
//  Created by 苗治会 on 2019/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZH_ScanResult : NSObject

/// 扫描字符串
@property(nonatomic, copy) NSString *scanStr;

/// 扫描编码类型
@property(nonatomic, copy) NSString *scanCodeType;

@end

NS_ASSUME_NONNULL_END
