//
//  StoryCharacter.h
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 17/03/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import "Tag.h"

@interface StoryCharacter : Tag <DictionaryData>

@property (strong) NSString *firstName;
@property (strong) NSString *lastName;
@property (strong) NSString *nickname;

+(id)newCharacterWithFistName:(NSString*)firstName andLastName:(NSString*)lastName;

@end
