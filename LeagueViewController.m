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
#import "HeaderLeague.h"

@interface LeagueViewController ()

@property (nonatomic, strong) NSArray * arrayOfData;

@end

@implementation LeagueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[HeaderLeague class] forHeaderFooterViewReuseIdentifier:@"Header"];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 64;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    HeaderLeague * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    
    [header makeHeader];
    
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
