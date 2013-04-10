//
//  QNAuthPolicy.h
//  QiniuSDK
//
//  Created by akin on 13-4-8.
//  Copyright (c) 2013年 akin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>

#import "JSONKit.h"
#import "GTMBase64.h"
#import "QNConfig.h"

@interface QNAuthPolicy : NSObject

@property (nonatomic, strong) NSString *scope;

@property (nonatomic, strong) NSString *calllbackURL;

@property (nonatomic, strong) NSString *callbackBodyType;

@property (nonatomic, strong) NSString *customer;

@property (nonatomic) int expires;

@property (nonatomic) int escape;

/*
 make uptoken string
 */
- (NSString *)makeToken:(NSString *)accessKey secretKey:(NSString *)secretKey;
 
- (NSString *)makeActionBucket:(NSString *)bucket
								 key:(NSString *)key
						 extraParams:(NSDictionary *)extraParams;

@end
