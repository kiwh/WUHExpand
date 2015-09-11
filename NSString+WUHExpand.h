//
//  NSString+WUHExpand.h
//  WUHExpandDemo
//
//  Created by kinki on 15/9/11.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString(Boolean)

/** 是否含有汉字 */
-(BOOL)hasChineseWord;

/** 是否只含有数字和英文字母 */
-(BOOL)isNumberAndEnglishWord;

/** 是否只含有数字和英文字母并且在min到max长度之间 */
-(BOOL)isNumberAndEnglishWordWithMinLength:(NSInteger)minLength maxLength:(NSInteger)maxLength;

@end

@interface NSString(Expand)
/** 首字母小写 */
- (NSString *)lowercaseFirstCharacter;
/** 首字母大写 */
- (NSString *)uppercaseFirstCharacter;

/** 是否为空字符串 */
- (BOOL)isEmpty;

/** 去除字符串的空格和空行 */
- (NSString *)trim;
/** 修整特殊的空格 */
- (NSString *)trimTheExtraSpaces;

/** 替换HTML代码 */
- (NSString *)escapeHTML;

- (NSString *)stringByDecodingXMLEntities;

/** md5 */
- (NSString *)md5;
- (NSString *)md5ForUTF16;

/** 根据字体测算宽高度  */
- (CGFloat)fontSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (NSMutableArray *)tokenizationStringByNSStringEnumerationOptions:(NSStringEnumerationOptions)opts;

/** 分析句中句子的语言 */
- (NSString *)languageForString;
/** 分析句中单词的词性 */
- (NSMutableArray *)analyseTextOfSentences;
@end