//
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "HLTopRepositoriesUI.h"

void stubSuccessfulArrayResult(id<HLTopRepositoriesGateway> gateway, NSArray *array);

SPEC_BEGIN(HLTopRepositoriesUITests)

describe(@"HLTopRepositoriesUI", ^{
    it(@"loads the top repositories when the UI is refreshed", ^{
        id gateway = [KWMock mockWithName:@"top repositories gateway" forProtocol:@protocol(HLTopRepositoriesGateway)];
        HLTopRepositoriesUI *ui = [[HLTopRepositoriesUI alloc] initWithGateway:gateway];

        [[ui.repositories should] equal:@[]];
        stubSuccessfulArrayResult(gateway, @[@"FlappySwift", @"Alamofire"]);
        [ui refresh];
        [[ui.repositories should] equal:@[@"FlappySwift", @"Alamofire"]];
    });
});

SPEC_END

void stubSuccessfulArrayResult(id<HLTopRepositoriesGateway> gateway, NSArray *array) {
    [(id)gateway stub:@selector(fetchTopRepositoriesWithCompletion:) withBlock:^id(NSArray *params) {
        HLArrayResult completion = params[0];
        completion(array, nil);
        return nil;
    }];
}
