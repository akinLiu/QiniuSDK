//
//  QNConfig.h
//  QiniuSDK
//
//  Created by akin on 13-4-8.
//  Copyright (c) 2013年 akin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUpHost @"http://up.qbox.me"

#define kBlockSize (4 * 1024 * 1024)  // 4MB
#define kChunkSize (256 * 1024) // 128KB

#define kMimeTypeKey @"mimeType"
#define kCustomMetaKey @"customMeta"
#define kCrc32Key @"crc32"
#define kRotateKey @"rotate"
#define kCallbackParamsKey @"callbackParams"

#define kErrorDomain @"QNSimpleUploader"
#define kFilePathKey @"filePath"
#define kHashKey @"hash"
#define kErrorKey @"error"
#define kXlogKey @"X-Log"
#define kXreqidKey @"X-Reqid"
#define kFileSizeKey @"fileSize"
#define kKeyKey @"key"
#define kBucketKey @"bucket"
#define kExtraParamsKey @"extraParams"

#define kBucketName		@""
#define kAccessKey		@""
#define kSecretKey		@""

