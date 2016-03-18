//
//  DataHandler.h
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 17/03/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ImageData.h"
#import "AppData.h"
#import "StoryCharacter.h"

@interface DataHandler : NSObject

@property (readonly) NSMutableArray *allImages;
@property (readonly) NSMutableArray *allTags;

+ (instancetype)sharedInstance;

-(void)startCloudSync;
-(NSArray*)getAllAppDataTags;
-(NSArray*)getAllStoryCharacterTags;

@end
