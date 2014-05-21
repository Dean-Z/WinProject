//
//  WPSyncService.h
//  WinProject
//
//  Created by Dean-Z on 14-5-12.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "CHDNetwork.h"

@interface WPSyncService : CHDNetwork

- (void)loginWithRoute:(NSDictionary*)term Block: (void (^)(id))processBlock;

- (void) syncWithRoute:(NSDictionary*)term Block: (void (^)(id))processBlock;

- (void)downloadImageWithRoute:(NSDictionary*)term Block: (void (^)(id))processBlock;

@end
