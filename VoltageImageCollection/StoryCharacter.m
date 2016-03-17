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
    return [NSString stringWithString:mutableTagId];
}

@end
