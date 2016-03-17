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

#pragma mark - Overwrite NSObject

-(NSString*)description {
    NSString *format = @"\ndisplayName: \t%@ \ntagID: \t%@";
    return [NSString stringWithFormat:format, self.displayName, self.tagID];
}

@end
