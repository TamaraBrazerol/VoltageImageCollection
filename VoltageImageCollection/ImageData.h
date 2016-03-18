//
//  ImageData.h
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DictionaryData.h"
#import "Tag.h"

//- res?
//- file size?

@interface ImageData : NSObject <DictionaryData>

@property (strong) NSNumber *imageID;
@property (strong) NSNumber *isSynced;
@property (readonly) NSMutableSet *tagIDs;

-(NSURL*)localURL;
-(NSURL*)externalURL;

-(void)addTag:(Tag*)newTag;

@end
