//
//  HLRepositoriesUI.m
//  HubList
//
//  Created by Adam Sharp on 13/01/2015.
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import "HLTopRepositoriesUI.h"

@interface HLTopRepositoriesUI ()
@property id<HLTopRepositoriesGateway> gateway;
@end

@implementation HLTopRepositoriesUI

- (instancetype)initWithRemoteGateway:(id<HLTopRepositoriesGateway>)gateway
{
    if ((self = [super init])) {
        _gateway = gateway;
    }
    return self;
}

- (void)refresh
{
    [self.gateway fetchTopRepositoriesWithCompletion:^(NSArray *repositories, NSError *error) {
        self.repositories = repositories;
    }];
}

@end
