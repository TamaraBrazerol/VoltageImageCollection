//
//  Tag.m
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//


#import "Tag.h"

@implementation Tag

+(id)newTagWithName:(NSString*)tagName {
    Tag *newTag = [[Tag alloc]init];
    if (newTag) {
        newTag.displayName = tagName;
    }
    return newTag;
}

-(NSString*)tagID {
    NSMutableString *mutableTagId = [NSMutableString stringWithString:self.displayName];
    [mutableTagId stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [NSString stringWithString:mutableTagId].uppercaseString;
}

-(NSDictionary*)tagDictionary {
    NSString *safeDisplayName = (self.displayName) ? self.displayName : @"";
    NSString *safeTagId = (self.tagID) ? self.tagID : @"";
    return  @{DISPLAYNAMEKEY:safeDisplayName, TAGIDKEY:safeTagId};
}

#pragma mark - DictionaryData
#pragma mark - Constants
const NSString *DISPLAYNAMEKEY = @"DisplayName";
const NSString *TAGIDKEY = @"TagID";

+(id)createWithDictionary:(NSDictionary*)dict {
    Tag *tag = [[Tag alloc]init];
    [tag setValuesFromDictionary:dict];
    return tag;
}

-(void)setValuesFromDictionary:(NSDictionary*)dict {
    if (dict) {
        if ([[dict objectForKey:DISPLAYNAMEKEY]isKindOfClass:NSString.class]) {
            _displayName = [dict objectForKey:DISPLAYNAMEKEY];
        }
    }
}

-(NSDictionary*)dictionary {
    return [self tagDictionary];
}

#pragma mark - Overwrite NSObject
#if DEBUG
- (BOOL) isNSDictionary__
{
    return YES;
}
#endif
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    return [[self dictionary]descriptionWithLocale:locale indent:level];
}

@end
