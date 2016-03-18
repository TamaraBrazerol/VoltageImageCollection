//
//  ImageData.m
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import "ImageData.h"

@implementation ImageData

-(id)init {
    self = [super init];
    if (self) {
        _tagIDs = [NSMutableSet set];
    }
    return self;
}
-(void)addTag:(Tag*)newTag {
    [_tagIDs addObject:newTag.tagID];
}

#pragma mark - URLs

-(NSURL*)localURL {
    //TODO
    return [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"png"];
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
            _imageID = [dict objectForKey:IMAGEIDKEY];
        }
        if ([[dict objectForKey:ISSYNCEDKEY]isKindOfClass:NSNumber.class]) {
            _isSynced = [dict objectForKey:ISSYNCEDKEY];
        }
        if ([[dict objectForKey:TAGIDSKEY]isKindOfClass:NSArray.class]) {
            NSArray *tagIDsAsArray =  [dict objectForKey:TAGIDSKEY];
            _tagIDs = [NSMutableSet setWithArray:tagIDsAsArray];
        }

    }
}

-(NSDictionary*)dictionary {
    NSNumber *safeImageId = (self.imageID) ? self.imageID : @0;
    NSNumber *safeIsSynced = (self.isSynced) ? self.isSynced : @0;
    
    NSArray *safeTagArray = (self.tagIDs) ? [self.tagIDs allObjects] : @[];

    return @{IMAGEIDKEY:safeImageId, TAGIDSKEY:safeTagArray, ISSYNCEDKEY:safeIsSynced};
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
