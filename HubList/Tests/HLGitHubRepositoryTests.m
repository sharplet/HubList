//
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "HLGitHubRepository.h"

SPEC_BEGIN(HLGitHubRepositoryTests)

describe(@"HLGitHubRepository", ^{
    describe(@"initialisation from JSON", ^{
        let(json, ^{
            return @{
                @"name": @"FlappySwift"
            };
        });
        let(repository, ^{ return [[HLGitHubRepository alloc] initWithJSONObject:json]; });

        it(@"maps the repository name", ^{
            [[repository.name should] equal:json[@"name"]];
        });
    });
});

SPEC_END
