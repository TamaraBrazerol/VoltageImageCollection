//
//  TransferCode.h
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DictionaryData.h"

@interface TransferCode : NSObject <DictionaryData>

@property (strong) NSString *appID;
@property (strong) NSString *subID;
@property (strong) NSString *transferID;

@end
