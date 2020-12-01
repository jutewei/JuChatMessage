//
//  JuFileManage.h
//  JuFileManage
//
//  Created by Juvid on 15/4/30.
//  Copyright (c) 2015年 Juvid(zhutianwei). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JuChatMediaFile : NSObject


// 数据库路径
+ (NSString *)juGetDBPath:(NSString *)fileName;

/**用户路径**/
+(NSString *)juGetUserPath:(NSString *)filePath fileName:(NSString *)fileName;
/**
 *  @author Juvid, 16-03-10 11:03
 *
 *  创建文件缓存路径
 *
 *  @param filePath 路径名
 *
 *  @return 路径
 */
+ (NSString *)juCreateCachesPath:(NSString *)filePath;

/**
 创建Documents文件路径

 @param filePath 文件路径
 @return 全路径
 */
//+(NSString *)shCreateDocumentsPath:(NSString *)filePath name:(NSString *)fileName;

+(NSString *)juGetDateName;

+ (NSString *)Get32coding:(int)numLength;


/**语音路径*/
+ (NSString *)juGetAudioPath:(nullable NSString *)fileName;

//创建存储图片的路径
+ (NSString *)juGetImagePath:(nullable NSString *)fileName;
/**存储图片**/
+(NSDictionary *)juSaveImage:(UIImage *)image;

@end
