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
{
    int count;
}

@property (nonatomic, strong) NSArray * arrayOfData;
@property (nonatomic, strong) NSMutableArray * array;
@property (nonatomic, strong) NSMutableDictionary * dictOfMatches;

@end

@implementation LeagueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = [NSMutableArray new];
    self.dictOfMatches = [NSMutableDictionary new];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.arrayOfData count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 64;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numberOfRows = 0;
    
    NSString * keyOfSection =[ NSString stringWithFormat:@"%i", section ];
    
    numberOfRows = [[self.dictOfMatches objectForKey:keyOfSection] count];
    
    return numberOfRows;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    HeaderLeague *header;
    
    if (header == nil) {
        [tableView registerClass:[HeaderLeague class] forHeaderFooterViewReuseIdentifier:@"Header"];
    }
    
    header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    
    [header makeHeader];
    
    header.btnLeague.tag = section;
    
    header.lblLeague.text = [[self.arrayOfData objectAtIndex:section] objectForKey:@"name"];
    
    [header.btnLeague addTarget:self action:@selector(toggleLeagueInSection:) forControlEvents:UIControlEventTouchUpInside];
    
    return header;
}



- (void) toggleLeagueInSection:(UIButton*)sender{
    
    WorkWithData * data = [WorkWithData new];
    
    NSArray * arrayOfMatchesInLeague = [NSArray new];
    
    int section = sender.tag;
    
    NSString * keyOfSection = [NSString stringWithFormat:@"%i",section];
    
    NSString * url = [[self.arrayOfData objectAtIndex:section] objectForKey:@"url"];
    
    arrayOfMatchesInLeague = [data loadMatchDataWithURL:url andWithDate:[self getDateToday]];
    
    [self.dictOfMatches setObject:arrayOfMatchesInLeague forKey:keyOfSection];
    
    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeagueCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSString * keyOfSection =[ NSString stringWithFormat:@"%i", indexPath.section ];
    
    NSArray * arrayOfMatches = [[NSArray alloc] initWithArray:[self.dictOfMatches objectForKey:keyOfSection]];
    
    cell.lblOwnerTeam.text = [[arrayOfMatches objectAtIndex:indexPath.row] objectForKey:@"ownersName"];
    cell.lblGuestTeam.text = [[arrayOfMatches objectAtIndex:indexPath.row] objectForKey:@"guestsName"];
    cell.lblScore.text = [[arrayOfMatches objectAtIndex:indexPath.row] objectForKey:@"score"];
    cell.lblTimeShow.text = [[arrayOfMatches objectAtIndex:indexPath.row] objectForKey:@"startTime"];
    cell.lblStatus.text = [[arrayOfMatches objectAtIndex:indexPath.row] objectForKey:@"status"];

    return cell;
}

-(void) loadData
{
    WorkWithData * data = [WorkWithData new];
    
    self.arrayOfData = [data loadLeagueWithDate:[self getDateToday]];
}

-(NSDate*) getDateToday
{
    NSDate * dateToday = [NSDate date];
    
    return dateToday;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MatchsViewController * match = [self.storyboard instantiateViewControllerWithIdentifier:@"Matches"];
    
    match.urlLeagueStatistic = [[self.arrayOfData objectAtIndex:indexPath.row] objectForKey:@"url"];
    
    [self presentViewController:match animated:YES completion:nil];
}




@end
