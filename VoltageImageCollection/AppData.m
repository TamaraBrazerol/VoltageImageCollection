//
//  AppData.m
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import "AppData.h"

@implementation AppData

+(id)newAppWithName:(NSString*)appName {
    AppData *newAppData = [[AppData alloc]init];
    if (newAppData) {
        newAppData.appName = appName;
        newAppData.displayName = appName;
    }
    return newAppData;
}

-(id)init {
    self = [super init];
    if (self) {
        _storyCharacterIDs = [NSMutableSet set];
    }
    return self;
}

-(NSString*)tagID {
    return [self abbreviationOfAppName].uppercaseString;
}

-(void)addStoryCharacter:(StoryCharacter*)newCharacter {
    [_storyCharacterIDs addObject:newCharacter.tagID];
}

#pragma mark - DictionaryData

#pragma mark Constants
const NSString *APPNAMEKEY = @"AppName";
const NSString *APPSTORELINKKEY = @"AppStoreLink";
const NSString *SWEETCAFEKEY = @"SweetCafe";
const NSString *STORYCHARACTERIDSKEY = @"StoryCharacterIDs";

+(id)createWithDictionary:(NSDictionary*)dict {
    AppData *appData = [[AppData alloc]init];
    [appData setValuesFromDictionary:dict];
    return appData;
}

-(void)setValuesFromDictionary:(NSDictionary*)dict {
    if (dict) {
        [super setValuesFromDictionary:dict];
        if ([[dict objectForKey:APPNAMEKEY]isKindOfClass:NSString.class]) {
            _appName = [dict objectForKey:APPNAMEKEY];
        }
        if ([[dict objectForKey:APPSTORELINKKEY]isKindOfClass:NSString.class]) {
            _appStoreLink = [NSURL URLWithString:[dict objectForKey:APPSTORELINKKEY]];
        }
        if ([[dict objectForKey:SWEETCAFEKEY]isKindOfClass:NSNumber.class]) {
            _syncsWithSweetCaffe = [dict objectForKey:SWEETCAFEKEY];
        }
        if ([[dict objectForKey:STORYCHARACTERIDSKEY]isKindOfClass:NSArray.class]) {
            NSArray *charactersAsArray =  [dict objectForKey:STORYCHARACTERIDSKEY];
            _storyCharacterIDs = [NSMutableSet setWithArray:charactersAsArray];
        }
        _transferCode = [TransferCode createWithDictionary:dict];
    }
}

-(NSDictionary*)dictionary {
    NSMutableDictionary *tagDict = [NSMutableDictionary dictionaryWithDictionary:[self tagDictionary]];
    NSString *safeAppName = (self.appName) ? self.appName : @"";
    NSString *safeAppStoreLink = (self.appStoreLink) ? self.appStoreLink.absoluteString : @"";
    NSNumber *safeSweetCafe = (self.syncsWithSweetCaffe) ? self.syncsWithSweetCaffe : @0;
    NSArray *safeCharacterArray = (self.storyCharacterIDs) ? [self.storyCharacterIDs allObjects] : @[];

    NSDictionary *appDataDic = @{APPNAMEKEY:safeAppName, APPSTORELINKKEY:safeAppStoreLink, SWEETCAFEKEY:safeSweetCafe, STORYCHARACTERIDSKEY:safeCharacterArray};
    NSDictionary *transferCodeDict = [self.transferCode dictionary];
    
    [tagDict addEntriesFromDictionary:appDataDic];
    [tagDict addEntriesFromDictionary:transferCodeDict];
    return tagDict;
}

+(BOOL)containsDataForThisClassInDictionary:(NSDictionary*)dict {
    if ([[dict objectForKey:APPNAMEKEY]isKindOfClass:NSString.class]) {
        return YES;
    }
    if ([[dict objectForKey:APPSTORELINKKEY]isKindOfClass:NSString.class]) {
        return YES;
    }
    if ([[dict objectForKey:SWEETCAFEKEY]isKindOfClass:NSNumber.class]) {
        return YES;
    }
    return NO;
}

#pragma mark - Private

-(NSString*)abbreviationOfAppName {
    NSString *abbreviation = @"";
    if (self.appName) {
        NSArray *wordsInName = [self.appName componentsSeparatedByString:@" "];
        NSMutableString *mutableAbbreviation = [NSMutableString stringWithCapacity:wordsInName.count];
        for (NSString *word in wordsInName) {
            NSString *firstLetter = [word substringToIndex:1];
            [mutableAbbreviation appendString:firstLetter];
        }
        abbreviation = mutableAbbreviation;
    }
    return abbreviation;
}

@end
