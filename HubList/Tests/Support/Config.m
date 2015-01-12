//
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <ILTesting/ILCannedURLProtocol.h>

NSBundle *testBundle(void);
NSDictionary *loadHeaders(void);
NSData *loadRepositoriesResponseData(void);

CONFIG_START

beforeAllSpecs(^{
    [NSURLProtocol registerClass:[ILCannedURLProtocol class]];
    [ILCannedURLProtocol setCannedStatusCode:200];
    [ILCannedURLProtocol setCannedHeaders:loadHeaders()];
    [ILCannedURLProtocol setCannedResponseData:loadRepositoriesResponseData()];
    [ILCannedURLProtocol setShouldInitWithRequestBlock:^BOOL(NSURLRequest *request) {
        NSString *expectedURL = @"https://api.github.com/search/repositories";
        return [request.URL.absoluteString hasPrefix:expectedURL];
    }];
});

CONFIG_END

NSBundle *testBundle(void) {
    return [NSBundle bundleForClass:[KWSuiteConfiguration class]];
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
