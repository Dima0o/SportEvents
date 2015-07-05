//
//  MatchCell.h
//  SportEvents
//
//  Created by Джонни Диксон on 02.07.15.
//  Copyright (c) 2015 Lavskiy Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblTimeShow;
@property (strong, nonatomic) IBOutlet UILabel *lblOwnerTeam;
@property (strong, nonatomic) IBOutlet UILabel *lblGuestTeam;
@property (strong, nonatomic) IBOutlet UIImageView *imgOnwerTeam;
@property (strong, nonatomic) IBOutlet UIImageView *imgGuestTeam;
@property (strong, nonatomic) IBOutlet UILabel *lblOwnerCount;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;


@end
