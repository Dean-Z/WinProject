//
//  CCGetContactPerson.m
//  QCall
//
//  Created by Dean on 13-11-4.
//  Copyright (c) 2013年 Dean. All rights reserved.
//

#import "CCGetContactPerson.h"

@implementation CCGetContactPerson

@synthesize personData;

+(id)shareCCGetContactPerson	
{
    static CCGetContactPerson* contactPerson;
    
    if (contactPerson == nil)
    {
        contactPerson = [[CCGetContactPerson alloc]init];
    }
    return contactPerson;
}

-(id)init
{
    if (self = [super init])
    {
        self.personData = [@[] mutableCopy];
    }
    return self;
}

-(void)personDataRefresh:(BOOL)isRefresh Complate:(void (^)(NSMutableArray *))complate
{
    if (self.personData.count == 0 || isRefresh)
    {
        [self getPersonAllData:complate];
    }
    else{
        complate(self.personData);
    }
}

-(void)cheackGranted
{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
    
    });
}

#pragma mark - GET

-(void)getPersonAllData:(void (^)(NSMutableArray *))complate
{
    CFErrorRef error = NULL;
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        if (granted)
        {
            NSArray* temp = (__bridge NSArray *)(ABAddressBookCopyArrayOfAllPeople(addressBook));
            [self.personData addObjectsFromArray:temp];
            complate(self.personData);
        }
    });
}

- (NSString*)firstName:(ABRecordRef)record
{
    CFStringRef  firstNameRef =  ABRecordCopyValue(record, kABPersonFirstNameProperty);
    NSString* firstName = (__bridge NSString*)firstNameRef;
    return firstName;
}


- (NSString*)lastName:(ABRecordRef)record
{
    CFStringRef  lastNameRef =  ABRecordCopyValue(record, kABPersonLastNameProperty);
    NSString* lastName = (__bridge NSString*)lastNameRef;
    return lastName;
}

- (NSString*)middleName:(ABRecordRef)record
{
    CFStringRef  middleNameRef =  ABRecordCopyValue(record, kABPersonMiddleNameProperty);
    NSString* middleName = (__bridge NSString*)middleNameRef;
    return middleName;
}

- (NSString*)name:(ABRecordRef)record isChina:(BOOL)isChina
{
    NSString* nameString = @"";
    
    if (isChina)
    {

        if (![NSString isNilOrEmpty:[self lastName:record]])
        {
            nameString = [nameString stringByAppendingString:[NSString stringWithFormat:@"%@ ",[self lastName:record]]];
        }
        
        if (![NSString isNilOrEmpty:[self middleName:record]])
        {
            nameString = [nameString stringByAppendingString:[NSString stringWithFormat:@"%@ ",[self middleName:record]]];
        }
        
        if (![NSString isNilOrEmpty:[self firstName:record]])
        {
            nameString = [nameString stringByAppendingString:[NSString stringWithFormat:@"%@ ",[self firstName:record]]];
        }
        
        return nameString;
    }
    else
    {
        if (![NSString isNilOrEmpty:[self firstName:record]])
        {
            nameString = [nameString stringByAppendingString:[NSString stringWithFormat:@"%@ ",[self firstName:record]]];
        }
        
        if (![NSString isNilOrEmpty:[self middleName:record]])
        {
            nameString = [nameString stringByAppendingString:[NSString stringWithFormat:@"%@ ",[self middleName:record]]];
        }
        
        if (![NSString isNilOrEmpty:[self lastName:record]])
        {
            nameString = [nameString stringByAppendingString:[NSString stringWithFormat:@"%@ ",[self lastName:record]]];
        }
        
        return nameString;
    }
}

- (NSInteger)recordId:(ABRecordRef)record
{
    return (int)ABRecordGetRecordID(record);
}

