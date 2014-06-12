//
//  CCGetContactPerson.h
//  QCall
//
//  Created by Dean on 13-11-4.
//  Copyright (c) 2013年 Dean. All rights reserved.
//

#import <AddressBook/AddressBook.h>
#import <Foundation/Foundation.h>

@interface CCGetContactPerson : NSObject

@property(strong,nonatomic) NSMutableArray* personData;

-(void)personDataRefresh:(BOOL)isRefresh Complate:(void (^)(NSMutableArray*))complate;

+(id)shareCCGetContactPerson;

-(void)cheackGranted;

//get
- (NSString*)firstName:(ABRecordRef)record;
- (UIImage*)recordImage:(ABRecordRef)record;
- (NSInteger)recordId:(ABRecordRef)record;
- (NSString*)middleName:(ABRecordRef)record;
- (NSString*)lastName:(ABRecordRef)record;
- (NSString*)name:(ABRecordRef)record isChina:(BOOL)isChina;
- (NSMutableDictionary*)recordEmail:(ABRecordRef)record;
- (NSMutableDictionary*)recordPhone:(ABRecordRef)record;

-(ABRecordRef)recordFromABRecordRefID:(NSUInteger)recordId;

//set
-(void)setRecordImage:(ABRecordRef)abPerson NewImage:(UIImage*)newImage;

@end
