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

@interface DataHandler () <DBRestClientDelegate>
@property DBRestClient *restClient;
@property DBMetadata *loadedMetadata;
@end

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
        self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        self.restClient.delegate = self;
        [self.restClient loadMetadata:@"/"];
        // after metadata is loaded it checks if all the folders are there and updates them
    }
    if (_allTags.count == 0) {
        [self fillTestData];
    }
}

-(void)updateFolders {
    NSArray *subfoldersList = [self localFolderNames];
    NSArray *cloudSubfolders = self.loadedMetadata.contents;
    
    NSMutableArray *foldersToCreate = [NSMutableArray arrayWithArray:subfoldersList];
    
    for (NSString *folderName in subfoldersList) {
        for (DBMetadata *cloudFolder in cloudSubfolders) {
            if ([folderName isEqualToString:cloudFolder.filename]) {
                //folder exists in cloud
                [self updateFolderWithName:folderName];
                [foldersToCreate removeObject:folderName];
                break;
            }
        }
    }
    for (NSString *newFolderName in foldersToCreate) {
        [self.restClient createFolder:newFolderName];
    }
}

-(void)updateFolderWithName:(NSString*)folderName {
    if (folderName) {
        if ([folderName isEqualToString:@"data"]) {
            [self saveTags];
            [self saveImagesData];
            DDLogDebug(@"load/upload plists");
            //TODO: load/upload plists to/from disk (and memory)
        } else if ([folderName isEqualToString:@"images"]) {
            //TODO: load tumbs? upload new images
            DDLogDebug(@"load tumbs? upload new images");
        } else if ([folderName isEqualToString:@"import"]) {
            //TODO: load images and create ImageData entries
            DDLogDebug(@"load images and create ImageData entries");
        } else  {
            DDLogWarn(@"new folder?");
        }
    }
}

#pragma mark - URLs

-(NSURL*)appRootURL{
    NSArray *paths = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsURL = [paths lastObject];
    return documentsURL;
}

-(NSURL*)importFolderURL {
    return [[self appRootURL]URLByAppendingPathComponent:@"import" isDirectory:YES];
}

-(NSURL*)dataFolderURL {
    return [[self appRootURL]URLByAppendingPathComponent:@"data" isDirectory:YES];
}


-(NSURL*)tagsDataURL {
    return [[self dataFolderURL]URLByAppendingPathComponent:@"tags.plist" isDirectory:NO];
}

-(NSURL*)imagesDataURL {
    return [[self dataFolderURL]URLByAppendingPathComponent:@"images.plist" isDirectory:NO];
}

-(NSURL*)imagesFolderURL {
    return [[self appRootURL]URLByAppendingPathComponent:@"images" isDirectory:YES];
}

#pragma mark - local folders

-(void)createDataFolders {
    [self createFolderWithURL:[self importFolderURL]];
    [self createFolderWithURL:[self dataFolderURL]];
    [self createFolderWithURL:[self imagesFolderURL]];
    NSError *error = nil;
    NSArray *subfoldersList = [[NSFileManager defaultManager]subpathsOfDirectoryAtPath:[self appRootURL].path error:&error];
    DDLogDebug(@"App Sub Folders:%@", subfoldersList);
}

- (void)createFolderWithURL:(NSURL *)folderURL {
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderURL.path]) {
        [[NSFileManager defaultManager] createDirectoryAtURL:folderURL withIntermediateDirectories:YES attributes:nil error:&error];
        if (!error) {
            DDLogInfo(@"created %@", folderURL);
        } else {
            DDLogError(@"%@", error.localizedDescription);
        }
    }
}

-(NSArray*)localFolderNames {
    NSError *error = nil;
    NSArray *subfoldersList = [[NSFileManager defaultManager]subpathsOfDirectoryAtPath:[self appRootURL].path error:&error];
    return subfoldersList;
}

#pragma mark - DBRestClientDelegate

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    if (metadata.isDirectory && [metadata.path isEqualToString:@"/"]) {
        self.loadedMetadata = metadata;
        [self updateFolders];
    }
    else {
        DDLogWarn(@"metadata.path: %@", metadata.path);
    }
}

- (void)restClient:(DBRestClient *)client loadMetadataFailedWithError:(NSError *)error {
    DDLogError(@"Error loading metadata: %@", error);
}

- (void)restClient:(DBRestClient*)client createdFolder:(DBMetadata*)folder {
    DDLogInfo(@"created folder '%@' in cloud", folder.path);
    [self updateFolderWithName:folder.path];
}

- (void)restClient:(DBRestClient*)client createFolderFailedWithError:(NSError*)error {
    if (error.code == 403) {
        DDLogDebug(@"folder already exists in cloud");
    } else {
        DDLogError(@"%@", [error userInfo]);
    }
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

-(void)loadImagesData {
    NSArray *imageDicts = [NSArray arrayWithContentsOfURL:[self imagesDataURL]];
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
    [imageDataAsDicts writeToURL:[self imagesDataURL] atomically:YES];
}

#pragma mark - R/W Tags

-(void)loadTags {
    NSArray *tagDicts = [NSArray arrayWithContentsOfURL:[self tagsDataURL]];
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
    [tagsAsDicts writeToURL:[self tagsDataURL] atomically:YES];
}

@end
