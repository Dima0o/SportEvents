//
//  TestViewController.m
//  SportEvents
//
//  Created by Джонни Диксон on 05.07.15.
//  Copyright (c) 2015 Lavskiy Peter. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@property (nonatomic , strong) NSArray * array;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = [[NSArray alloc] initWithObjects:@"one",@"two",@"three", nil];
    
    self.tableView = [[SLExpandableTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    return cell;
}

- (BOOL)tableView:(SLExpandableTableView *)tableView canExpandSection:(NSInteger)section
{
    if (section == 1) {
        return NO;
    }
    else
        return YES;
}

- (BOOL)tableView:(SLExpandableTableView *)tableView needsToDownloadDataForExpandableSection:(NSInteger)section
{
    return NO;
}



- (UITableViewCell<UIExpandingTableViewCell> *)tableView:(SLExpandableTableView *)tableView expandingCellForSection:(NSInteger)section
{
    UITableViewCell<UIExpandingTableViewCell> * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    return cell;
}

- (void)tableView:(SLExpandableTableView *)tableView downloadDataForExpandableSection:(NSInteger)section
{
    [tableView expandSection:section animated:YES];
    // download your data here
    // call [tableView expandSection:section animated:YES]; if download was successful
    // call [tableView cancelDownloadInSection:section]; if your download was NOT successful
}

- (void)tableView:(SLExpandableTableView *)tableView didExpandSection:(NSUInteger)section animated:(BOOL)animated
{
    NSLog(@"expand");
}

- (void)tableView:(SLExpandableTableView *)tableView didCollapseSection:(NSUInteger)section animated:(BOOL)animated
{
    //...
}


@end
