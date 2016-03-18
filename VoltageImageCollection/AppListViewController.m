//
//  AppListViewController.m
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import "AppListViewController.h"
#import "DataHandler.h"

@interface AppListViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSArray *tableData;
@end

@implementation AppListViewController

-(void)configureTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

-(AppData*)appDataForIndexPath:(NSIndexPath *)indexPath {
   return [_tableData objectAtIndex:indexPath.row];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AppList";
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureTableView];
    _tableData = [[DataHandler sharedInstance]getAllAppDataTags];
    
    NSLog(@"%@", _tableData);
        
    DDLogVerbose(@"Verbose");
    DDLogDebug(@"Debug");
    DDLogInfo(@"Info");
    DDLogWarn(@"Warn");
    DDLogError(@"Error");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *testCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    AppData *app = [self appDataForIndexPath:indexPath];

    testCell.textLabel.text = app.displayName;
    return testCell;
}
- (NSInteger)tableView:(UITableView *)tableView  numberOfRowsInSection:(NSInteger)section {
    return [_tableData count];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AppData *app = [self appDataForIndexPath:indexPath];
    NSLog(@"Pressed '%@'", app.displayName);
}

@end
