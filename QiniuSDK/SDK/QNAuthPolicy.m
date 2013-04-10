//
//  QNAuthPolicy.m
//  QiniuSDK
//
//  Created by akin on 13-4-8.
//  Copyright (c) 2013年 akin. All rights reserved.
//

#import "QNAuthPolicy.h"

NSString *urlsafeBase64String(NSString *sourceString)
{
    return [GTMBase64 stringByWebSafeEncodingData:[sourceString dataUsingEncoding:NSUTF8StringEncoding] padded:TRUE];
}

@interface QNAuthPolicy ()

- (NSString *)marshal;

@end

@implementation QNAuthPolicy

- (NSString *)makeToken:(NSString *)accessKey secretKey:(NSString *)secretKey
{
	const char *secretKeyStr = [secretKey UTF8String];
    
	NSString *policy = [self marshal];
    
    NSData *policyData = [policy dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *encodedPolicy = [GTMBase64 stringByWebSafeEncodingData:policyData padded:TRUE];
    const char *encodedPolicyStr = [encodedPolicy cStringUsingEncoding:NSUTF8StringEncoding];
    
    char digestStr[CC_SHA1_DIGEST_LENGTH];
    bzero(digestStr, 0);
    
    CCHmac(kCCHmacAlgSHA1, secretKeyStr, strlen(secretKeyStr), encodedPolicyStr, strlen(encodedPolicyStr), digestStr);
    
    NSString *encodedDigest = [GTMBase64 stringByWebSafeEncodingBytes:digestStr length:CC_SHA1_DIGEST_LENGTH padded:TRUE];
    
    NSString *token = [NSString stringWithFormat:@"%@:%@:%@",  accessKey, encodedDigest, encodedPolicy];
    
	return token;
}

- (NSString *)marshal
{
    time_t deadline;
    time(&deadline);
    
    deadline += (self.expires > 0) ? self.expires : 3600; // 1 hour by default.
    NSNumber *deadlineNumber = [NSNumber numberWithLongLong:deadline];
	
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (self.scope) {
        [dic setObject:self.scope forKey:@"scope"];
    }
    if (self.calllbackURL) {
        [dic setObject:self.calllbackURL forKey:@"callbackUrl"];
    }
    if (self.callbackBodyType) {
        [dic setObject:self.callbackBodyType forKey:@"callbackBodyType"];
    }
    if (self.customer) {
        [dic setObject:self.customer forKey:@"customer"];
    }
    
    [dic setObject:deadlineNumber forKey:@"deadline"];
    
    if (self.escape) {
        NSNumber *escapeNumber = [NSNumber numberWithLongLong:self.escape];
        [dic setObject:escapeNumber forKey:@"escape"];
    }
    
    NSString *json = [dic JSONString];
    
    return json;
}

- (NSString *)makeActionBucket:(NSString *)bucket
						   key:(NSString *)key
				   extraParams:(NSDictionary *)extraParams;
{
    NSString *tempStr = [NSString stringWithFormat:@"%@:%@", bucket, key];
    NSString *encodedEntry = urlsafeBase64String(tempStr);
	
	// Prepare POST body fields.
    NSMutableString *action = [NSMutableString stringWithFormat:@"/rs-put/%@", encodedEntry];
    
    // All of following fields are optional.
    if (extraParams) {
        NSObject *mimeTypeObj = [extraParams objectForKey:kMimeTypeKey];
        if (mimeTypeObj) {
            [action appendString:@"/mimeType/"];
            [action appendString:urlsafeBase64String((NSString *)mimeTypeObj)];
        }
        
        NSObject *customMetaObj = [extraParams objectForKey:kCustomMetaKey];
        if (customMetaObj) {
            [action appendString:@"/meta/"];
            [action appendString:urlsafeBase64String((NSString *)customMetaObj)];
        }
        
        NSObject *crc32Obj = [extraParams objectForKey:kCrc32Key];
        if (crc32Obj) {
            [action appendString:@"/crc32/"];
            [action appendString:(NSString *)crc32Obj];
        }
		
        NSObject *rotateObj = [extraParams objectForKey:kRotateKey];
        if (rotateObj) {
            [action appendString:@"/rotate/"];
            [action appendString:(NSString *)rotateObj];
        }
    }
	
	return action;
}

@end
