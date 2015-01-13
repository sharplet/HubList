//
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLGitHubRepository : NSObject

@property (copy) NSString *name;

- (instancetype)initWithJSONObject:(id)json;

@end
