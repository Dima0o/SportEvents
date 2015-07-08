//
//  LeagueViewController.h
//  SportEvents
//
//  Created by Джонни Диксон on 05.07.15.
//  Copyright (c) 2015 Lavskiy Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeagueViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
