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

-(NSString*)tagID {
    return [self abbreviationOfAppName].uppercaseString;
}

#pragma mark - Overwrite NSObject

-(NSString*)description {
    NSString *format = @"\nappName: \t%@ \ndisplayName: \t%@ \ntagID: \t%@ \nappStoreLink: \t%@ \nsyncsWithSweetCaffe: \t%@ \ntransferCode: \t%@";
    return [NSString stringWithFormat:format, self.appName, self.displayName, self.tagID, self.appStoreLink, self.syncsWithSweetCaffe, self.transferCode];
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
