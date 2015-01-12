//
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "HLTopRepositoriesUI.h"

// Helpers

void stubArrayResultSuccess(id<HLTopRepositoriesGateway> gateway, NSArray *successResult);


// Spec

SPEC_BEGIN(HLTopRepositoriesUITests)

describe(@"HLRepositoriesUI", ^{
    let(gateway, ^{ return [KWMock mockWithName:@"top repositories gateway" forProtocol:@protocol(HLTopRepositoriesGateway)]; });
    let(ui, ^{ return [[HLTopRepositoriesUI alloc] initWithRemoteGateway:gateway]; });

    it(@"shows no repositories when first created", ^{
        [[[ui should] have:0] repositories];
    });

    it(@"loads the top repositories when the user refreshes the UI", ^{
        stubArrayResultSuccess(gateway, @[@"AFNetworking", @"ReactiveCocoa"]);
        [ui refresh];
        [[expectFutureValue(ui.repositories) shouldEventually] equal:@[@"AFNetworking", @"ReactiveCocoa"]];
    });
});

SPEC_END


// Helper implementations

void stubArrayResultSuccess(id<HLTopRepositoriesGateway> gateway, NSArray *successResult) {
    [(id)gateway stub:@selector(fetchTopRepositoriesWithCompletion:) withBlock:^id(NSArray *params) {
        HLArrayResult completion = params[0];
        completion(successResult, nil);
        return nil;
    }];
}
