//
//  TransferCode.m
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import "TransferCode.h"

@implementation TransferCode

#pragma mark - DictionaryData
#pragma mark - Constants
const NSString *APPIDKEY = @"AppID";
const NSString *SUBIDKEY = @"SubID";
const NSString *TRANSFERIDKEY = @"TransferID";

+(id)createWithDictionary:(NSDictionary*)dict {
    TransferCode *transferCode = [[TransferCode alloc]init];
    [transferCode setValuesFromDictionary:dict];
    return transferCode;
}

-(void)setValuesFromDictionary:(NSDictionary*)dict {
    if (dict) {
        if ([[dict objectForKey:APPIDKEY]isKindOfClass:NSString.class]) {
            self.appID = [dict objectForKey:APPIDKEY];
        }
        if ([[dict objectForKey:SUBIDKEY]isKindOfClass:NSString.class]) {
            self.subID = [dict objectForKey:SUBIDKEY];
        }
        if ([[dict objectForKey:TRANSFERIDKEY]isKindOfClass:NSString.class]) {
            self.transferID = [dict objectForKey:TRANSFERIDKEY];
        }
    }
}

-(NSDictionary*)dictionary {
    NSString *safeAppId = (self.appID) ? self.appID : @"";
    NSString *safeSubId = (self.subID) ? self.subID : @"";
    NSString *safeTransferId = (self.transferID) ? self.transferID : @"";
    return @{safeAppId:APPIDKEY, safeSubId:SUBIDKEY, safeTransferId:TRANSFERIDKEY};
}


@end
