//
//  StoryCharacter.m
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 17/03/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import "StoryCharacter.h"

@implementation StoryCharacter

+(id)newCharacterWithFistName:(NSString*)firstName andLastName:(NSString*)lastName {
    StoryCharacter *newCharacter = [[StoryCharacter alloc]init];
    if (newCharacter) {
        newCharacter.firstName = firstName;
        newCharacter.lastName = lastName;
    }
    return newCharacter;
}

-(NSString*)displayName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

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
            _firstName = [dict objectForKey:FIRSTNAMEKEY];
        }
        if ([[dict objectForKey:LASTNAMEKEY]isKindOfClass:NSString.class]) {
            _lastName = [dict objectForKey:LASTNAMEKEY];
        }
        if ([[dict objectForKey:NICKNAMEKEY]isKindOfClass:NSString.class]) {
            _nickname = [dict objectForKey:NICKNAMEKEY];
        }
    }
}

-(NSDictionary*)dictionary {
    NSMutableDictionary *tagDict = [NSMutableDictionary dictionaryWithDictionary:[self tagDictionary]];
    NSString *safeFirstName = (self.firstName) ? self.firstName : @"";
    NSString *safeLastName = (self.lastName) ? self.lastName : @"";
    NSString *safeNickname = (self.nickname) ? self.nickname : @"";
    
    NSDictionary *characterDic = @{FIRSTNAMEKEY:safeFirstName, LASTNAMEKEY:safeLastName, NICKNAMEKEY:safeNickname};
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

//#pragma mark - Overwrite NSObject
//
//- (NSString *)description {
//    return [[self dictionary]descriptionWithLocale:nil indent:1];
//}

@end
