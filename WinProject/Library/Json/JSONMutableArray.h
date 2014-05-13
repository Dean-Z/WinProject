//
//  JSONMutableArray.h
//  FrameworkDemo
//
//  Created by Dean on 14-2-10.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+JSON.h"

@interface JSONMutableArray : NSMutableArray
{
    NSMutableArray  *_data;
    Class           _modelType;
}

@property(nonatomic,assign) Class modelType;

+ (id)arrayWithModelType:(Class)modelType;

- (JSONMutableArray *)fromJSONObject:(NSArray *)nsArray;
- (JSONMutableArray *)fromJSONObject:(NSArray *)nsArray inStore:(IBCoreDataStore *)customStore;


@end
