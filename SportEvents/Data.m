//
//  Data.m
//  SportEvents
//
//  Created by Джонни Диксон on 15.07.15.
//  Copyright (c) 2015 Lavskiy Peter. All rights reserved.
//

#import "Data.h"

@interface Data ()

@end

@implementation Data

-(void) loadLeaguesKeys{
    
    self.dictOfLeaguesKeys = [[NSDictionary alloc] initWithObjectsAndKeys:
                              @"ruscup",@"Россия. Кубок",
                              @"ucl",@"Лига чемпионов",
                              @"concacaf",@"Кубок КОНКАКАФ",
                              @"libertadores",@"Кубок Либертадорес",
                              @"fnl",@"Россия. ФНЛ",
                              @"japan",@"Япония. Высшая лига",
                              @"brazilD2",@"Бразилия. Д2",
                              @"egypt",@"Египет. Высшая лига",
                              @"china",@"Китай. Высшая лига",
                              @"peru",@"Перу. Высшая лига",
                              @"friend",@"Товарищеские матчи (клубы)",
                              @"thailand",@"Таиланд. Высшая лига",
                              @"thailandD2",@"Таиланд. Д2",nil];
    
}

@end
