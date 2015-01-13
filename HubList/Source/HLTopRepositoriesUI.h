//
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLTopRepositoriesGateway.h"

@interface HLTopRepositoriesUI : NSObject

@property NSArray *repositories;

- (instancetype)initWithGateway:(id<HLTopRepositoriesGateway>)gateway;

- (void)refresh;

@end
