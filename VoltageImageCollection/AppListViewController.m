//
//  AppListViewController.m
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import "AppListViewController.h"
#import "NSMutableDictionary+AppData.h"

@interface AppListViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation AppListViewController

-(void)configureTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AppList";
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureTableView];
    
    NSMutableDictionary *app1 = [NSMutableDictionary newAppWithName:@"Kissed By The Baddest Bidder"];
    NSLog(@"%@", app1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *testCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    testCell.textLabel.text = [NSString stringWithFormat:@"APP %ld", (long)indexPath.row];
    //TODO
    return testCell;
}
- (NSInteger)tableView:(UITableView *)tableView  numberOfRowsInSection:(NSInteger)section {
    //TODO
    return 2;
}

#pragma mark - UITableViewDelegate
//TODO

@end
