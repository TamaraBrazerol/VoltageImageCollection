//
//  StoryCharacter.m
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 17/03/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import "StoryCharacter.h"

@implementation StoryCharacter

-(NSString*)tagID {
    NSMutableString *mutableTagId = [NSMutableString stringWithCapacity:self.firstName.length];
    if (self.firstName) {
        [mutableTagId appendString:self.firstName];
    }
    if (self.lastName) {
        [mutableTagId appendString:self.lastName];
    }
    return [NSString stringWithString:mutableTagId].uppercaseString;
}


#pragma mark - DictionaryData

#pragma mark Constants
const NSString *FIRSTNAMEKEY = @"FirstName";
const NSString *LASTNAMEKEY = @"LastName";
const NSString *NICKNAMEKEY = @"Nickname";

+(id)createWithDictionary:(NSDictionary*)dict {
    StoryCharacter *chracter = [[StoryCharacter alloc]init];
    [chracter setValuesFromDictionary:dict];
    return chracter;
}

-(void)setValuesFromDictionary:(NSDictionary*)dict {
    if (dict) {
        [super setValuesFromDictionary:dict];
        if ([[dict objectForKey:FIRSTNAMEKEY]isKindOfClass:NSString.class]) {
            self.firstName = [dict objectForKey:FIRSTNAMEKEY];
        }
        if ([[dict objectForKey:LASTNAMEKEY]isKindOfClass:NSString.class]) {
            self.lastName = [dict objectForKey:LASTNAMEKEY];
        }
        if ([[dict objectForKey:NICKNAMEKEY]isKindOfClass:NSString.class]) {
            self.nickname = [dict objectForKey:NICKNAMEKEY];
        }
    }
}

-(NSDictionary*)dictionary {
    NSMutableDictionary *tagDict = [self tagDictionary];
    NSString *safeFirstName = (self.firstName) ? self.firstName : @"";
    NSString *safeLastName = (self.lastName) ? self.lastName : @"";
    NSString *safeNickname = (self.nickname) ? self.nickname : @"";
    
    NSDictionary *characterDic = @{safeFirstName:FIRSTNAMEKEY, safeLastName:LASTNAMEKEY, safeNickname:NICKNAMEKEY};
    [tagDict addEntriesFromDictionary:characterDic];
    return tagDict;
}

+(BOOL)containsDataForThisClassInDictionary:(NSDictionary*)dict {
    if ([[dict objectForKey:FIRSTNAMEKEY]isKindOfClass:NSString.class]) {
        return YES;
    }
    if ([[dict objectForKey:LASTNAMEKEY]isKindOfClass:NSString.class]) {
        return YES;
    }
    if ([[dict objectForKey:NICKNAMEKEY]isKindOfClass:NSString.class]) {
        return YES;
    }
    return NO;
}

@end
