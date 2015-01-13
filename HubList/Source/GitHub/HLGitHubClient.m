//
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

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
        if (error) { completion(nil, error); return; }
        id json = [self parseJSONData:data error:&error];
        if (error) { completion(nil, error); return; }
        NSArray *repositories = [self repositoriesFromJSONResponse:json];
        completion(repositories, nil);
    }] resume];
}

- (id)parseJSONData:(NSData *)data error:(NSError **)error
{
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
    return object;
}

- (NSArray *)repositoriesFromJSONResponse:(id)json
{
    NSMutableArray *repositories = [NSMutableArray new];
    for (id item in json[@"items"]) {
        HLGitHubRepository *repository = [[HLGitHubRepository alloc] initWithJSONObject:item];
        [repositories addObject:repository];
    }
    return [repositories copy];
}

@end
