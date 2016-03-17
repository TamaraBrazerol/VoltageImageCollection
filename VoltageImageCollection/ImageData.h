//
//  ImageData.h
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import <Foundation/Foundation.h>

//- res?
//- file size?

@interface ImageData : NSObject
@property (weak) NSNumber *imageID;
@property (weak) NSArray *tagIDs;
@property (weak) NSNumber *isSynced;

+(id)createWithDictionary:(NSDictionary*)dict;
-(NSDictionary*)dictionary;

-(NSURL*)localURL;
-(NSURL*)externalURL;

@end
