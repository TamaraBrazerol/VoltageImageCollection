//
//  NSMutableDictionary+Tag.m
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import "NSMutableDictionary+Tag.h"

@implementation NSMutableDictionary (Tag)

#pragma mark - Constants

const NSString *TAGIDKEY = @"TagID";
const NSString *DISPLAYNAMEKEY = @"DisplayName";

#pragma mark - Getters

-(NSString*)tagID {
    return [self objectForKey:TAGIDKEY];
}

-(NSString*)displayName {
    return [self objectForKey:DISPLAYNAMEKEY];
}

#pragma mark - Setters

-(void)setTagID:(NSString *)tagID{
    [self setObject:tagID forKey:TAGIDKEY];
}

-(void)setDisplayName:(NSString *)displayName{
    [self setObject:displayName forKey:DISPLAYNAMEKEY];
}


@end
