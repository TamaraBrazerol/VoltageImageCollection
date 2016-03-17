//
//  AppData.m
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import "AppData.h"

@implementation AppData

#pragma mark - create


+(id)newAppWithName:(NSString*)appName {
    AppData *newAppData = [[AppData alloc]init];
    if (newAppData) {
        newAppData.appName = appName;
        newAppData.displayName = appName;
    }
    return newAppData;
}

-(NSString*)tagID {
    return [self abbreviationOfAppName].uppercaseString;
}

#pragma mark - Overwrite NSObject

-(NSString*)description {
    NSString *format = @"\nappName: \t%@ \ndisplayName: \t%@ \ntagID: \t%@ \nappStoreLink: \t%@ \nsyncsWithSweetCaffe: \t%@ \ntransferCode: \t%@";
    return [NSString stringWithFormat:format, self.appName, self.displayName, self.tagID, self.appStoreLink, self.syncsWithSweetCaffe, self.transferCode];
}

#pragma mark - DictionaryData

#pragma mark Constants
const NSString *APPNAMEKEY = @"AppName";
const NSString *APPSTORELINKKEY = @"AppStoreLink";
const NSString *SWEETCAFEKEY = @"SweetCafe";

+(id)createWithDictionary:(NSDictionary*)dict {
    AppData *appData = [[AppData alloc]init];
    [appData setValuesFromDictionary:dict];
    return appData;
}

-(void)setValuesFromDictionary:(NSDictionary*)dict {
    if (dict) {
        [super setValuesFromDictionary:dict];
        if ([[dict objectForKey:APPNAMEKEY]isKindOfClass:NSString.class]) {
            self.appName = [dict objectForKey:APPNAMEKEY];
        }
        if ([[dict objectForKey:APPSTORELINKKEY]isKindOfClass:NSString.class]) {
            self.appStoreLink = [NSURL URLWithString:[dict objectForKey:APPSTORELINKKEY]];
        }
        if ([[dict objectForKey:SWEETCAFEKEY]isKindOfClass:NSNumber.class]) {
            self.syncsWithSweetCaffe = [dict objectForKey:SWEETCAFEKEY];
        }
        self.transferCode = [TransferCode createWithDictionary:dict];
    }
}

-(NSDictionary*)dictionary {
    NSMutableDictionary *tagDict = [self tagDictionary];
    NSString *safeAppName = (self.appName) ? self.appName : @"";
    NSString *safeAppStoreLink = (self.appStoreLink) ? self.appStoreLink.absoluteString : @"";
    NSNumber *safeSweetCafe = (self.syncsWithSweetCaffe) ? self.syncsWithSweetCaffe : @0;
    
    NSDictionary *appDataDic = @{safeAppName:APPNAMEKEY, safeAppStoreLink:APPSTORELINKKEY, safeSweetCafe:SWEETCAFEKEY};
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
