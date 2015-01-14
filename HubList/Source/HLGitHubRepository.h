//
//  HLGitHubRepository.h
//  HubList
//
//  Created by Adam Sharp on 14/01/2015.
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLGitHubRepository : NSObject

@property (readonly) NSString *name;

- (instancetype)initWithJSON:(id)json;

@end
