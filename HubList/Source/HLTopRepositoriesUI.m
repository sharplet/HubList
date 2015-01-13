//
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import "HLTopRepositoriesUI.h"

@interface HLTopRepositoriesUI ()
@property (readonly) id<HLTopRepositoriesGateway> gateway;
@end

@implementation HLTopRepositoriesUI

- (instancetype)initWithGateway:(id<HLTopRepositoriesGateway>)gateway
{
    if ((self = [super init])) {
        _gateway = gateway;
        _repositories = @[];
    }
    return self;
}

- (void)refresh
{
    [self.gateway fetchTopRepositoriesWithCompletion:^(NSArray *repositories, NSError *error) {
        if (error) { NSLog(@"%@", error); return; }
        self.repositories = repositories;
    }];
}

@end
