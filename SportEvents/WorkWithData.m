
//
//  WorkWithData.m
//  SportEvents
//
//  Created by Джонни Диксон on 03.07.15.
//  Copyright (c) 2015 Lavskiy Peter. All rights reserved.
//

#define matchId                             @"//tr[@data-match-id]"
#define ownersNameXpathQueryString          @"//td[@class='owner-td']//div[@class='rel']"
#define guestsNameXpathQueryString          @"//td[@class='guests-td']//div[@class='rel']"
#define scoreXpathQueryString               @"//td[@class='score-td']/a"

#define matchStartTime                      @"//td[@class='alLeft gray-text']"
#define matchTimeIfTag                      @"//td[@class='name-td alLeft']"

#define leagueTitleXpathQueryString          @"//div[@class='light-gray-title  corners-3px']/a"
#define leagueDrawnTitleXpathQueryString     @"//div[@class='light-gray-title drawn-title corners-3px']/a"


#define yearsXpathQueryStringIfTag           @"//a[@class='option']"
#define yearsXpathQueryString                @"//select[@class='floatR']//option"

#define matchURL                             @"http://www.sports.ru/stat/football/match/"

#import "WorkWithData.h"
#import "TFHpple.h"

@interface WorkWithData ()

@property BOOL isTag; // условие определяющее какую страницу парсить calendar  или статистика страны

@end

@implementation WorkWithData

#pragma mark Load Matches


-(NSMutableArray*)loadMatchDataWithURL:(NSString*) url andWithDate:(NSDate*) date{
    
    self.isTag = NO;
    
    NSString * dateString;
    
    NSString * stringURL = [NSString new];
    
    
    stringURL = [self checkURL:url date:date];
    
    NSURL * dataURL = [NSURL URLWithString:stringURL];
    
    NSData * htmlData = [NSData dataWithContentsOfURL:dataURL];
    
    TFHpple * sportParser = [TFHpple hppleWithHTMLData:htmlData];
    
    NSMutableArray * arrayOfData = [NSMutableArray new];
    NSMutableArray * arrayOfOwners = [NSMutableArray new];
    NSMutableArray * arrayOfGuests = [NSMutableArray new];
    NSMutableArray * arrayOfTime = [NSMutableArray new];
    NSMutableArray * arrayOfScore = [NSMutableArray new];
    
    NSArray * arrayOfTimeNodes = [NSArray new];
    NSArray * arrayOfOwnersNodes = [NSArray new];
    NSArray * arrayOfGuestsNodes = [NSArray new];
    
    arrayOfOwnersNodes = [sportParser searchWithXPathQuery:ownersNameXpathQueryString];
    
    arrayOfGuestsNodes = [sportParser searchWithXPathQuery:guestsNameXpathQueryString];
   
    if (self.isTag) {
        
        arrayOfTimeNodes = [sportParser searchWithXPathQuery:matchTimeIfTag];
    }
    else{
        
        arrayOfTimeNodes = [sportParser searchWithXPathQuery:matchStartTime];
    }
   
    NSArray * arrayOfScoreNodes = [sportParser searchWithXPathQuery:scoreXpathQueryString];

    arrayOfOwners = [self makeArrayWithNodes:arrayOfOwnersNodes andValue:@"name"];
    
    arrayOfGuests = [self makeArrayWithNodes:arrayOfGuestsNodes andValue:@"name"];
    
    arrayOfScore = [self makeArrayWithNodes:arrayOfScoreNodes andValue:@"score"];
    
    arrayOfTime = [self makeArrayWithNodes:arrayOfTimeNodes andValue:@"time"];
    
    if (!self.isTag) {
        
        NSDateFormatter * dateFormat = [NSDateFormatter new];
        
        [dateFormat setDateFormat:@"d LLLL"];
        
        [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"RU"]];
        
        dateString = [dateFormat stringFromDate:date];
        
        dateString = [dateString substringToIndex:[dateString length]-1];
        
        dateString = [dateString lowercaseString];
        
    }
    else
    {
        NSDateFormatter * dateFormat = [NSDateFormatter new];
        
        [dateFormat setDateFormat:@"dd.MM.YYYY"];
        
        [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"RU"]]; ;
        
        dateString = [dateFormat stringFromDate:date];

    }
        
    
    for (int i = 0; i < [arrayOfOwners count]; i++) {
        
        if ([[arrayOfTime objectAtIndex:i] containsString:dateString])
        {
            NSMutableDictionary * dictOfMathces = [NSMutableDictionary new];
            
            [dictOfMathces setObject:[arrayOfOwners objectAtIndex:i] forKey:@"ownersName"];
            [dictOfMathces setObject:[arrayOfGuests objectAtIndex:i] forKey:@"guestsName"];
            [dictOfMathces setObject:[arrayOfScore objectAtIndex:i] forKey:@"score"];
            [dictOfMathces setObject:[arrayOfTime objectAtIndex:i]  forKey:@"time"];
            
            [arrayOfData addObject:dictOfMathces];
        }
    }

    return arrayOfData;
   }

