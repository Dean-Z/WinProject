//
//  JSONMutableArray.m
//  FrameworkDemo
//
//  Created by Dean on 14-2-10.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "JSONMutableArray.h"

@implementation JSONMutableArray
@synthesize modelType    = _modelType;

+ (id)arrayWithModelType:(Class)modelType
{
    JSONMutableArray *array = [[JSONMutableArray alloc] init];
    
    array.modelType = modelType;
    
    return array;
}

- (id)fromJSONObject:(NSArray *)nsArray
{
	return [self fromJSONObject:nsArray inStore:nil];
}

- (id)fromJSONObject:(NSArray *)nsArray inStore:(IBCoreDataStore *)customStore
{
	for (NSDictionary *jsonObject in nsArray)
	{
		if ([jsonObject isKindOfClass:[NSDictionary class]])
		{
			[_data addObject: [self.modelType fromJSONObject:jsonObject inStore:customStore]];
		}
	}
	
	return self;
}


- (id)init
{
    self = [super init];
    
	if (self)
	{
        _data = [[NSMutableArray alloc] init];
    }
	
    return self;
}

- (void)dealloc
{
	[_data removeAllObjects];
}

#pragma mark - NSArray methods

- (NSUInteger)count
{
    return [_data count];
}

- (id)objectAtIndex:(NSUInteger)index
{
    return [_data objectAtIndex:index];
}

#pragma mark - NSMutableArray methods

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index
{
    [_data insertObject:anObject atIndex:index];
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    [_data removeObjectAtIndex:index];
}

- (void)addObject:(id)anObject
{
    [_data addObject:anObject];
}

- (void)removeLastObject
{
    [_data removeLastObject];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    [_data replaceObjectAtIndex:index withObject:anObject];
}
@end
