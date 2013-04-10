//
//  QNClient.m
//  QiniuSDK
//
//  Created by akin on 13-4-10.
//  Copyright (c) 2013年 akin. All rights reserved.
//

#import "QNClient.h"
#import "GTMBase64.h"

@implementation QNClient

+ (QNClient *)sharedClient
{
	static QNClient *_sharedClient = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedClient = [[QNClient alloc] initWithBaseURL:[NSURL URLWithString:kUpHost]];
	});
	return _sharedClient;
}

@end