#pragma mark Load Leagues

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

#pragma mark Support Methods

-(NSMutableArray*) makeArrayWithNodes:(NSArray*) nodes andValue:(NSString*) value {
    
    NSMutableArray * arrayOfData = [NSMutableArray new];
    
    if ([value  isEqual: @"time"]){
        
        for (TFHppleElement *element in nodes) {
            
            if (self.isTag)
            {
                if ([nodes indexOfObject:element] != 0)
                {
                    NSString * value = [NSString new];
                    value = [[element firstTextChild] content];
                    
                    [arrayOfData addObject:value];
                    
                }
            }
            else{
                
                if ([nodes indexOfObject:element]%2 == 0)
                {
                    NSString * value = [NSString new];
                    value = [[element firstTextChild] content];
                    
                    [arrayOfData addObject:value];
                    
                }
                
            }
            
        }
    }
    else
    {
        for (TFHppleElement *element in nodes) {
            
            NSString * value = [NSString new];
            value = [element content];
            [arrayOfData addObject:value];
            
        }
    }
    
    return arrayOfData;
}

-(NSMutableArray*) yearFromUrl:(NSString*)url {
    
    NSMutableArray * arrayOfURLS = [NSMutableArray new];
    
    NSURL * dataURL = [NSURL new];
    
    if (self.isTag) {
        
        dataURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@calendar",url]];
        
    }
    else{
        
        dataURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.sports.ru%@/",url]];
    }
    
    NSData * htmlData = [NSData dataWithContentsOfURL:dataURL];
    
    TFHpple * sportParser = [TFHpple hppleWithHTMLData:htmlData];
    
    NSArray * yearsArrayNodes = [NSArray new];
    
    if (self.isTag) {
        yearsArrayNodes = [sportParser searchWithXPathQuery:yearsXpathQueryStringIfTag];
    }
    else
        yearsArrayNodes = [sportParser searchWithXPathQuery:yearsXpathQueryString];
    
    for (TFHppleElement *element in yearsArrayNodes) {
        
        NSMutableDictionary * dictURLs = [NSMutableDictionary new];
        
        NSString * year = [[element firstTextChild] content];
        
        NSString * url = [element objectForKey:@"value"];
        
        [dictURLs setObject:year forKey:@"year"];
        [dictURLs setObject:url forKey:@"yearID"];
        
        [arrayOfURLS addObject:dictURLs];
        
    }
    return arrayOfURLS;
}

-(NSString*) getYearFromDate:(NSDate*) date
{
    NSDateFormatter * dateFormat = [NSDateFormatter new];
    
    [dateFormat setDateFormat:@"yyyy"];
    
    NSString * year = [dateFormat stringFromDate:date];
    
    return year;
}

- (NSString *)checkURL:(NSString *)url date:(NSDate *)date {
    NSString *stringURL;
    if ([url containsString:@"tags"] || [url containsString:@"euro"] || [url containsString:@"international-friendlies"]
        || [url containsString:@"club-friendlies"]) {
        
        self.isTag = YES;
        
        NSDateFormatter * dateFormat = [NSDateFormatter new];
        
        NSArray * arrayOfYears = [self yearFromUrl:url];
        
        [dateFormat setDateFormat:@"M"];
        
        [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"RU"]]; ;
        
        NSString * monthURL = [dateFormat stringFromDate:date];
        
        NSString * year = [self getYearFromDate:date];
        
        for (NSDictionary * dictOfURLs in arrayOfYears) {
            if ([[dictOfURLs objectForKey:@"year"] containsString:year]) {
                
                stringURL = [NSString stringWithFormat:@"%@calendar/?s=%@&m=%@",url,[dictOfURLs objectForKey:@"yearID"],monthURL];
                
            }
        }
    }
    else
    {
        NSArray * arrayOfYears = [self yearFromUrl:url];
        
        for (NSDictionary* dictOfSeasons in arrayOfYears) {
            
            if ([[dictOfSeasons objectForKey:@"year"] containsString:[self getYearFromDate:date]]) {
                stringURL = [NSString stringWithFormat:@"http://www.sports.ru%@/%@",url,[dictOfSeasons objectForKey:@"yearID"]];
            }
        }
        
    }
    return stringURL;
}

@end
