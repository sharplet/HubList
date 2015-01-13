//
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <ILTesting/ILCannedURLProtocol.h>
#import "Helpers.h"
#import "HLGitHubClient.h"
#import "HLGitHubRepository.h"

SPEC_BEGIN(HLGitHubClientTests)

describe(@"HLGitHubClient", ^{
    beforeEach(^{
        [ILCannedURLProtocol setCannedStatusCode:200];
        [ILCannedURLProtocol setCannedHeaders:loadHeaders()];
        [ILCannedURLProtocol setCannedResponseData:loadRepositoriesResponseData()];
        [ILCannedURLProtocol setShouldInitWithRequestBlock:^BOOL(NSURLRequest *request) {
            NSString *expectedURL = @"https://api.github.com/search/repositories";
            return [request.URL.absoluteString hasPrefix:expectedURL];
        }];
    });

    afterEach(^{
        [ILCannedURLProtocol setCannedHeaders:nil];
        [ILCannedURLProtocol setCannedResponseData:nil];
    });

    describe(@"top repositories", ^{
        it(@"returns an array of the top swift repositories", ^{
            HLGitHubClient *client = [HLGitHubClient new];
            NSArray __block *fetchedRepositories;
            [client fetchTopRepositoriesWithCompletion:^(NSArray *topRepositories, NSError *error) {
                fetchedRepositories = topRepositories;
            }];

            NSUInteger (^numberOfRepositoryInstances)(void) = ^{
                NSUInteger __block count = 0;
                for (id repository in fetchedRepositories) {
                    if ([repository isKindOfClass:[HLGitHubRepository class]]) {
                        count++;
                    }
                }
                return count;
            };

            [[expectFutureValue(fetchedRepositories) shouldEventually] beNonNil];
            [[expectFutureValue(fetchedRepositories) shouldEventually] haveCountOf:numberOfRepositoryInstances()];
        });
    });
});

SPEC_END
