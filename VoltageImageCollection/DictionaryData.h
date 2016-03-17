//
//  DictionaryData.h
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 17/03/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DictionaryData
+(id)createWithDictionary:(NSDictionary*)dict;

-(void)setValuesFromDictionary:(NSDictionary*)dict;
-(NSDictionary*)dictionary;
@optional
+(BOOL)containsDataForThisClassInDictionary:(NSDictionary*)dict;
@end