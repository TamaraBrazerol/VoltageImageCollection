//
//  DataHandler.m
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 17/03/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import "DataHandler.h"
#import "AppDelegate.h"
#import <DropboxSDK/DropboxSDK.h>


@implementation DataHandler

-(void)fillTestData{
    ImageData *image1 = [[ImageData alloc]init];
    image1.imageID = @1;
    ImageData *image2 = [[ImageData alloc]init];
    image2.imageID = @2;
    ImageData *image42 = [[ImageData alloc]init];
    image42.imageID = @42;
    
    [_allImages addObject:image1];
    [_allImages addObject:image2];
    [_allImages addObject:image42];

    AppData *app1 = [AppData newAppWithName:@"Kissed By The Baddest Bidder"];
    AppData *app2 = [AppData newAppWithName:@"Start Crossed Myth"];
    AppData *app3 = [AppData newAppWithName:@"My Forged Wedding"];
    StoryCharacter *char1 = [StoryCharacter newCharacterWithFistName:@"Scorpio" andLastName:@""];
    StoryCharacter *char2 = [StoryCharacter newCharacterWithFistName:@"Matsunari" andLastName:@"Baba"];
    Tag *tag1 = [Tag newTagWithName:@"Test"];
    
    [app1 addStoryCharacter:char2];
    [app2 addStoryCharacter:char1];
    
    [_allTags addObject:app1];
    [_allTags addObject:app2];
    [_allTags addObject:app3];
    [_allTags addObject:char1];
    [_allTags addObject:char2];
    [_allTags addObject:tag1];
    
    [image1 addTag:app1];
    [image1 addTag:char2];
    [image2 addTag:app3];
    [image2 addTag:tag1];
    [image42 addTag:tag1];
}

-(NSURL*)appRootURL{
    NSArray *paths = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsURL = [paths lastObject];
    return documentsURL;
}

-(NSURL*)importFolderURL {
    return [NSURL URLWithString:@"import" relativeToURL:[self appRootURL]];
}

-(NSURL*)dataFolderURL {
    return [NSURL URLWithString:@"data" relativeToURL:[self appRootURL]];
}

-(NSURL*)imagesFolderURL {
    return [NSURL URLWithString:@"images" relativeToURL:[self appRootURL]];
}

-(void)createDataFolders {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    DDLogDebug(@"%@", [self importFolderURL]);
    DDLogDebug(@"%@", [self dataFolderURL]);
    DDLogDebug(@"%@", [self imagesFolderURL]);

    NSError *error = nil;
    if (![fileManager fileExistsAtPath:[self importFolderURL].path]) {
        [fileManager createDirectoryAtURL:[self importFolderURL] withIntermediateDirectories:YES attributes:nil error:&error];
        if (!error) {
            DDLogDebug(@"created %@", [self importFolderURL]);
        } else {
            DDLogError(@"%@", error.localizedDescription);
        }
    }
    
}

#pragma mark - get data

-(NSArray*)getAllAppDataTags {
    NSPredicate *appDataClass = [NSPredicate predicateWithFormat:@"class == %@", [AppData class]];
    NSArray *allAppDataTags = [_allTags filteredArrayUsingPredicate:appDataClass];
    return allAppDataTags;
}

-(NSArray*)getAllStoryCharacterTags {
    NSPredicate *storyCharacterClass = [NSPredicate predicateWithFormat:@"class == %@", [StoryCharacter class]];
    NSArray *allStoryCharacterTags = [_allTags filteredArrayUsingPredicate:storyCharacterClass];
    return allStoryCharacterTags;
}

#pragma mark - cloud sync

-(void)startCloudSync {
    [self createDataFolders];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (![[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] linkFromController:[appDelegate currentViewController]];
    } else  {
        //TODO
        
    }
//    if (_allTags.count == 0) {
//        [self fillTestData];
//    }
}

#pragma mark - sharedInstance
+ (instancetype)sharedInstance
{
    static DataHandler *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataHandler alloc] init];
        [sharedInstance loadImagesData];
        [sharedInstance loadTags];
    });
    return sharedInstance;
}

#pragma mark - R/W Images
+(NSString*)imagesKey {
    return @"ImagesList";
}

-(void)loadImagesData {
    NSArray *imageDicts = [[NSUserDefaults standardUserDefaults]objectForKey:[DataHandler imagesKey]];
    if (!_allImages) {
        _allImages = [NSMutableArray arrayWithCapacity:imageDicts.count];
    }
    for (NSDictionary *imageDataDict in imageDicts) {
        [_allImages addObject:[ImageData createWithDictionary:imageDataDict]];
    }
}

-(void)saveImagesData {
    NSMutableArray *imageDataAsDicts = [NSMutableArray arrayWithCapacity:_allImages.count];
    for (ImageData *image in _allImages) {
        [imageDataAsDicts addObject:[image dictionary]];
    }
    NSLog(@"imageDataAsDicts: %@", imageDataAsDicts);
    [[NSUserDefaults standardUserDefaults]setObject:imageDataAsDicts forKey:[DataHandler imagesKey]];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

#pragma mark - R/W Tags
+(NSString*)tagsKey {
    return @"TagsList";
}

-(void)loadTags {
    NSArray *tagDicts = [[NSUserDefaults standardUserDefaults]objectForKey:[DataHandler tagsKey]];

    if (!_allTags) {
        _allTags = [NSMutableArray arrayWithCapacity:tagDicts.count];
    }
    
    for (NSDictionary *tagDataDict in tagDicts) {
        if ([AppData containsDataForThisClassInDictionary:tagDataDict]) {
            [_allTags addObject:[AppData createWithDictionary:tagDataDict]];

        } else if ([StoryCharacter containsDataForThisClassInDictionary:tagDataDict]) {
            [_allTags addObject:[StoryCharacter createWithDictionary:tagDataDict]];
            
        } else {
            [_allTags addObject:[Tag createWithDictionary:tagDataDict]];

        }
    }
}

-(void)saveTags {
    NSMutableArray *tagsAsDicts = [NSMutableArray arrayWithCapacity:_allTags.count];
    for (Tag *tag in _allTags) {
        [tagsAsDicts addObject:[tag dictionary]];
    }
    NSLog(@"tagsAsDicts: %@", tagsAsDicts);
    [[NSUserDefaults standardUserDefaults]setObject:tagsAsDicts forKey:[DataHandler tagsKey]];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
