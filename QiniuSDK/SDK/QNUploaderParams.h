//
//  QNUploaderParams.h
//  QiniuSDK
//
//  Created by akin on 13-4-10.
//  Copyright (c) 2013年 akin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QNUploaderParams : NSObject
/*
 是要执行的上传行为，表示向具体的资源表里新建一个条目 按照七牛规则生成 参考 http://docs.qiniutek.com/v3/api/io/#upload-file-by-html-form
 */
@property (nonatomic, strong) NSString *action;

@property (nonatomic, strong) NSString *authToken;

- (NSDictionary *)dictionaryRepresentation;

@end
