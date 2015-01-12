//
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLResult.h"

@protocol HLTopRepositoriesGateway <NSObject>

- (void)fetchTopRepositoriesWithCompletion:(HLArrayResult)completion;

@end
