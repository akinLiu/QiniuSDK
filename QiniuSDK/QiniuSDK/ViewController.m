//
//  ViewController.m
//  QiniuSDK
//
//  Created by akin on 13-4-10.
//  Copyright (c) 2013年 akin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)uploaderButtonPressed:(id)sender {
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyy-MM-dd-HH-mm-ss"];
	[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    NSString *timeDesc = [formatter stringFromDate:[NSDate date]];
	NSString *key = [NSString stringWithFormat:@"%@%@", timeDesc, @".png"];
	
	QNClient *client = [QNClient sharedClient];
	QNUploaderParams *params = [[QNUploaderParams alloc] init];
	QNAuthPolicy *authPolicy = [[QNAuthPolicy alloc] init];
	authPolicy.scope = kBucketName;
	params.authToken = [authPolicy makeToken:kAccessKey secretKey:kSecretKey];
	params.action = [authPolicy makeActionBucket:kBucketName key:key extraParams:nil];
	NSMutableURLRequest *request =  [client multipartFormRequestWithMethod:@"POST" path:@"/upload" parameters:[params dictionaryRepresentation] constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
		NSData *data = UIImageJPEGRepresentation([UIImage imageNamed:@"icon.png"], 1.0);
		[formData appendPartWithFileData:data name:@"file" fileName:@"icon.png" mimeType:@"image/png"];
	}];
	NSLog(@"key name %@", key);
	AFJSONRequestOperation *requestOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
		NSLog(@"%@", JSON);
	} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
		NSLog(@"%@", JSON);
	}];
	[requestOperation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
		float progress = totalBytesWritten / (float)totalBytesExpectedToWrite;
		//		NSLog(@"%d", persent);
		//		NSLog(@"bytesWritten %d totalBytesWritten %lld", bytesWritten, totalBytesWritten);
		NSLog(@"%f", progress);
	}];
	[requestOperation start];
}
@end
