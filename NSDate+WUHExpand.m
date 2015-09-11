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
    [df setDateFormat:format?format:@"yyyy-MM-dd hh:mm:ss"];
    return [df stringFromDate:self];
}

@end

@implementation NSDate(Calendar)

-(NSDictionary *)GetCalendarInfoWithUnit:(NSCalendarUnit)unit
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:unit fromDate:self];
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    if (unit & NSCalendarUnitYear) {
        [dict setObject:@(dateComponent.year) forKey:YEAR];
    }
    if (unit & NSCalendarUnitMonth) {
        [dict setObject:@(dateComponent.month) forKey:MONTH];
    }
    if (unit & NSCalendarUnitDay) {
        [dict setObject:@(dateComponent.day) forKey:DAY];
    }
    if (unit & NSCalendarUnitHour) {
        [dict setObject:@(dateComponent.hour) forKey:HOUR];
    }
    if (unit & NSCalendarUnitMinute) {
        [dict setObject:@(dateComponent.minute) forKey:MINUTE];
    }
    if (unit & NSCalendarUnitSecond) {
        [dict setObject:@(dateComponent.second) forKey:SECOND];
    }
    if (unit & NSCalendarUnitWeekday) {
        [dict setObject:@(dateComponent.weekday) forKey:WEEKDAY];
    }
    return dict;
}

+(NSCalendarUnit)allCalendarUnit
{
    return NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday;
}


+(NSString*)transformWeakDayNumber:(NSNumber*)weakDayNum
{
    NSArray * result = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    return [result objectAtIndex:weakDayNum.integerValue-1];
}

-(NSDictionary*)GetChineseCalendarInfo{
    
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
    
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:self];
    
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    
    return @{YEAR:y_str,MONTH:m_str,DAY:d_str};
}

-(NSDictionary *)getCurrentWeekBeginDayAndEndDayWithFormat:(NSString*)format
{
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];// you can use your format.
    
    //Week Start Date
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    NSInteger dayofweek = [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];// this will give you current day of week
    
    [components setDay:([components day] - ((dayofweek) - 2))];// for beginning of the week.
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSString * dateString2Prev = [dateFormat stringFromDate:beginningOfWeek];
    //Week End Date
    
    NSCalendar *gregorianEnd = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *componentsEnd = [gregorianEnd components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    NSInteger Enddayofweek = [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];// this will give you current day of week
    
    [componentsEnd setDay:([componentsEnd day]+(7-Enddayofweek)+1)];// for end day of the week
    NSDate *EndOfWeek = [gregorianEnd dateFromComponents:componentsEnd];
    NSString * dateEndPrev = [dateFormat stringFromDate:EndOfWeek];
    return @{BeginDate:dateString2Prev,EndDate:dateEndPrev};
}

-(NSDictionary *)getCurrentMonthBeginDayAndEndDayWithFormat:(NSString *)format
{
        double interval = 0;
        NSDate *beginDate = nil;
        NSDate *endDate = nil;
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        [calendar setFirstWeekday:2];//设定周一为周首日
        BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:self];
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
    return @{BeginDate:beginString,EndDate:endString};
}

-(NSInteger)GetMonthOfDays
{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}

- (NSDate *)firstDayOfCurrentMonth
{
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    return startDate;
}

- (NSUInteger)weeklyOrdinality
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekday forDate:self];
}

@end
