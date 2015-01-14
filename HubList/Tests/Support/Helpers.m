//
//  Helpers.m
//  HubList
//
//  Created by Adam Sharp on 13/01/2015.
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import "Helpers.h"

// Get the test bundle
static NSBundle *testBundle(void);


@implementation ILCannedURLProtocol (HubListTestHelpers)

+ (void)loadTestDataFromFile:(NSString *)file
{
    NSString *headers = [testBundle() pathForResource:file ofType:@"headers.json"];
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:headers] options:0 error:&error];
    if (error) { NSLog(@"%@", error); }
    [ILCannedURLProtocol setCannedHeaders:object];

    NSString *json = [testBundle() pathForResource:file ofType:@"json"];
    [ILCannedURLProtocol setCannedResponseData:[NSData dataWithContentsOfFile:json]];
}

+ (void)resetTestData
{
    [ILCannedURLProtocol setCannedStatusCode:200];
    [ILCannedURLProtocol setCannedHeaders:nil];
    [ILCannedURLProtocol setCannedResponseData:nil];
}

@end


// Test bundle implementation

@interface HLTestHelpers : NSObject @end
@implementation HLTestHelpers @end

static NSBundle *testBundle(void) {
    static dispatch_once_t token;
    static NSBundle *testBundle;
    dispatch_once(&token, ^{ testBundle = [NSBundle bundleForClass:[HLTestHelpers class]]; });
    return testBundle;
}
