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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    return cell;
}


@end
