//
//  NSMutableDictionary+AppData.m
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import "NSMutableDictionary+AppData.h"

@implementation NSMutableDictionary (AppData)

+(id)newAppWithName:(NSString*)appName {
    NSMutableDictionary *newAppData = [[NSMutableDictionary alloc]init];
    if (newAppData) {
        newAppData.appName = appName;
        newAppData.displayName = appName;
        newAppData.tagID = [newAppData abbreviationOfAppName];
    }
    return newAppData;
}

-(id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark - Constants

const NSString *APPNAMEKEY = @"AppName";
const NSString *APPSTORELINKKEY = @"AppStoreLink";
const NSString *SWEETCAFFEKEY = @"SweetCaffe";
const NSString *TRANSFERCODEKEY = @"TransferCode";

#pragma mark - Getters

-(NSString*)appName {
    return [self objectForKey:APPNAMEKEY];
}

-(NSURL*)appStoreLink {
    NSString *linkAsString = [self objectForKey:APPSTORELINKKEY];
    return [NSURL URLWithString:linkAsString];
}

-(NSNumber*)syncsWithSweetCaffe {
    return [self objectForKey:SWEETCAFFEKEY];
}

-(NSMutableDictionary*)transferCode {
    return [self objectForKey:TRANSFERCODEKEY];
}

#pragma mark - Setters

-(void)setAppName:(NSString *)appName {
    [self setObject:appName forKey:APPNAMEKEY];
}

-(void)setAppStoreLink:(NSURL *)appStoreLink {
    NSString *linkAsString = appStoreLink.absoluteString;
    [self setObject:linkAsString forKey:APPSTORELINKKEY];
}

-(void)setSyncsWithSweetCaffe:(NSNumber *)syncsWithSweetCaffe {
    [self setObject:syncsWithSweetCaffe forKey:SWEETCAFFEKEY];
}

-(void)setTransferCode:(NSMutableDictionary *)transferCode {
    [self setObject:transferCode forKey:TRANSFERCODEKEY];
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
