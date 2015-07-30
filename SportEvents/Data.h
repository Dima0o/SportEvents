//
//  Data.h
//  SportEvents
//
//  Created by Джонни Диксон on 15.07.15.
//  Copyright (c) 2015 Lavskiy Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject

@property (nonatomic,strong) NSDictionary * dictOfLeaguesKeys;

-(void) loadLeaguesKeys;

@end
