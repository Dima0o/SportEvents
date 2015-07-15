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
#import "HeaderLeague.h"

@interface LeagueViewController ()

@property (nonatomic, strong) NSArray * arrayOfData;
@property (nonatomic, strong) NSMutableArray * array;
@property (nonatomic, strong) NSMutableDictionary * dictOfMatches;
@property (nonatomic, strong) NSMutableArray * arrayOfExpandedSections;

@end

@implementation LeagueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = [NSMutableArray new];
    self.dictOfMatches = [NSMutableDictionary new];
    self.arrayOfExpandedSections = [NSMutableArray new];
    
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeagueCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSString * keyOfSection =[ NSString stringWithFormat:@"%i", indexPath.section ];
    
    NSArray * arrayOfMatches = [[NSArray alloc] initWithArray:[self.dictOfMatches objectForKey:keyOfSection]];
    
    
        
        cell.alpha = 1;
        cell.lblOwnerTeam.text = [[arrayOfMatches objectAtIndex:indexPath.row] objectForKey:@"ownersName"];
        cell.lblGuestTeam.text = [[arrayOfMatches objectAtIndex:indexPath.row] objectForKey:@"guestsName"];
        cell.lblScore.text = [[arrayOfMatches objectAtIndex:indexPath.row] objectForKey:@"score"];
        cell.lblTimeShow.text = [[arrayOfMatches objectAtIndex:indexPath.row] objectForKey:@"startTime"];
        cell.lblStatus.text = [[arrayOfMatches objectAtIndex:indexPath.row] objectForKey:@"status"];



    return cell;
}

#pragma mark UITableViewDeleagate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}


#pragma LoadMethods

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

#pragma mark ExpandCells


- (void)expandLeague:(NSString *)keyOfSection section:(int)section {
    [self.arrayOfExpandedSections addObject:keyOfSection];
    
    WorkWithData * data = [WorkWithData new];
    
    NSArray * arrayOfMatchesInLeague = [NSArray new];
    
    
    NSString * url = [[self.arrayOfData objectAtIndex:section] objectForKey:@"url"];
    
    arrayOfMatchesInLeague = [data loadMatchDataWithURL:url andWithDate:[self getDateToday]];
    
    [self.dictOfMatches setObject:arrayOfMatchesInLeague forKey:keyOfSection];
    
    [self.tableView beginUpdates];
    
    for (int i = 0; i < [[self.dictOfMatches objectForKey:keyOfSection] count]; i++) {
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:section]] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [self.tableView endUpdates];
}

- (void)closeLeague:(NSString *)keyOfSection section:(int)section {
    
    [self.arrayOfExpandedSections removeObject:keyOfSection];
    
    [self.dictOfMatches removeObjectForKey:keyOfSection];
    
    [self.tableView beginUpdates];
    
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:section]] withRowAnimation:UITableViewRowAnimationFade];
    
    
    [self.tableView endUpdates];
}

- (void) toggleLeagueInSection:(UIButton*)sender{
    
    int section = sender.tag;
    
    NSString * keyOfSection = [NSString stringWithFormat:@"%i",section];
    
    if (![self.arrayOfExpandedSections containsObject:keyOfSection]) {
        
        [self expandLeague:keyOfSection section:section];
        
    }
    else
    {
        
        [self closeLeague:keyOfSection section:section];
    }
    
   
    
}


@end
