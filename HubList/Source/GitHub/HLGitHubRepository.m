//
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import "HLGitHubRepository.h"

@implementation HLGitHubRepository

- (instancetype)initWithJSONObject:(id)json
{
    if ((self = [super init])) {
        _name = [json[@"name"] copy];
    }
    return self;
}

@end
