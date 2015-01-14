//
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <EnumeratorKit/EnumeratorKit.h>
#import "Helpers.h"
#import "HLGitHubClient.h"
#import "HLGitHubRepository.h"

SPEC_BEGIN(HLGitHubClientTests)

describe(@"HLGitHubClient", ^{
    describe(@"fetching top repositories", ^{
        beforeEach(^{
            [ILCannedURLProtocol loadTestDataFromFile:@"top_swift_repositories"];
            [ILCannedURLProtocol setShouldInitWithRequestBlock:^BOOL(NSURLRequest *request) {
                return [request.URL.absoluteString hasPrefix:@"https://api.github.com/search/repositories"];
            }];
        });
        afterEach(^{
            [ILCannedURLProtocol resetTestData];
        });

        it(@"can fetch an array of the top repositories on GitHub", ^{
            HLGitHubClient *client = [HLGitHubClient new];

            NSArray __block *fetchedRepositories;
            [client fetchTopRepositoriesWithCompletion:^(NSArray *topRepositories, NSError *error) {
                fetchedRepositories = topRepositories;
            }];

            [[expectFutureValue([fetchedRepositories valueForKey:@"name"]) shouldEventually] equal:@[
                @"FlappySwift",
                @"Alamofire",
                @"SwiftyJSON",
                @"Design-Patterns-In-Swift",
                @"Dollar.swift",
                @"LTMorphingLabel",
                @"Quick",
                @"Cartography",
                @"Carthage",
                @"swiftz",
                @"swift-2048",
                @"iOS8-day-by-day",
                @"animated-tab-bar",
                @"Surge",
                @"ExSwift",
                @"SwiftGuide",
                @"hamburger-button",
                @"SwiftWeather",
                @"VPNOn",
                @"Swifter",
                @"SCLAlertView-Swift",
                @"Chats",
                @"SQLite.swift",
                @"HanekeSwift",
                @"adaptive-tab-bar",
                @"ZFRippleButton",
                @"iOS-Swift-Demos",
                @"News-YC---iPhone",
                @"Async",
                @"SwiftHN"
            ]];
        });

        it(@"returns HLGitHubRepository instances", ^{
            HLGitHubClient *client = [HLGitHubClient new];

            NSArray __block *fetchedRepositories;
            [client fetchTopRepositoriesWithCompletion:^(NSArray *topRepositories, NSError *error) {
                fetchedRepositories = topRepositories;
            }];

            [[expectFutureValue(theValue(
                [fetchedRepositories all:^(id obj){
                    return [obj isKindOfClass:[HLGitHubRepository class]];
                }]
            )) shouldEventually] beYes];
        });
    });
});

SPEC_END
