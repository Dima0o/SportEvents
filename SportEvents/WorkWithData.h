//
//  WorkWithData.h
//  SportEvents
//
//  Created by Джонни Диксон on 03.07.15.
//  Copyright (c) 2015 Lavskiy Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkWithData : NSObject

@property (nonatomic, strong) NSString * date;

-(NSMutableArray*)loadMatchDataWithDate;

@end
