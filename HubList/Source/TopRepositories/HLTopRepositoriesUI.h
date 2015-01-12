//
//  HLRepositoriesUI.h
//  HubList
//
//  Created by Adam Sharp on 13/01/2015.
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLTopRepositoriesGateway.h"

@interface HLTopRepositoriesUI : NSObject

@property NSArray *repositories;

- (instancetype)initWithRemoteGateway:(id<HLTopRepositoriesGateway>)gateway NS_DESIGNATED_INITIALIZER;

- (void)refresh;

@end
