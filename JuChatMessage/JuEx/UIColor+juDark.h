//
//  UIColor+Hex.h
//  UIColorManager
//
//  Created by Juvid on 2019/11/7.
//  Copyright © 2019 Juvid. All rights reserved.
//

#define MBColorOCHex(hex)       [UIColor mbColorWithHex:hex alpha:1.0]                ///< 正常颜色000000-ffffff
#define MBColorOCHexA(hex,a)    [UIColor mbColorWithHex:hex alpha:a]                  ///< 正常颜色000000-ffffff 0-1
#define MBColorOCRGBA(r,g,b,a)  [UIColor mbColorWithRed:r green:g blue:b alpha:a]   ///< 正常颜色0-255 0-255 0-255  0-1

//#define MBDarkColorHex(hex)         [UIColor mbColorDarkWithHex:hex alpha:1]              ///< 暗黑000000-ffffff
//#define MBDarkColorHexA(hex,a)      [UIColor mbColorDarkWithHex:hex alpha:a]              ///< 暗黑000000-ffffff 0-1
//
//#define MBDarkColorWhiteA(w,a)      [UIColor mbColorDarkWithWhite:w alpha:a]              ///< 暗黑 0-1 0-1
//#define MBDarkColorRBGA(r,g,b,a)    [UIColor mbColorDarkWithRed:r green:g blue:b alpha:a] ///< 暗黑 0-255 0-255 0-255  0-1
//
//#define MBDarkBothColor(wCol,dCol)     [UIColor mbColorWithWhite:wCol darkColor:dCol]              ///< 暗黑模式自定义颜色 color  color
//#define MBDarkBothColorHex(wHex,dHex)  [UIColor mbColorWithWhite:UINormalColorHex(wHex) darkColor:UINormalColorHex(dHex)]///< 暗黑模式自定义颜色  000000-ffffff  000000-ffffff

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (juDark)

/// 16进制颜色
/// @param rgbV 16进制数
/// @param alpha 透明度
+(UIColor *)mbColorWithHex:(NSInteger)rgbV alpha:(CGFloat)alpha;

/// 16进制暗黑模式自动反转
/// @param hex 16进制数
/// @param alpha 透明度
+ (UIColor *)colorDarkWithHex:(NSInteger)hex alpha:(CGFloat)alpha;

/// 白色-黑色 暗黑模式自动反转
/// @param wValue 白色值
/// @param alpha 透明度
+ (UIColor *)mbColorDarkWithWhite:(CGFloat)wValue alpha:(CGFloat)alpha;

/// 十进制RBG颜色暗黑模式自动反转
/// @param red 红色
/// @param green 绿色
/// @param blue 蓝色
/// @param alpha 透明度
+ (UIColor *)mbColorDarkWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;


/// 十进制RBG颜色
/// @param red 红色
/// @param green 绿色
/// @param blue 蓝色
/// @param alpha 透明度
+(UIColor *)mbColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

/// 暗黑模式颜色设置
/// @param whiteColor 白色
/// @param darkColor 黑色
+ (UIColor *)mbColorWithWhite:(UIColor *)whiteColor darkColor:(UIColor *)darkColor;


+ (NSInteger)mbColorWithHexString:(NSString*)stringToConvert;
//
///**颜色值返回十六进制*/
- (NSInteger)mbHexStringByColor:(CGFloat *)alpha;
///**纯色获取颜色值*/
//+ (UIColor *)getDarkHexStringByColor:(UIColor *)originColor;

/*颜色经典反转*/
- (UIColor *)mbGetDarkByColor;
@end

NS_ASSUME_NONNULL_END
