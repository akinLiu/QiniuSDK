//
//  QNClient.h
//  QiniuSDK
//
//  Created by akin on 13-4-10.
//  Copyright (c) 2013年 akin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "QNConfig.h"

@interface QNClient : AFHTTPClient

+ (QNClient *)sharedClient;

@end
