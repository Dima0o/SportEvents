
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
#define CountXpathQueryString           @"//div[@class='score js-match-score']"

#define matchStartTime                  @"//td[@class='alLeft gray-text']"

#define ownersNameEmptyXpathQueryString     @"//td[@class='owner-td']//div[@class='rel']"
#define guestsNameEmptyXpathQueryString     @"//td[@class='guests-td']//div[@class='rel']"

#define leagueTitleXpathQueryString     @"//div[@class='light-gray-title  corners-3px']/a"
#define leagueDrawnTitleXpathQueryString     @"//div[@class='light-gray-title drawn-title corners-3px']/a"

#define matchURL @"http://www.sports.ru/stat/football/match/"

#import "WorkWithData.h"
#import "TFHpple.h"

@implementation WorkWithData


-(NSMutableArray*) makeArrayWithNodes:(NSArray*) nodes andValue:(NSString*) value {
    
    NSMutableArray * arrayOfData = [NSMutableArray new];
    
    if ([value  isEqual: @"name"]) {
        for (TFHppleElement *element in nodes) {
            
            NSString * value = [NSString new];
            value = [element content];
            [arrayOfData addObject:value];
            
        }
        
        }
    else if ([value  isEqual: @"time"]){
        
        for (TFHppleElement *element in nodes) {
            
            NSString * value = [NSString new];
            value = [[element firstChild] content];
            
            [arrayOfData addObject:value];
            
        }


    }
    
        return arrayOfData;
}

-(TFHpple*) makeTFHppleWithURL:(NSString*) url{
    
    NSURL * dataURL = [NSURL URLWithString:url];
    
    NSData * htmlData = [NSData dataWithContentsOfURL:dataURL];
    
    TFHpple * sportParser = [TFHpple hppleWithHTMLData:htmlData];
    
    return sportParser;
}

-(NSMutableArray*)loadMatchDataWithURL:(NSString*) url andWithDate:(NSString*) date{
    
    date = [date lowercaseString];
    date = [date substringToIndex:[date length]-1];
    
    NSString * stringURL = [NSString stringWithFormat:@"http://www.sports.ru%@/",url];
        
    NSURL * dataURL = [NSURL URLWithString:stringURL];
    
    
    NSData * htmlData = [NSData dataWithContentsOfURL:dataURL];

    
    TFHpple * sportParser = [TFHpple hppleWithHTMLData:htmlData];
    
    NSMutableArray * arrayOfData = [NSMutableArray new];
    NSMutableArray * arrayOfOwners = [NSMutableArray new];
    NSMutableArray * arrayOfGuests = [NSMutableArray new];
    NSMutableArray * arrayOfTime = [NSMutableArray new];

    NSArray * arrayOfOwnersNodes = [sportParser searchWithXPathQuery:ownersNameXpathQueryString];
    NSArray * arrayOfGuestsNodes = [sportParser searchWithXPathQuery:guestsNameXpathQueryString];
    NSArray * arrayOfTimeNodes = [sportParser searchWithXPathQuery:matchStartTime];
    
    
    NSArray * arrayOfCountNodes = [sportParser searchWithXPathQuery:CountXpathQueryString];

    arrayOfOwners = [self makeArrayWithNodes:arrayOfOwnersNodes andValue:@"name"];
    
    arrayOfGuests = [self makeArrayWithNodes:arrayOfGuestsNodes andValue:@"name"];
    
    arrayOfTime = [self makeArrayWithNodes:arrayOfTimeNodes andValue:@"time"];
    
    for (int i = 0; i < [arrayOfOwners count]; i++) {
        
        if ([[arrayOfTime objectAtIndex:i] containsString:date])
        {
            NSMutableDictionary * dictOfMathces = [NSMutableDictionary new];
            
            [dictOfMathces setObject:[arrayOfOwners objectAtIndex:i] forKey:@"ownersName"];
            [dictOfMathces setObject:[arrayOfGuests objectAtIndex:i] forKey:@"guestsName"];
            [dictOfMathces setObject:[arrayOfTime objectAtIndex:i]  forKey:@"asd"];
            
            [arrayOfData addObject:dictOfMathces];
        }
        
        
    }
    

    return arrayOfData;
   }

- (NSMutableArray*) loadLeagueWithDate:(NSString *) date{
    
    NSMutableArray * arrayOfData = [NSMutableArray new];
    
    NSString * stringURL = [NSString stringWithFormat:@"http://www.sports.ru/stat/football/center/all/%@.html",date];
    
    NSURL * dataURL = [NSURL URLWithString:stringURL];
    
    NSData * htmlData = [NSData dataWithContentsOfURL:dataURL];
    
    TFHpple * sportParser = [TFHpple hppleWithHTMLData:htmlData];
    
    NSArray * arrayOfLeaguesNodes = [sportParser searchWithXPathQuery:leagueTitleXpathQueryString];
    
    [self makeDataArrayWith:arrayOfData andWithNodes:arrayOfLeaguesNodes];
    
    NSArray * arrayOfLeaguesNodesDrawn = [sportParser searchWithXPathQuery:leagueDrawnTitleXpathQueryString];
    
    [self makeDataArrayWith:arrayOfData andWithNodes:arrayOfLeaguesNodesDrawn];
    
    return arrayOfData;
}

- (void) makeDataArrayWith:(NSMutableArray *)array andWithNodes:(NSArray*) arrayofNodes
{
    
    for (TFHppleElement *element in arrayofNodes) {
        
        NSMutableDictionary * dictOfMatches = [NSMutableDictionary new];
        
        NSString * value = [[element firstChild] content]; // вытаскиваем название лиги
        
        NSString * url = [element objectForKey:@"href"];
        
        [dictOfMatches setObject:value forKey:@"name"];
        
        [dictOfMatches setObject:url forKey:@"url"];
        
        [array addObject:dictOfMatches];
    }

}

@end
