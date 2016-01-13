//
//  NSMutableDictionary+ImageData.m
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import "NSMutableDictionary+ImageData.h"

@implementation NSMutableDictionary (ImageData)

#pragma mark - Constants

const NSString *IMAGEIDKEY = @"ImageID";
const NSString *TAGIDSKEY = @"TagIDs";
const NSString *ISSYNCEDKEY = @"IsSynced";

#pragma mark - Getters

-(NSNumber*)imageID {
    return [self objectForKey:IMAGEIDKEY];
}

-(NSArray*)tagIDs {
    return [self objectForKey:TAGIDSKEY];
}

-(NSNumber*)isSynced {
    return [self objectForKey:ISSYNCEDKEY];
}

#pragma mark - Setters

-(void)setImageID:(NSNumber *)imageID {
    [self setObject:imageID forKey:IMAGEIDKEY];
}

-(void)setTagIDs:(NSArray *)tagIDs {
    [self setObject:tagIDs forKey:TAGIDSKEY];
}

-(void)setIsSynced:(NSNumber *)isSynced {
    [self setObject:isSynced forKey:ISSYNCEDKEY];
}

#pragma mark - URLs

-(NSURL*)localURL {
    //TODO
    return nil;
}

-(NSURL*)externalURL {
    //TODO
    return nil;
}



@end
