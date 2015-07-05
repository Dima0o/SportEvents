//
//  WorkWithData.h
//  SportEvents
//
//  Created by Джонни Диксон on 03.07.15.
//  Copyright (c) 2015 Lavskiy Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkWithData : NSObject

-(NSMutableArray*)loadMatchDataWithURL:(NSString*) url andWithDate:(NSString*) date;
- (NSMutableArray*) loadLeagueWithDate:(NSString *) date;

@end
