//
//  ImageListViewController.m
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import "ImageListViewController.h"
#import "DataHandler.h"

@interface ImageListViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSArray *tableData;
@end

@implementation ImageListViewController

-(void)configureTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

-(ImageData*)imageDataForIndexPath:(NSIndexPath *)indexPath {
   return [_tableData objectAtIndex:indexPath.row];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ImageList";
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureTableView];
    _tableData = [[DataHandler sharedInstance]allImages];
    
    NSLog(@"%@", _tableData);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *testCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    ImageData *imageData = [self imageDataForIndexPath:indexPath];
    testCell.textLabel.text = [NSString stringWithFormat:@"IMAGE %@", imageData.imageID];

    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[imageData localURL]]];
    testCell.imageView.image = image;
    return testCell;
}
- (NSInteger)tableView:(UITableView *)tableView  numberOfRowsInSection:(NSInteger)section {
    return [_tableData count];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ImageData *imageData = [self imageDataForIndexPath:indexPath];
    NSLog(@"Pressed '%@'", imageData.imageID);
}

@end
