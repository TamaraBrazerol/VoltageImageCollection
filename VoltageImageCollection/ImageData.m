//
//  ImageData.m
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import "ImageData.h"

@implementation ImageData

#pragma mark - R/W to PList

+(id)createWithDictionary:(NSDictionary*)dict {
    if (dict) {
        ImageData *self = [[ImageData alloc]init];
        //TODO: add values from dict
    }
    return nil;
}

-(NSDictionary*)dictionary {

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
