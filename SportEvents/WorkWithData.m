//
//  WorkWithData.m
//  SportEvents
//
//  Created by Джонни Диксон on 03.07.15.
//  Copyright (c) 2015 Lavskiy Peter. All rights reserved.
//

#define matchId                         @"//tr[@data-match-id]"
#define ownersNameXpathQueryString      @"//td[@class='owner-td']//a[@class='player']"
#define guestsNameXpathQueryString      @"//td[@class='guests-td']//a[@class='player']"
#define ownersCountXpathQueryString     @"//span[@class='s-left']"
#define guestsCountXpathQueryString     @"//span[@class='s-right']"
#define matchStartTime                  @"//td[@class='alLeft gray-text']"

#define ownersNameEmptyXpathQueryString     @"//td[@class='owner-td']//div[@class='rel']"
#define guestsNameEmptyXpathQueryString     @"//td[@class='guests-td']//div[@class='rel']"


#import "WorkWithData.h"
#import "TFHpple.h"

@implementation WorkWithData


-(void) makeArrayWith:(NSMutableDictionary*) dict andWithNodes:(NSArray*) nodes andWithDataName:(NSString*) name{
    
    // пришлось ввести условие, чтобы выводить именно время, а не статус матча
    
    for (TFHppleElement *element in nodes) {
        
        if ([name  isEqual: @"startTime"]) {
            
            if ([element isEqual:[nodes firstObject]]) {
               
                NSString * value = [NSString new];
                value = [[element firstChild] content];
                [dict setValue:value forKey:name];
            }
            else{
                
                NSString * value = [NSString new];
                value = [[element firstChild] content];
                [dict setValue:value forKey:@"status"];
            }
        }
        else
        {
             NSString * value = [NSString new];
             value = [element content];
            [dict setValue:value forKey:name];

        }
        
    }
}

-(NSMutableArray*)loadMatchDataWithDate:(NSString *) date {
    
    // задаем адрес нашего ресурса
    
    NSString * stringURL = [NSString stringWithFormat:@"http://www.sports.ru/stat/football/center/all/%@.html",date];
        
    NSURL * dataURL = [NSURL URLWithString:stringURL];
    
    NSData * htmlData = [NSData dataWithContentsOfURL:dataURL];
    
    // 2
    TFHpple * sportParser = [TFHpple hppleWithHTMLData:htmlData];
    
    NSMutableArray * arrayOfData = [NSMutableArray new];
    
    NSMutableArray * arrayOfMatchesID = [NSMutableArray new];
    
    NSArray * arrayOfMatchIdNodes = [sportParser searchWithXPathQuery:matchId];
    
    for (TFHppleElement *element in arrayOfMatchIdNodes) {
        
        NSString * value = [NSString new];
        
        value = [element objectForKey:@"data-match-id"]; // вытаскиваем ID каждого матча
        
        [arrayOfMatchesID addObject:value]; // добавляем ID каждого матча в массив
    }
    
    for (NSString * idOfMatch in arrayOfMatchesID)
    {
        NSString * matchID = [NSString stringWithFormat:@"//tr[@data-match-id ='%@']",idOfMatch];
        
        NSArray * arrayOfOwnersNodes = [sportParser searchWithXPathQuery:[NSString stringWithFormat:@"%@%@",matchID,ownersNameXpathQueryString]];
        
        if ([arrayOfOwnersNodes count] == 0) {
            arrayOfOwnersNodes = [sportParser searchWithXPathQuery:[NSString stringWithFormat:@"%@%@",matchID,ownersNameEmptyXpathQueryString]];
        }
        NSArray * arrayOfGuestsNodes = [sportParser searchWithXPathQuery:[NSString stringWithFormat:@"%@%@",matchID,guestsNameXpathQueryString]];
        
        if ([arrayOfGuestsNodes count] == 0) {
            arrayOfGuestsNodes = [sportParser searchWithXPathQuery:[NSString stringWithFormat:@"%@%@",matchID,guestsNameEmptyXpathQueryString]];
        }
        NSArray * arrayOfOwnersCountNodes = [sportParser searchWithXPathQuery:[NSString stringWithFormat:@"%@%@",matchID,ownersCountXpathQueryString]];
        NSArray * arrayOFGuestsCountNodes = [sportParser searchWithXPathQuery:[NSString stringWithFormat:@"%@%@",matchID,guestsCountXpathQueryString]];
        NSArray * arrayOfStartTimeNodes = [sportParser searchWithXPathQuery:[NSString stringWithFormat:@"%@%@",matchID,matchStartTime]];
        
        NSMutableDictionary * dictOfMatches = [NSMutableDictionary new];
        
        [self makeArrayWith:dictOfMatches andWithNodes:arrayOfOwnersNodes andWithDataName:@"ownersName"];
        [self makeArrayWith:dictOfMatches andWithNodes:arrayOfGuestsNodes andWithDataName:@"guestsName"];
        [self makeArrayWith:dictOfMatches andWithNodes:arrayOfOwnersCountNodes andWithDataName:@"ownersCount"];
        [self makeArrayWith:dictOfMatches andWithNodes:arrayOFGuestsCountNodes andWithDataName:@"guestsCount"];
        [self makeArrayWith:dictOfMatches andWithNodes:arrayOfStartTimeNodes andWithDataName:@"startTime"];

        [arrayOfData addObject:dictOfMatches];
    }

    return arrayOfData;
   }


@end
