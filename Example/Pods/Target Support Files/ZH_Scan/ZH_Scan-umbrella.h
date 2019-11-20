#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ZH_Scan.h"
#import "ZH_ScanAnimation.h"
#import "ZH_ScanLineAnimation.h"
#import "ZH_ScanObject.h"
#import "ZH_ScanResult.h"
#import "ZH_ScanView.h"

FOUNDATION_EXPORT double ZH_ScanVersionNumber;
FOUNDATION_EXPORT const unsigned char ZH_ScanVersionString[];

