/**
 * @class      OONetUtils OONetUtils.h "OONetUtils.h"
 * @brief      OONetUtils
 * @details    OONetUtils.h in OoyalaSDK
 * @date       1/3/12
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>

typedef void (^OOURLRequestCallback)(NSData *data, NSError *error);

@interface OONetUtils : NSObject
+ (void)ping:(NSURL *)url;
+ (NSData *)request:(NSURL *)url timeout:(NSTimeInterval)timeout;
+ (void)request:(NSURL *)url timeout:(NSTimeInterval)timeout withCallback:(OOURLRequestCallback)callback;
+ (BOOL)isWifiAvailable;
@end