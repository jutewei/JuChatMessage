//
//  UIColor+Hex.m
//  UIColorManager
//
//  Created by Juvid on 2019/11/7.
//  Copyright © 2019 Juvid. All rights reserved.
//

#import "UIColor+juDark.h"

@implementation UIColor (juDark)

+(UIColor *)mbColorWithHex:(NSInteger)rgbV alpha:(CGFloat)alpha{
    return[self mbColorWithRed:(rgbV&0xFF0000)>>16 green:(rgbV&0xFF00)>>8 blue:rgbV&0xFF alpha:alpha];;
}

+(UIColor *)mbColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

/// 16进制暗黑模式自动反转
+(UIColor *)colorDarkWithHex:(NSInteger)rgbV alpha:(CGFloat)alpha{
    return [self mbColorDarkWithRed:(rgbV&0xFF0000)>> 16 green:(rgbV&0xFF00)>> 8 blue:rgbV&0xFF alpha:alpha];
}


/// 十进制RBG颜色暗黑模式自动反转
+ (UIColor *)mbColorDarkWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha{
    return [self mbColorWithWhite:[UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha] darkColor:[UIColor colorWithRed:1-red/255.0 green:1-green/255.0 blue:1-blue/255.0 alpha:alpha]];
}

/// 白色-黑色 暗黑模式自动反转
+(UIColor *)mbColorDarkWithWhite:(CGFloat)hex alpha:(CGFloat)alpha{
    return [self mbColorWithWhite:[UIColor colorWithWhite:hex alpha:alpha] darkColor:[UIColor colorWithWhite:1-hex alpha:alpha]];
}

/// 暗黑模式颜色设置
+(UIColor *)mbColorWithWhite:(UIColor *)whiteColor darkColor:(UIColor *)darkColor{
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle== UIUserInterfaceStyleDark) {
                return darkColor;
            }
            else{
                return whiteColor;
            }
        }];
    } else {
        return whiteColor;
    }
}

+ (NSInteger)mbColorWithHexString:(NSString*)stringToConvert{
    if([stringToConvert hasPrefix:@"#"]){
        stringToConvert = [stringToConvert substringFromIndex:1];
    }
    NSScanner*scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if(![scanner scanHexInt:&hexNum]){
        return 0;
    }
    return hexNum;
}

///**纯色获取颜色值*/
//- (UIColor *)getDarkHexStringByColor{
//    NSArray *colors=[self mbHexStringByColor];
//    return mbDarkColorHexA([UIColor mbmbColorWithHexString:colors.firstObject],[colors.lastObject floatValue]);
//}

/**纯色判断*/
- (NSInteger)mbHexStringByColor:(CGFloat *)alpha{
    CGFloat r=0,g=0,b=0;
    [self getRed:&r green:&g blue:&b alpha:alpha];
    NSString *red   = [NSString stringWithFormat:@"%02x", (int)(r * 255)];
    NSString *green = [NSString stringWithFormat:@"%02x", (int)(g * 255)];
    NSString *blue  = [NSString stringWithFormat:@"%02x", (int)(b * 255)];
    return [UIColor mbColorWithHexString:[NSString stringWithFormat:@"0x%@%@%@", red, green, blue]];

}
/*颜色经典反转*/
- (UIColor *)mbGetDarkByColor{
    CGFloat r=0,g=0,b=0,a=0;
    [self getRed:&r green:&g blue:&b alpha:&a];
//    CGFloat max=r,min=g;
//    if (r<g) {
//        max=g;
//        min=r;
//    }
//    if (max<b) {
//        max=b;
//    }
//    if (min>b) {
//        min=b;
//    }
//    if (max-min<=0.05) {
        return [UIColor mbColorWithWhite:[UIColor colorWithRed:r green:g blue:b alpha:a] darkColor:[UIColor colorWithRed:1-r green:1-g blue:1-b alpha:a]];
//    }
//    return self;
}

@end
