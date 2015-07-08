//
//  LeagueViewController.m
//  SportEvents
//
//  Created by Джонни Диксон on 05.07.15.
//  Copyright (c) 2015 Lavskiy Peter. All rights reserved.
//

#import "LeagueViewController.h"
#import "LeagueCell.h"
#import "WorkWithData.h"
#import "MatchsViewController.h"


@interface LeagueViewController ()

@property (nonatomic, strong) NSArray * arrayOfData;

@end

@implementation LeagueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.arrayOfData count];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [
    
    
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeagueCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.lblCountry.text = [[self.arrayOfData objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;
}

-(void) loadData
{
    WorkWithData * data = [WorkWithData new];
    
    self.arrayOfData = [data loadLeagueWithDate:[self getDateToday]];
}

-(NSString*) getDateToday
{
    NSDate * dateToday = [NSDate date];
    
    NSDateFormatter * dateFormat = [NSDateFormatter new];
    
    [dateFormat setDateFormat:@"yyyy/MM/dd"];
    
    NSString * date = [dateFormat stringFromDate:dateToday];
    
    return date;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MatchsViewController * match = [self.storyboard instantiateViewControllerWithIdentifier:@"Matches"];
    
    match.urlLeagueStatistic = [[self.arrayOfData objectAtIndex:indexPath.row] objectForKey:@"url"];
    
    [self presentViewController:match animated:YES completion:nil];
}



@end
