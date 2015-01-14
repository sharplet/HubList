//
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <EnumeratorKit/EnumeratorKit.h>
#import "Helpers.h"
#import "HLGitHubClient.h"
#import "HLGitHubRepository.h"

// Helpers

NSUInteger numberOfRepositoryInstances(NSArray *repositories);


// Spec

SPEC_BEGIN(HLGitHubClientTests)

describe(@"HLGitHubClient", ^{
    beforeEach(^{
        [ILCannedURLProtocol setCannedStatusCode:200];
        [ILCannedURLProtocol loadTestDataFromFile:@"top_swift_repositories"];
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

            [[expectFutureValue(fetchedRepositories) shouldEventually] haveCountOfAtLeast:1];
            [[expectFutureValue(fetchedRepositories) shouldEventually] haveCountOf:numberOfRepositoryInstances(fetchedRepositories)];
        });
    });
});

SPEC_END


// Helper implementations

NSUInteger numberOfRepositoryInstances(NSArray *repositories) {
    return [repositories filter:^(id repository){
        return [repository isKindOfClass:[HLGitHubRepository class]];
    }].count;
};
