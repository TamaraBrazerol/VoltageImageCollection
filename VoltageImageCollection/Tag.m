//
//  Tag.m
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//


#import "Tag.h"

@implementation Tag

-(NSString*)tagID {
    NSMutableString *mutableTagId = [NSMutableString stringWithString:self.displayName];
    [mutableTagId stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [NSString stringWithString:mutableTagId].uppercaseString;
}

-(NSMutableDictionary*)tagDictionary {
    NSString *safeDisplayName = (self.displayName) ? self.displayName : @"";
    NSDictionary *tagDict = @{safeDisplayName:DISPLAYNAMEKEY};
    return [NSMutableDictionary dictionaryWithDictionary:tagDict];
}

#pragma mark - DictionaryData
#pragma mark - Constants
const NSString *DISPLAYNAMEKEY = @"DisplayName";

+(id)createWithDictionary:(NSDictionary*)dict {
    Tag *tag = [[Tag alloc]init];
    [tag setValuesFromDictionary:dict];
    return tag;
}

-(void)setValuesFromDictionary:(NSDictionary*)dict {
    if (dict) {
        if ([[dict objectForKey:DISPLAYNAMEKEY]isKindOfClass:NSString.class]) {
            self.displayName = [dict objectForKey:DISPLAYNAMEKEY];
        }
    }
}

-(NSDictionary*)dictionary {
    return [self tagDictionary];
}

#pragma mark - Overwrite NSObject

-(NSString*)description {
    NSString *format = @"\ndisplayName: \t%@ \ntagID: \t%@";
    return [NSString stringWithFormat:format, self.displayName, self.tagID];
}

@end
