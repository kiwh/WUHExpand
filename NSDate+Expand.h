//
//  NSDate+Expand.h
//  YiWuTong
//
//  Created by kinki on 15/7/28.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import <Foundation/Foundation.h>


#define YEAR @"year"
#define MONTH @"month"
#define DAY @"day"
#define HOUR @"hour"
#define MINUTE @"minute"
#define SECOND @"second"
#define WEAKDAY @"weakDay"

#define BeginDate @"beginDate"
#define EndDate @"endDate"

@interface NSDate(Common)

-(NSString*)dateByFormat:(NSString*)format;

@end

@interface NSDate(Calendar)

/**
 * 把date转换成各单位信息(年、月、日等)
 *
 *  @param unit 单位enum
 *
 *  @return key: year|month|day|hour|minute|second|weakDay
 */
-(NSDictionary*)transFormCalendarWithUnit:(NSCalendarUnit)unit;

/** 所有的unit */
+ (NSCalendarUnit)allCalendarUnit;

/** 转换时间字符串为自1970年来的秒数 */
+ (NSNumber*)transFormDateStringToDateFormSince1970:(NSString*)dateString;

/** 把获的星期数值转换成字符串 */
+(NSString*)transformWeakDayNumber:(NSNumber*)weakDayNum;

/** 获取农历时间 year | month | day */
-(NSDictionary*)getChineseCalendarInfo;

/** 获取date当前周的起始时间结束时间 format(格式@"MM.dd") beginDate | endDate */
-(NSDictionary *)getCurrentWeekBeginDayAndEndDayWithFormat:(NSString*)format;
/** 获取date当时月的起始时间和结束时间  */
-(NSDictionary *)getCurrentMonthBeginDayANdEndDayWithFormat:(NSString*)format;

/** 获取date当前月份的天数 */
-(NSInteger)getMonthOfDays;

/** 获取当前第一天 */
-(NSDate*)firstDayOfCurrentMonth;

/** 一周的天数 */
-(NSUInteger)weeklyOrdinality;

@end
