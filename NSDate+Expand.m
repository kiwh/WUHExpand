//
//  NSDate+Expand.m
//  YiWuTong
//
//  Created by kinki on 15/7/28.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import "NSDate+Expand.h"

@implementation NSDate(Common)

-(NSString *)dateByFormat:(NSString *)format
{
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:format];
    return [df stringFromDate:self];
}

@end

@implementation NSDate(Calendar)

-(NSDictionary *)transFormCalendarWithUnit:(NSCalendarUnit)unit
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:unit fromDate:self];
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    if (unit & NSCalendarUnitYear) {
        [dict setObject:@(dateComponent.year) forKey:@"year"];
    }
    if (unit & NSCalendarUnitMonth) {
        [dict setObject:@(dateComponent.month) forKey:@"month"];
    }
    if (unit & NSCalendarUnitDay) {
        [dict setObject:@(dateComponent.day) forKey:@"day"];
    }
    if (unit & NSCalendarUnitHour) {
        [dict setObject:@(dateComponent.hour) forKey:@"hour"];
    }
    if (unit & NSCalendarUnitMinute) {
        [dict setObject:@(dateComponent.minute) forKey:@"minute"];
    }
    if (unit & NSCalendarUnitSecond) {
        [dict setObject:@(dateComponent.second) forKey:@"second"];
    }
    if (unit & NSCalendarUnitWeekday) {
        [dict setObject:@(dateComponent.weekday) forKey:@"weakDay"];
    }
    return dict;
}

+(NSCalendarUnit)allCalendarUnit
{
    return NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday;
}

+(NSNumber *)transFormDateStringToDateFormSince1970:(NSString *)dateString
{
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    NSDate * date = [df dateFromString:dateString];
    return @(date.timeIntervalSince1970);
}

+(NSString*)transformWeakDayNumber:(NSNumber*)weakDayNum
{
    NSArray * result = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    return [result objectAtIndex:weakDayNum.integerValue-1];
}

-(NSDictionary*)getChineseCalendarInfo{
    
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未",
                             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
                             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
    
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:self];
    
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    
    return @{@"year":y_str,@"month":m_str,@"day":d_str};
}

-(NSDictionary *)getCurrentWeekBeginDayAndEndDayWithFormat:(NSString*)format
{
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];// you can use your format.
    
    //Week Start Date
    
    NSCalendar *gregorian = [[NSCalendar alloc]        initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    
    NSInteger dayofweek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:self] weekday];// this will give you current day of week
    
    [components setDay:([components day] - ((dayofweek) - 2))];// for beginning of the week.
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSString * dateString2Prev = [dateFormat stringFromDate:beginningOfWeek];
    //Week End Date
    
    NSCalendar *gregorianEnd = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *componentsEnd = [gregorianEnd components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    
    NSInteger Enddayofweek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:self] weekday];// this will give you current day of week
    
    [componentsEnd setDay:([componentsEnd day]+(7-Enddayofweek)+1)];// for end day of the week
    NSDate *EndOfWeek = [gregorianEnd dateFromComponents:componentsEnd];
    NSString * dateEndPrev = [dateFormat stringFromDate:EndOfWeek];
    return @{@"beginDate":dateString2Prev,@"endDate":dateEndPrev};
}

-(NSDictionary *)getCurrentMonthBeginDayANdEndDayWithFormat:(NSString *)format
{
        double interval = 0;
        NSDate *beginDate = nil;
        NSDate *endDate = nil;
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        [calendar setFirstWeekday:2];//设定周一为周首日
        BOOL ok = [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:self];
        //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
        if (ok) {
            endDate = [beginDate dateByAddingTimeInterval:interval-1];
        }else {
            return nil;
        }
        NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
        [myDateFormatter setDateFormat:format];
        NSString *beginString = [myDateFormatter stringFromDate:beginDate];
        NSString *endString = [myDateFormatter stringFromDate:endDate];
    return @{@"beginDate":beginString,@"endDate":endString};
}

-(NSInteger)getMonthOfDays
{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}

- (NSDate *)firstDayOfCurrentMonth
{
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    return startDate;
}

- (NSUInteger)weeklyOrdinality
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:self];
}

@end
