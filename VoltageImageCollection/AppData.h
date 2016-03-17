//
//  AppData.h
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tag.h"
#import "TransferCode.h"

@interface AppData : Tag

// The apps tag.id is the app abbreviation (MFW, KBTBB, etc.)
@property (strong) NSString *appName;
@property (strong) NSURL *appStoreLink;
@property (strong) NSNumber *syncsWithSweetCaffe;
@property (strong) TransferCode *transferCode;

+(id)newAppWithName:(NSString*)appName;

@end
