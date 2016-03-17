//
//  ImageData.m
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import "ImageData.h"

@implementation ImageData

#pragma mark - URLs

-(NSURL*)localURL {
    //TODO
    return nil;
}

-(NSURL*)externalURL {
    //TODO
    return nil;
}

#pragma mark - DictionaryData
#pragma mark Constants
const NSString *IMAGEIDKEY = @"ImageID";
const NSString *TAGIDSKEY = @"TagIDs";
const NSString *ISSYNCEDKEY = @"IsSynced";


+(id)createWithDictionary:(NSDictionary*)dict {
    ImageData *imageData = [[ImageData alloc]init];
    [imageData setValuesFromDictionary:dict];
    return imageData;
}

-(void)setValuesFromDictionary:(NSDictionary*)dict {
    if (dict) {
        if ([[dict objectForKey:IMAGEIDKEY]isKindOfClass:NSNumber.class]) {
            self.imageID = [dict objectForKey:IMAGEIDKEY];
        }
        if ([[dict objectForKey:TAGIDSKEY]isKindOfClass:NSArray.class]) {
            self.tagIDs = [dict objectForKey:TAGIDSKEY];
        }
        if ([[dict objectForKey:ISSYNCEDKEY]isKindOfClass:NSNumber.class]) {
            self.isSynced = [dict objectForKey:ISSYNCEDKEY];
        }
    }
}

-(NSDictionary*)dictionary {
    NSNumber *safeImageId = (self.imageID) ? self.imageID : @0;
    NSArray *safeTagArray = (self.tagIDs) ? self.tagIDs : @[];
    NSNumber *safeIsSynced = (self.isSynced) ? self.isSynced : @0;
    return @{safeImageId:IMAGEIDKEY, safeTagArray:TAGIDSKEY, safeIsSynced:ISSYNCEDKEY};
}

@end
