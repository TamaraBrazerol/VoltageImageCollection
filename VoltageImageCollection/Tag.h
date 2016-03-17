//
//  Tag.h
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DictionaryData.h"

@interface Tag : NSObject <DictionaryData>

@property (readonly) NSString *tagID;
@property (strong) NSString *displayName;

-(NSMutableDictionary*)tagDictionary;

@end
