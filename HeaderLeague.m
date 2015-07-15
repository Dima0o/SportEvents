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
    
    if (self.superview.subviews == nil) {
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
        
        self.btnLeague = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
        
        self.lblLeague = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 220, 64)];
        
        self.imgLeague = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
        
        CALayer *bottomBorder = [CALayer layer];
        
        bottomBorder.frame = CGRectMake(0.0f, 63.0f, view.frame.size.width, 0.5f);
        
        bottomBorder.backgroundColor = [UIColor blackColor].CGColor;
        
        bottomBorder.shadowColor = [UIColor blackColor].CGColor;
        bottomBorder.shadowOffset = CGSizeMake(0.0f, 1.0f);
        bottomBorder.shadowOpacity = 0.5f;

        
        self.imgLeague.contentMode = UIViewContentModeScaleToFill;
        
        self.lblLeague.textAlignment = NSTextAlignmentCenter;
        
        self.lblLeague.lineBreakMode = NSLineBreakByWordWrapping;
        
        self.lblLeague.numberOfLines = 0;
        
        [self.lblLeague setFont:[UIFont systemFontOfSize:10]];
        
        [self.imgLeague setImage:[UIImage imageNamed:@"concacaf.png"]];
        
        [view addSubview:self.imgLeague];
        [view addSubview:self.btnLeague];
        [view addSubview:self.lblLeague];
        [view.layer addSublayer:bottomBorder];
        
        [self addSubview:view];

    }
    
    }


@end
