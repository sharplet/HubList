//
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import <Kiwi/Kiwi.h>

SPEC_BEGIN(HubListTests)

describe(@"HubList", ^{
    it(@"wins at everything", ^{
        [[@(2 + 2) should] equal:@4];
    });
});

SPEC_END
