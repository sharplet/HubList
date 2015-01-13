//
//  Helpers.m
//  HubList
//
//  Created by Adam Sharp on 13/01/2015.
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import "Helpers.h"

@interface HLTestHelpers : NSObject @end
@implementation HLTestHelpers @end

NSBundle *testBundle(void) {
    return [NSBundle bundleForClass:[HLTestHelpers class]];
}

NSDictionary *loadHeaders(void) {
    NSString *headersPath = [testBundle() pathForResource:@"top_swift_repositories.headers" ofType:@"json"];
    NSData *headersData = [NSData dataWithContentsOfFile:headersPath];
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:headersData options:0 error:&error];
    if (error) { NSLog(@"%@", error); }
    return object;
}

NSData *loadRepositoriesResponseData(void) {
    NSString *responsePath = [testBundle() pathForResource:@"top_swift_repositories" ofType:@"json"];
    NSData *responseData = [NSData dataWithContentsOfFile:responsePath];
    return responseData;
}
