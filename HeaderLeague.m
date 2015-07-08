//
//  HeaderLeague.m
//  SportEvents
//
//  Created by Джонни Диксон on 08.07.15.
//  Copyright (c) 2015 Lavskiy Peter. All rights reserved.
//

#import "HeaderLeague.h"

@implementation HeaderLeague


- (void)makeHeader {
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    
    UIButton * chooseLeague = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    
    UIImageView * imgLeague = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    
    imgLeague.contentMode = UIViewContentModeScaleToFill;
    
    [imgLeague setImage:[UIImage imageNamed:@"concacaf.png"]];
    
    [view addSubview:imgLeague];
    [view addSubview:chooseLeague];
    
    [self addSubview:view];
}


@end
