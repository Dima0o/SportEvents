//
//  MatchsViewController.m
//  SportEvents
//
//  Created by Джонни Диксон on 02.07.15.
//  Copyright (c) 2015 Lavskiy Peter. All rights reserved.
//

#import "MatchsViewController.h"
#import "TFHpple.h"
#import "MatchCell.h"
#import "WorkWithData.h"
#import "LeagueViewController.h"

@interface MatchsViewController ()

@property (nonatomic , strong) NSArray * dataArray;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;


@end

@implementation MatchsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSArray new];
    
    [self loadMatchData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MatchCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.lblOwnerTeam.text = [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"ownersName"];
    cell.lblGuestTeam.text = [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"guestsName"];
    cell.lblOwnerCount.text = [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"score"];
    cell.lblTimeShow.text = [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"startTime"];
    cell.lblStatus.text = [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"status"];
    
    return cell;
}

-(NSDate*) getDateToday
{
    NSDate * dateToday = [NSDate date];
        
    return dateToday;
}

-(void)loadMatchData {
    
    WorkWithData * work = [WorkWithData new];
    
    NSDate * date = [self getDateToday];
    
    self.dataArray = [work loadMatchDataWithURL:self.urlLeagueStatistic andWithDate:date];
    
    [self.matchTable reloadData];
}

- (IBAction)btnBack:(id)sender {
    
    LeagueViewController * league = [self.storyboard instantiateViewControllerWithIdentifier:@"League"];
    
    [self presentViewController:league animated:YES completion:nil];
    
}



@end
