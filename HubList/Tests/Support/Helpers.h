//
//  Helpers.h
//  HubList
//
//  Created by Adam Sharp on 13/01/2015.
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ILTesting/ILCannedURLProtocol.h>

@interface ILCannedURLProtocol (HubListTestHelpers)
+ (void)loadTestDataFromFile:(NSString *)file;
+ (void)resetTestData;
@end
