//
//  QNUploaderParams.m
//  QiniuSDK
//
//  Created by akin on 13-4-10.
//  Copyright (c) 2013年 akin. All rights reserved.
//

#import "QNUploaderParams.h"

@implementation QNUploaderParams

- (NSDictionary *)dictionaryRepresentation
{
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	[dictionary setObject:self.action forKey:@"action"];
	if (nil != self.authToken) {
		[dictionary setObject:self.authToken forKey:@"auth"];
	}
	
    return [NSDictionary dictionaryWithDictionary:dictionary];
}

@end
