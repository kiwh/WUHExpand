//
//  NSString+WUHExpand.m
//  WUHExpandDemo
//
//  Created by kinki on 15/9/11.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import "NSString+WUHExpand.h"

@implementation NSString(Boolean)

-(BOOL)hasChineseWord
{
    for(int i=0; i< [self length];i++){
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

-(BOOL)isNumberAndEnglishWord
{
    NSString * regex = @"[A-Za-z0-9]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return ![pred evaluateWithObject:self];
}

-(BOOL)isNumberAndEnglishWordWithMinLength:(NSInteger)minLength maxLength:(NSInteger)maxLength
{
    NSString * regex = [NSString stringWithFormat:@"^[A-Za-z0-9]{%zi,%zi}$",minLength,maxLength];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return ![predicate evaluateWithObject:self];
}

@end

@implementation NSString(Expand)

#pragma mark - 转换string大小写

- (NSString *)lowercaseFirstCharacter {
    NSRange range = NSMakeRange(0,1);
    NSString *lowerFirstCharacter = [[self substringToIndex:1] lowercaseString];
    return [self stringByReplacingCharactersInRange:range withString:lowerFirstCharacter];
}

- (NSString *)uppercaseFirstCharacter {
    NSRange range = NSMakeRange(0,1);
    NSString *upperFirstCharacter = [[self substringToIndex:1] uppercaseString];
    return [self stringByReplacingCharactersInRange:range withString:upperFirstCharacter];
}

#pragma mark - trim string

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimTheExtraSpaces{
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
    
    NSArray *parts = [self componentsSeparatedByCharactersInSet:whitespaces];
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
    return [filteredArray componentsJoinedByString:@" "];
}

//是否是空字符串
- (BOOL)isEmpty {
    NSCharacterSet *charSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [self stringByTrimmingCharactersInSet:charSet];
    return [trimmed isEqualToString:@""];
}

//替换HTML代码
- (NSString *)escapeHTML {
    NSMutableString *result = [[NSMutableString alloc] initWithString:self];
    [result replaceOccurrencesOfString:@"&" withString:@"&amp;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"<" withString:@"&lt;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@">" withString:@"&gt;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"\"" withString:@"&quot;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"'" withString:@"&#39;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    return result;
}

// implementation by Daniel Dickison and Walty
// http://stackoverflow.com/questions/1105169/html-character-decoding-in-objective-c-cocoa-touch
- (NSString *)stringByDecodingXMLEntities {
    NSUInteger myLength = [self length];
    NSUInteger ampIndex = [self rangeOfString:@"&" options:NSLiteralSearch].location;
    
    // Short-circuit if there are no ampersands.
    if (ampIndex == NSNotFound) {
        return self;
    }
    // Make result string with some extra capacity.
    NSMutableString *result = [NSMutableString stringWithCapacity:(myLength * 1.25)];
    
    // First iteration doesn't need to scan to & since we did that already, but for code simplicity's sake we'll do it again with the scanner.
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    
    NSCharacterSet *boundaryCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@" \t\n\r;"];
    
    do {
        // Scan up to the next entity or the end of the string.
        NSString *nonEntityString;
        if ([scanner scanUpToString:@"&" intoString:&nonEntityString]) {
            [result appendString:nonEntityString];
        }
        if ([scanner isAtEnd]) {
            goto finish;
        }
        // Scan either a HTML or numeric character entity reference.
        if ([scanner scanString:@"&amp;" intoString:NULL])
            [result appendString:@"&"];
        else if ([scanner scanString:@"&apos;" intoString:NULL])
            [result appendString:@"'"];
        else if ([scanner scanString:@"&quot;" intoString:NULL])
            [result appendString:@"\""];
        else if ([scanner scanString:@"&lt;" intoString:NULL])
            [result appendString:@"<"];
        else if ([scanner scanString:@"&gt;" intoString:NULL])
            [result appendString:@">"];
        else if ([scanner scanString:@"&#" intoString:NULL]) {
            BOOL gotNumber;
            unsigned charCode;
            NSString *xForHex = @"";
            
            // Is it hex or decimal?
            if ([scanner scanString:@"x" intoString:&xForHex]) {
                gotNumber = [scanner scanHexInt:&charCode];
            }
            else {
                gotNumber = [scanner scanInt:(int*)&charCode];
            }
            
            if (gotNumber) {
                [result appendFormat:@"%C", (unichar)charCode];
                [scanner scanString:@";" intoString:NULL];
            }
            else {
                NSString *unknownEntity = @"";
                [scanner scanUpToCharactersFromSet:boundaryCharacterSet intoString:&unknownEntity];
                [result appendFormat:@"&#%@%@", xForHex, unknownEntity];
                NSLog(@"Expected numeric character entity but got &#%@%@;", xForHex, unknownEntity);
            }
        }
        else {
            NSString *amp;
            [scanner scanString:@"&" intoString:&amp];      //an isolated & symbol
            [result appendString:amp];
        }
    }
    while (![scanner isAtEnd]);
    
finish:
    return result;
}

//普通的MD5加密
- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

//UTF16的MD5加密
- (NSString *)md5ForUTF16{
    NSData *temp = [self dataUsingEncoding:NSUTF16LittleEndianStringEncoding];
    
    UInt8 *cStr = (UInt8 *)[temp bytes];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)[temp length], result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

//自适应文字大小
- (CGFloat)fontSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    CGFloat fontSize = [font pointSize];
    CGFloat height = [self boundingRectWithSize:CGSizeMake(size.width, FLT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;
    UIFont *newFont = font;
    
    //Reduce font size while too large, break if no height (empty string)
    while (height > size.height && height != 0) {
        fontSize--;
        newFont = [UIFont fontWithName:font.fontName size:fontSize];
        height = [self boundingRectWithSize:CGSizeMake(size.width, FLT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;
    };
    return fontSize;
}

#pragma mark - tokeniztion string

/**
 根据设定参数进行字符串拆分
 NSStringEnumerationByComposedCharacterSequences,根据字母
 NSStringEnumerationByWords，根据单词
 NSStringEnumerationBySentences，根据句子
 这3个比较常用
 */
- (NSMutableArray *)tokenizationStringByNSStringEnumerationOptions:(NSStringEnumerationOptions)opts{
    NSMutableArray *splitArray = [NSMutableArray array];
    NSRange range = NSMakeRange(0, [self length]);
    [self enumerateSubstringsInRange:range options:opts usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [splitArray addObject:substring];
    }];
    
    return splitArray;
}

//detect string language，对于句子相对准确，单词不是很准确
- (NSString *)languageForString{
    return (__bridge NSString *)CFStringTokenizerCopyBestStringLanguage((CFStringRef)self, CFRangeMake(0, MIN(self.length,400)));
}

//分析句中单词的词性
- (NSMutableArray *)analyseTextOfSentences{
    NSMutableArray *analyseArray = [NSMutableArray array];
    
    // This range contains the entire string, since we want to parse it completely
    NSRange stringRange = NSMakeRange(0, self.length);
    
    //第一种方式
    NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:[NSArray arrayWithObject:NSLinguisticTagSchemeNameTypeOrLexicalClass] options:0];
    [tagger setString:self];
    [tagger enumerateTagsInRange:stringRange
                          scheme:NSLinguisticTagSchemeNameTypeOrLexicalClass
                         options:NSLinguisticTaggerOmitWhitespace | NSLinguisticTaggerOmitPunctuation
                      usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
                          [analyseArray addObject:@{@"word":[self substringWithRange:tokenRange],@"tag" : tag}];
                      }];
    
    // 第二种方式
    //    NSArray *language = [NSArray arrayWithObjects:@"en",@"de",@"fr",@"ko",@"ja",nil];
    //    NSDictionary* languageMap = [NSDictionary dictionaryWithObject:language forKey:@"Latn"];
    //
    //    [self enumerateLinguisticTagsInRange:stringRange
    //                                  scheme:NSLinguisticTagSchemeNameTypeOrLexicalClass
    //                                 options:NSLinguisticTaggerOmitWhitespace | NSLinguisticTaggerOmitPunctuation
    //                             orthography:[NSOrthography orthographyWithDominantScript:@"Latn" languageMap:languageMap]
    //                              usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
    //                                  [analyseArray addObject:@{@"word":[self substringWithRange:tokenRange],@"tag" : tag}];
    //                            }];
    
    return analyseArray;
}


@end