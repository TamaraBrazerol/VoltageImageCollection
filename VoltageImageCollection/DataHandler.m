//
//  DataHandler.m
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 17/03/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import "DataHandler.h"

@implementation DataHandler


#pragma mark - R/W Images
const NSString *IMAGESKEY = @"ImagesList";

-(void)loadImagesData {
    NSArray *imageDicts = [[NSUserDefaults standardUserDefaults]objectForKey:IMAGESKEY];
    
    if (!_allImages) {
        _allImages = [NSMutableArray arrayWithCapacity:imageDicts.count];
    }
    for (NSDictionary *imageDataDict in imageDicts) {
        [_allImages addObject:[ImageData createWithDictionary:imageDataDict]];
    }
}

-(void)saveImagesData {
    NSMutableArray *imageDataAsDicts = [NSMutableArray arrayWithCapacity:_allImages.count];
    for (ImageData *image in _allImages) {
        [imageDataAsDicts addObject:[image dictionary]];
    }
    [[NSUserDefaults standardUserDefaults]setObject:imageDataAsDicts forKey:IMAGESKEY];
}

#pragma mark - R/W Tags
const NSString *TAGSKEY = @"TagsList";

-(void)loadTags {
    NSArray *tagDicts = [[NSUserDefaults standardUserDefaults]objectForKey:TAGSKEY];

    if (!_allTags) {
        _allTags = [NSMutableArray arrayWithCapacity:tagDicts.count];
    }
    
    for (NSDictionary *tagDataDict in tagDicts) {
        if ([AppData containsDataForThisClassInDictionary:tagDataDict]) {
            [_allTags addObject:[AppData createWithDictionary:tagDataDict]];

        } else if ([StoryCharacter containsDataForThisClassInDictionary:tagDataDict]) {
            [_allTags addObject:[StoryCharacter createWithDictionary:tagDataDict]];
            
        } else {
            [_allTags addObject:[Tag createWithDictionary:tagDataDict]];

        }
    }
}

@end
