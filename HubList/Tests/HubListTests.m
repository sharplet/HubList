//
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "Helpers.h"

SPEC_BEGIN(HubListTests)

describe(@"HubList", ^{
    beforeEach(^{
        [ILCannedURLProtocol loadTestDataFromFile:@"top_swift_repositories"];
    });
    afterEach(^{
        [ILCannedURLProtocol resetTestData];
    });

    it(@"can fetch a canned URL", ^{
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL *url = [NSURL URLWithString:@"https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc"];
        NSData __block *receivedData;
        [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            receivedData = data;
        }] resume];
        [[expectFutureValue(receivedData) shouldEventually] beNonNil];
    });
});

SPEC_END
