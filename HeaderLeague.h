//
//  HeaderLeague.h
//  SportEvents
//
//  Created by Джонни Диксон on 08.07.15.
//  Copyright (c) 2015 Lavskiy Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderLeague : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel * lblLeague;
@property (nonatomic, strong) UIImageView * imgLeague;
@property (nonatomic, strong) UIButton * btnLeague;

- (void)makeHeader;

@end
