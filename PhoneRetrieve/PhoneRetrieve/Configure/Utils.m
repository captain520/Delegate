//
//  Utils.m
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/13.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(NSString *)formatDateTime:(NSString *)tiemSpan dateFormart:(NSString *)formatString
{
    if (tiemSpan) {
        double timeInterval = [tiemSpan doubleValue];
        if (tiemSpan.length>10) {
            timeInterval = timeInterval/1000.0;
        }
        
        if (formatString == nil) {
            formatString = @"yyyy-MM-dd HH:mm:ss";
        }
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:formatString];
        return [formatter stringFromDate:date];
    }
    return @"";
}

NSString *cp_jsonString(id object) {
    
    if (nil == object) {
//        NSAssert(object!= nil, @"对象不能为空");
        
        return nil;
    }
    
    NSError *error = nil;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    if (error != nil) {
//        NSAssert(nil == error, error.description);
        return nil;
    }
    
    return  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

}

//  JSON字符串转化为字典
id cp_dictionaryWithJsonString(NSString *jsonString) {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return obj;
}

// format yyyy-MM-dd HH:mm:ss zzz
//- (NSString *)cp_date2String:(NSDate *)date format:(NSString *)format {
NSString *cp_date2String(NSDate *date, NSString *format) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    return [formatter stringFromDate:date];

}

#pragma mark 手机号
BOOL CheckPhone(NSString *phone)
{
    NSString *str = @"^(13|15|18|19|17|14)[0-9]{9}$";
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    return [regex evaluateWithObject:phone];
}

NSAttributedString *cp_commonRedAttr(NSString *head, NSString *tail) {
    
    NSMutableAttributedString *attr0 = [[NSMutableAttributedString alloc] initWithString:head attributes:nil];
    NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:tail attributes:@{NSForegroundColorAttributeName : CPERROR_COLOR}];
    [attr0 appendAttributedString:attr1];
    
    return attr0;
}

//将 &lt 等类似的字符转化为HTML中的“<”等
NSString *htmlEntityDecode(NSString *string) {
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    
    return string;
}

//将HTML字符串转化为NSAttributedString富文本字符串
NSAttributedString *attributedStringWithHTMLString(NSString *htmlString) {
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}

//  获取富文本的Frame
CGRect cp_getTextFrame(NSString *text ,CGFloat width, NSDictionary <NSString *, id> *options) {
    
    CGRect frame = [text boundingRectWithSize:CGSizeMake(width, 0)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:options
                                      context:nil];
    
    return frame;
}

//  获取富文本的Size
CGSize cp_getTextSize(NSString *text ,CGFloat width, NSDictionary <NSString *, id> *options) {
    return cp_getTextFrame(text, width, options).size;
}

//  获取富文本的高度
CGFloat cp_getTextHeight(NSString *text ,CGFloat width, NSDictionary <NSString *, id> *options) {
    return cp_getTextSize(text, width, options).height;
}


//  获取流程富文本
NSAttributedString *cp_flowAttributeContent0(NSString *titleValue, NSString *detailValue) {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10.0f;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSMutableAttributedString *attr0 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",titleValue]
                                                                              attributes:@{
                                                                                           NSFontAttributeName : CPFont_L,
                                                                                           NSForegroundColorAttributeName : C33
                                                                                           }];
    
    NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:detailValue
                                                                attributes:@{
                                                                             NSFontAttributeName : CPFont_M,
                                                                             NSForegroundColorAttributeName : C66
                                                                             }];
    
    [attr0 appendAttributedString:attr1];
    
    [attr0 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, titleValue.length + detailValue.length)];
    
    return attr0;
    
}

//  获取流程富文本
NSAttributedString *cp_flowAttributeContent1(NSString *titleValue) {
    
    NSMutableAttributedString *attr0 = [[NSMutableAttributedString alloc] initWithString:titleValue
                                                                              attributes:@{
                                                                                           NSFontAttributeName : CPFont_L,
                                                                                           NSForegroundColorAttributeName : C33
                                                                                           }];

    return attr0;
}

NSString *cp_int2String(NSInteger value) {
    return [NSString stringWithFormat:@"%ld",(long)value];
}

//  用空格替换nil
NSString *cp_noEmptyString(NSString *value) {
    return value ? value : @"";
}

//  将字符串a b 拼接组合
NSString *cp_jointString(NSString *a, NSString *b) {
    return [NSString stringWithFormat:@"%@%@",a,b];
}

////  将对象转为jsonstring
//
//NSString *cp_jsonString(id object) {
//
//    if (nil == object) {
//        //        NSAssert(object!= nil, @"对象不能为空");
//
//        return nil;
//    }
//
//    NSError *error = nil;
//
//    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
//    if (error != nil) {
//        //        NSAssert(nil == error, error.description);
//        return nil;
//    }
//
//    return  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//}
//

//  获取沙盒路径
NSString  *cp_documentFilePath(NSString *fileName) {
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    return [document stringByAppendingPathComponent:fileName];
}

@end
