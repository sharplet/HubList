//
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import "HLGitHubClient.h"
#import "HLDispatch.h"

@implementation HLGitHubClient

- (NSURL *)topRepositoriesURL
{
    return [NSURL URLWithString:@"https://api.github.com/search/repositories?q=language:swift&sort=stars"];
}

- (NSURLSession *)URLSession
{
    return [NSURLSession sharedSession];
}

- (void)fetchTopRepositoriesWithCompletion:(HLArrayResult)completion
{
    [[self.URLSession dataTaskWithURL:self.topRepositoriesURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) { hl_dispatch_async_main(completion, nil, error); return; }
        id json = [self parseJSONData:data error:&error];
        if (error) { hl_dispatch_async_main(completion, nil, error); return; }
        NSArray *repositories = [self repositoriesFromJSON:json];
        hl_dispatch_async_main(completion, repositories, nil);
    }] resume];
}

- (id)parseJSONData:(NSData *)data error:(NSError **)error
{
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
}

- (NSArray *)repositoriesFromJSON:(id)json
{
    return json[@"items"];
}

@end
