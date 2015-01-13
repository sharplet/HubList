//
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import <EnumeratorKit/EnumeratorKit.h>
#import "HLDispatch.h"
#import "HLGitHubClient.h"
#import "HLGitHubRepository.h"

@implementation HLGitHubClient

- (NSURLSession *)URLSession
{
    return [NSURLSession sharedSession];
}

- (NSURL *)topRepositoriesURL
{
    return [NSURL URLWithString:@"https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc"];
}

- (void)fetchTopRepositoriesWithCompletion:(HLArrayResult)completion
{
    [[self.URLSession dataTaskWithURL:self.topRepositoriesURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) { hl_dispatch_async_main(completion, nil, error); return; }
        id json = [self parseJSONData:data error:&error];
        if (error) { hl_dispatch_async_main(completion, nil, error); return; }
        NSArray *repositories = [self repositoriesFromJSONResponse:json];
        hl_dispatch_async_main(completion, repositories, nil);
    }] resume];
}

- (id)parseJSONData:(NSData *)data error:(NSError **)error
{
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
    return object;
}

- (NSArray *)repositoriesFromJSONResponse:(id)json
{
    return [json[@"items"] map:^(id item){
        return [[HLGitHubRepository alloc] initWithJSONObject:item];
    }];
}

@end
