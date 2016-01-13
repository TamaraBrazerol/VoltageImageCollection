//
//  NSMutableDictionary+TransferCode.m
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import "NSMutableDictionary+TransferCode.h"

@implementation NSMutableDictionary (TransferCode)

#pragma mark - Constants

const NSString *APPIDKEY = @"AppID";
const NSString *SUBIDKEY = @"SubID";
const NSString *TRANSFERIDKEY = @"TransferID";

#pragma mark - Getters

-(NSString*)appID {
    return [self objectForKey:APPIDKEY];
}

-(NSString*)subID {
    return [self objectForKey:SUBIDKEY];
}

-(NSString*)transferID {
    return [self objectForKey:TRANSFERIDKEY];
}

#pragma mark - Setters

-(void)setAppID:(NSString *)appID {
    [self setObject:appID forKey:APPIDKEY];
}
-(void)setSubID:(NSString *)subID {
    [self setObject:subID forKey:SUBIDKEY];
}

-(void)setTransferID:(NSString *)transferID {
    [self setObject:transferID forKey:TRANSFERIDKEY];
}

@end
