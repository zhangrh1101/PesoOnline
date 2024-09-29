//
//  NSString+AttributeString.m
//
//  Created by mc on 2018/4/17.
//  Copyright © 2018年 ZRH. All rights reserved.
//

#import "NSString+AttributeString.h"

@implementation NSString (AttributeString)

/**
 小图标加文字
 */
+ (NSAttributedString *)attributeString:(NSString *)string font:(UIFont *)font textColor:(UIColor *)textColor imageName:(NSString *)imageName
                              imageSize:(CGSize)imageSize
{
    
    NSDictionary *attributes = @{NSFontAttributeName:font, NSForegroundColorAttributeName: textColor};
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] initWithString:string attributes:attributes];
    //添加图片
    UIImage *image = [UIImage imageNamed:imageName];
    NSMutableAttributedString *attachment = [NSMutableAttributedString attachmentStringWithContent:image
                                                                                       contentMode:UIViewContentModeCenter
                                                                                    attachmentSize:imageSize
                                                                                       alignToFont:font
                                                                                         alignment:YYTextVerticalAlignmentCenter];
    
    //将图片放在最前面
    [attributeText insertAttributedString:attachment atIndex:0];
    
    //添加图片的点击事件
    //    [attributeText setTextHighlightRange:[[attributeText string] rangeOfString:[attachment string]] color:[UIColor clearColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
    //        __weak typeof(self) weakSelf = self;
    //        weakSelf.isSelect = !weakSelf.isSelect;
    //        [weakSelf protocolIsSelect:self.isSelect];
    //    }];
    return attributeText;
}


/**
 回复评论名字拼接
 */
+ (NSAttributedString *)attributeString:(NSString *)firstStr firstColor:(UIColor *)firstColor secondStr:(NSString *)secondStr secondColor:(UIColor *)secondColor imageName:(NSString *)imageName imageSize:(CGSize)imageSize
{
    
    NSDictionary *firstAttributes = @{NSFontAttributeName:KFontSemiBold(16), NSForegroundColorAttributeName: firstColor};
    NSMutableAttributedString *firstAttributeText = [[NSMutableAttributedString alloc] initWithString:firstStr attributes:firstAttributes];
    
    NSDictionary *secondAttributes = @{NSFontAttributeName:KFontSemiBold(16), NSForegroundColorAttributeName: secondColor};
    NSMutableAttributedString *secondAttributeText = [[NSMutableAttributedString alloc] initWithString:secondStr attributes:secondAttributes];
    
    //添加图片
    UIImage *image = [UIImage imageNamed:imageName];
    NSMutableAttributedString *imageAttachment = [NSMutableAttributedString attachmentStringWithContent:image
                                                                                            contentMode:UIViewContentModeCenter
                                                                                         attachmentSize:imageSize
                                                                                            alignToFont:KFONT(16)
                                                                                              alignment:YYTextVerticalAlignmentCenter];
    //拼接
    [firstAttributeText appendAttributedString:imageAttachment];
    [firstAttributeText appendAttributedString:secondAttributeText];
    
    return firstAttributeText;
}



/**
 结尾多一个百分比
 */
+ (NSAttributedString *)attributeRate:(NSString *)rate RatePlus:(NSString *)rateplus {
    if (rate.length <= 0) {
        return nil;
    }
    NSString *rule = [NSString stringWithFormat:@"%.2f",rate.floatValue];
    NSString *rulePlus = [NSString stringWithFormat:@"+%.2f%%",rateplus.floatValue];
    NSMutableAttributedString *text = nil;
    if (rateplus.length > 0 && rateplus.floatValue > 0) {
        text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%% %@",rule,rulePlus]];
        [text setFont:KFONT(18) range:NSMakeRange(rule.length+1, rulePlus.length+1)]; //加上一个空格
    }else{
        text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%",rule]];
    }
    text.font = [UIFont systemFontOfSize:14];
    [text setFont:KFONT(40) range:NSMakeRange(0, rule.length)];
    [text setFont:KFONT(25) range:NSMakeRange(rule.length, 1)];
    
    [text setColor:ThemeColor];
    
    return text;
}


/**
 两部分带百分号%大小不一样的属性字
 */
