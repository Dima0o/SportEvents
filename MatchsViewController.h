//
//  MatchsViewController.h
//  SportEvents
//
//  Created by Джонни Диксон on 02.07.15.
//  Copyright (c) 2015 Lavskiy Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *matchTable;
@property (strong, nonatomic) NSString * urlLeagueStatistic;

@end
