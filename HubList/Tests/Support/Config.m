//
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <ILTesting/ILCannedURLProtocol.h>

CONFIG_START

beforeAllSpecs(^{
    [NSURLProtocol registerClass:[ILCannedURLProtocol class]];
});

CONFIG_END