+ (NSAttributedString *)attributeRates:(NSArray *)rates Fonts:(NSArray *)fonts colors:(NSArray *)colors{
    if (rates.count <= 0) {
        return nil;
    }
    
    NSMutableAttributedString *text = nil;
    NSString *rule = [NSString stringWithFormat:@"%.2f",[rates[0] floatValue]];
    
    if (rates.count >= 2 && fonts.count >= 2) {
        NSString *rulePlus = [NSString stringWithFormat:@"+%.2f%%",[rates[1] floatValue]];
        if (![HH_Utilities isBlankString:rates[1]] > 0 && [rates[1] floatValue] > 0) {
            text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%%@",rule,rulePlus]];
            
            NSInteger font = KFontSize([fonts[1] integerValue]);
            [text setFont:[UIFont boldSystemFontOfSize:font] range:NSMakeRange(rule.length+1, rulePlus.length)]; //加上一个空格
        }else{
            text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%",rule]];
        }
    }else{
        text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%",rule]];
    }
    NSInteger font = [fonts[0] integerValue];
    
    [text setFont:[UIFont boldSystemFontOfSize:KFontSize(font)] range:NSMakeRange(0, rule.length)];
    [text setFont:[UIFont boldSystemFontOfSize:KFontSize((font-10))] range:NSMakeRange(rule.length, 1)];       // +号大小
    
    [text setColor:colors[0]];
    
    return text;
}



/**
 需要改变颜色的文字
 */
+ (NSAttributedString *)attributeString:(NSString *)allText needText:(NSString *)needText font:(UIFont *)font color:(UIColor *_Nullable)color{
    
    if (needText.length <= 0) {
        needText = @"";
    }
    
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",allText]];
    if (color) {
        [attrText addAttribute:NSForegroundColorAttributeName value:color range:[allText rangeOfString:needText]];
    }
    if (font) {
        [attrText addAttribute:NSFontAttributeName value:font range:[allText rangeOfString:needText]];
        [attrText addAttribute:NSFontAttributeName value:font range:[allText rangeOfString:allText]];
    }
    return attrText;
}

/**
 需要改变颜色的文字数组
 */
+ (NSAttributedString *)attributeString:(NSString *)allText needTexts:(NSArray *)needTexts font:(UIFont *)font color:(UIColor *_Nullable)color {
    
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",allText]];
    if (color) {
        for (NSString *text in needTexts) {
            NSString *needText = text;
            if (needText.length <= 0) {
                needText = @"";
            }
            [attrText addAttribute:NSForegroundColorAttributeName value:color range:[allText rangeOfString:needText]];
        }
    }
    if (font) {
        for (NSString *text in needTexts) {
            NSString *needText = text;
            if (needText.length <= 0) {
                needText = @"";
            }
            [attrText addAttribute:NSFontAttributeName value:font range:[allText rangeOfString:needText]];
        }
        [attrText addAttribute:NSFontAttributeName value:font range:[allText rangeOfString:allText]];
    }
    return attrText;
}


/**
 关键文字加下划线
 */
+ (NSAttributedString *)attributeString:(NSString *)allText lineText:(NSString *)lineText font:(UIFont *)font {
    
    if (lineText.length <= 0) {
        lineText = @"";
        //        return nil;
    }
    
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", allText]];
    if (font) {
        [attrText setAttributes:
         @{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle),
           NSUnderlineColorAttributeName : [UIColor whiteColor],
           NSFontAttributeName : font}
                          range:[allText rangeOfString:lineText]];
    }
    return attrText;
}

/**
 关键文字加删除线
 */
+ (NSAttributedString *)attributeString:(NSString *)allText deletelineText:(NSString *)lineText font:(UIFont *)font {
    
    if (lineText.length <= 0) {
        lineText = @"";
        //        return nil;
    }
    
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", allText]];
    if (font) {
        [attrText setAttributes:
         @{
            NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),
            NSBaselineOffsetAttributeName : @(0),
            NSForegroundColorAttributeName : [UIColor lightGrayColor],
            NSFontAttributeName : font}
                          range:[allText rangeOfString:lineText]];
    }
    return attrText;
}



/**
 两部分大小不一样的属性字
 */
+ (NSAttributedString *)attributeStr1:(NSString *)str1 font1:(UIFont *)font1 str2:(NSString *)str2 font2:(UIFont *)font2
{
    NSString *allText = [str1 stringByAppendingString:str2];
    if (allText.length <= 0) {
        return nil;
    }
    
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",allText]];
    
    [attrText setFont:font1 range:[allText rangeOfString:str1]];
    [attrText setFont:font2 range:[allText rangeOfString:str2]];
    
    return attrText;
}


/**
 两部分大小不一样带颜色的属性字
 */
+ (NSAttributedString *)attributeStr1:(NSString *)str1 font1:(UIFont *)font1 color1:(UIColor *)color1 str2:(NSString *)str2 font2:(UIFont *)font2 color2:(UIColor *)color2
{
    NSString *allText = [str1 stringByAppendingString:str2];
    if (allText.length <= 0) {
        return nil;
    }
    
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",allText]];
    [attrText setFont:font1 range:[allText rangeOfString:str1]];
    [attrText setColor:color1 range:[allText rangeOfString:str1]];
    [attrText setFont:font2 range:[allText rangeOfString:str2]];
    [attrText setColor:color2 range:[allText rangeOfString:str2]];
    
    return attrText;
}


@end