- (UIImage*)recordImage:(ABRecordRef)record
{
    UIImage* recordImage = [UIImage imageWithData:(__bridge NSData *)ABPersonCopyImageDataWithFormat(record,kABPersonImageFormatThumbnail)];
    return recordImage;
}

- (NSMutableDictionary*)recordPhone:(ABRecordRef)record
{
    NSMutableDictionary* phoneNumbers = [@{} mutableCopy];
    ABMultiValueRef  phones = ABRecordCopyValue(record, kABPersonPhoneProperty);
    for(int i = 0; i < ABMultiValueGetCount(phones); i++)
    {
        CFStringRef phoneLabelRef = ABMultiValueCopyLabelAtIndex(phones, i);
        CFStringRef localizedPhoneLabelRef = ABAddressBookCopyLocalizedLabel(phoneLabelRef);
        CFStringRef phoneNumberRef = ABMultiValueCopyValueAtIndex(phones, i);
        
        NSString * localizedPhoneLabel = (__bridge NSString *) localizedPhoneLabelRef;
        NSString * phoneNumber = (__bridge NSString *)phoneNumberRef;
        
        [phoneNumbers setValue:phoneNumber forKey:localizedPhoneLabel];
        
        //释放内存
        phoneLabelRef == NULL ? : CFRelease(phoneLabelRef);
        localizedPhoneLabelRef == NULL ? : CFRelease(localizedPhoneLabelRef);
        phoneNumberRef == NULL ? : CFRelease(phoneNumberRef);
    }
    if(phones != NULL) CFRelease(phones);
    return phoneNumbers;
}

- (NSMutableDictionary*)recordEmail:(ABRecordRef)record
{
    NSMutableDictionary* emailNumbers = [@{} mutableCopy];
    ABMultiValueRef emails = ABRecordCopyValue(record, kABPersonEmailProperty);
    for(int i = 0; i < ABMultiValueGetCount(emails); i++)
    {
        
        CFStringRef emailLabelRef = ABMultiValueCopyLabelAtIndex(emails, i);
        CFStringRef localizedEmailLabelRef = ABAddressBookCopyLocalizedLabel(emailLabelRef);
        CFStringRef emailRef = ABMultiValueCopyValueAtIndex(emails, i);
        
        NSString * localizedEmailLabel = (__bridge  NSString *)localizedEmailLabelRef;
        
        NSString * email = (__bridge NSString *)emailRef;
        
        [emailNumbers setValue:email forKey:localizedEmailLabel];
        
        emailLabelRef == NULL ? : CFRelease(emailLabelRef);
        localizedEmailLabel == NULL ? : CFRelease(localizedEmailLabelRef);
        emailRef == NULL ? : CFRelease(emailRef);
    }
    if(emails != NULL) CFRelease(emails);
    return emailNumbers;
}

-(ABRecordRef)recordFromABRecordRefID:(NSUInteger)recordId
{
    ABAddressBookRef addressBooks = ABAddressBookCreateWithOptions(NULL, NULL);
    ABRecordRef abPerson = ABAddressBookGetPersonWithRecordID(addressBooks, (int)recordId);
    return abPerson;
}

#pragma mark - SET

-(void)setRecordImage:(ABRecordRef)abPerson NewImage:(UIImage*)newImage
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
            ABAddressBookRef addressBooks = ABAddressBookCreateWithOptions(NULL, NULL);
            NSData* data=UIImagePNGRepresentation(newImage);
        
            ABPersonRemoveImageData(abPerson, NULL);
            ABAddressBookAddRecord(addressBooks, abPerson, nil);
            ABAddressBookSave(addressBooks, nil);
        
            CFDataRef cfData=CFDataCreate(NULL, [data bytes], [data length]);
            ABPersonSetImageData(abPerson, cfData, nil);
            ABAddressBookAddRecord(addressBooks, abPerson, nil);
            ABAddressBookSave(addressBooks, nil);
            CFRelease(cfData);
            
            DLog(@"set succeed");
    });
}

@end
