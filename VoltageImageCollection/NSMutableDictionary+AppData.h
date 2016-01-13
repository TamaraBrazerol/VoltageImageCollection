//
//  NSMutableDictionary+AppData.h
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableDictionary+Tag.h"
#import "NSMutableDictionary+TransferCode.h"

@interface NSMutableDictionary (AppData)

// The apps tag.id is the app abbreviation (MFW, KBTBB, etc.)
@property (weak) NSString *appName;
@property (weak) NSURL *appStoreLink;
@property (weak) NSNumber *syncsWithSweetCaffe;
@property (weak) NSMutableDictionary *transferCode;

+(id)newAppWithName:(NSString*)appName;

@end
