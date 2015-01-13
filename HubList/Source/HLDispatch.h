//
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import <dispatch/dispatch.h>

#define hl_dispatch_async_main(block, ...) \
    do { \
        dispatch_async(dispatch_get_main_queue(), ^{ \
            block(__VA_ARGS__); \
        }); \
    } while (0)
