//
//  HLGitHubRepository.m
//  HubList
//
//  Created by Adam Sharp on 14/01/2015.
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import "HLGitHubRepository.h"

@implementation HLGitHubRepository

- (instancetype)initWithJSON:(id)json
{
    if ((self = [super init])) {
        _name = json[@"name"];
    }
    return self;
}

@end
