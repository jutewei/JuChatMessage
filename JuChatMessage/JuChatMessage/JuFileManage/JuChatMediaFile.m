//
//  JuFileManage.m
//  JuFileManage
//
//  Created by Juvid on 15/4/30.
//  Copyright (c) 2015年 Juvid(zhutianwei). All rights reserved.
//

#import "JuChatMediaFile.h"
#import "UIImage+mbCropping.h"
//#import "MTIMClientManage.h"

#define user_cache @"JUMBUser"
#define  CACHES_IMGE @"image"
#define  CACHES_Audio @"audio"

#define  IMGE_TYPE @".jpg"
#define  VOICE_TYPE @".wav"

@implementation JuChatMediaFile

/**语音路径*/
+ (NSString *)juGetAudioPath:(NSString *)fileName {
    return [self mtGetFilePath:fileName mediaPath:CACHES_Audio];
}

#pragma mark 创建存储图片的路径
+ (NSString *)juGetImagePath:(NSString *)fileName{
    return [self mtGetFilePath:fileName mediaPath:CACHES_IMGE];
}

// 数据库路径
+ (NSString *)juGetDBPath:(NSString *)fileName{
    return [self juGetUserPath:@"db" fileName:[NSString stringWithFormat:@"%@.db",fileName]];
}
+(NSString *)mtGetFilePath:(NSString *)fileName mediaPath:(NSString *)path{
   NSString *strCafPath= [self juGetUserPath:[NSString stringWithFormat:@"media/%@/%@",@"version",path] fileName:fileName];
    if (!fileName) {
        return  [strCafPath stringByAppendingPathComponent:[self juGetDateName]];
    }
    return strCafPath;
}

/**用户路径**/
+(NSString *)juGetUserPath:(NSString *)filePath fileName:(NSString *)fileName{
    NSString *path=[self juCreateDocumentsPath:[NSString stringWithFormat:@"%@/%@",user_cache,filePath]];
    if (fileName) {
        return [path stringByAppendingPathComponent:fileName];
    }
    return path;
}

#pragma mark 创建Library下caches文件存储的路径
+ (NSString *)juCreateCachesPath:(NSString *)filePath {
//    NSLibraryDirectory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
    if (paths.count) {
        return [self juCreatFilePath:[paths objectAtIndex:0] filePath:filePath];
    }
    return nil;
}
#pragma mark 创建Documents下caches文件存储的路径
+(NSString *)juCreateDocumentsPath:(NSString *)filePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if (paths.count) {
        if (filePath) {
            return [self juCreatFilePath:[paths objectAtIndex:0] filePath:filePath];
        }
    }
    return nil;
}

//+(NSString *)shCreateDocumentsPath:(NSString *)filePath name:(NSString *)fileName{
//
//    NSString *path=[self shCreateDocumentsPath:filePath];
//    if (fileName) {
//        return [path stringByAppendingPathComponent:fileName];
//    }
//    return nil;
//}

/**
 创建文件路径
 */
+(NSString *)juCreatFilePath:(NSString *)path filePath:(NSString *)filePath{
    NSArray *segments = [NSArray arrayWithObjects:path,filePath, nil];

    NSString *imgfilePath =  [NSString pathWithComponents:segments];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    if (![fileManager fileExistsAtPath:imgfilePath]) {
        [fileManager createDirectoryAtPath:imgfilePath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    return imgfilePath;
}

+(NSString *)juGetDateName{
    NSDate *date = [NSDate date];
    NSDateFormatter *datematter=[[NSDateFormatter alloc]init ];
    [datematter setDateFormat:@"YYYYMMddHHmmssSSS"];
    NSString *dateStr=[datematter stringFromDate:date];
    return [NSString stringWithFormat:@"%@%@",dateStr,[self Get32coding:16]];
}

+ (NSString *)Get32coding:(int)numLength{
    int kNumber = numLength;

    NSString *sourceStr = @"0123456789abcdefghijklmnopqrstuvwxyz";//ABCDEFGHIJKLMNOPQRSTUVWXYZ
    NSMutableString *resultStr = [[NSMutableString alloc] init];

    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}





+(NSDictionary *)juSaveImage:(UIImage *)image{
    if (image) {
//        大图路径
        NSString *imagePath = [JuChatMediaFile juGetImagePath:nil];
        NSData *data=[UIImage juSetImageData:image];
        CGFloat lenght=data.length/1024;
        [[NSFileManager defaultManager] createFileAtPath:imagePath
                                                contents:data
                                              attributes:nil];

//小图路径
        UIImage *thumb=[image juSetTailoring:CGSizeMake([UIScreen mainScreen].scale * 100, [UIScreen mainScreen].scale * 100)];
        NSString *thumbPath = [NSString stringWithFormat:@"%@_mini",imagePath];
        [[NSFileManager defaultManager] createFileAtPath:thumbPath
                                                contents:UIImageJPEGRepresentation(thumb, 0.5)
                                              attributes:nil];



        NSMutableDictionary *mediaInfo=[NSMutableDictionary dictionary];
        [mediaInfo setValue:imagePath forKey:@"url"];
//        [mediaInfo setValue:[UIImage juSetImageData:image] forKey:@"data"];
        [mediaInfo setValue:[NSString stringWithFormat:@"%.0f",image.size.height] forKey:@"height"];
        [mediaInfo setValue:[NSString stringWithFormat:@"%.0f",image.size.width] forKey:@"width"];
        [mediaInfo setValue:[NSString stringWithFormat:@"%.0f",lenght] forKey:@"size"];
        return mediaInfo;
    }
    return nil;
}
@end
