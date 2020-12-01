//
//  JuAudioDownManage.m
//  MTSkinPublic
//
//  Created by Juvid on 2019/6/10.
//  Copyright © 2019 Juvid. All rights reserved.
//

#import "JuAudioDownManage.h"
#import "AFURLSessionManager.h"
#import "JuChatMediaFile.h"
#import <CommonCrypto/CommonDigest.h>
//#import "JuSecurityManager.h"

@implementation JuAudioDownManage{
    NSMutableArray *mt_downURLs;
}

+ (instancetype) sharedInstance
{
    static JuAudioDownManage *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];

    });
    return sharedInstance;
}
-(NSMutableArray *)mt_downURLs{
    if (!mt_downURLs) {
        mt_downURLs=[NSMutableArray array];
    }
    return mt_downURLs;
}
-(void)mtDownDataURL:(NSString *)url handle:(JuAudioHandle)handle{
    if ([JuAudioDownManage mtGetExistFile:url]) {
       if(handle)handle([JuAudioDownManage mtGetExistFile:url]);
        return;
    }

    if ([mt_downURLs containsObject:url]) {
        return;
    }
    [mt_downURLs addObject:url];
    AFURLSessionManager *manager=[[AFURLSessionManager alloc]init];
    NSURLRequest *resquest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    //下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:resquest progress:^(NSProgress * _Nonnull downloadProgress) {
        //打印下下载进度
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
        NSString *filePath =[JuChatMediaFile juGetAudioPath:[JuAudioDownManage setMD5:url]];
        return [NSURL fileURLWithPath:filePath];

    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [self->mt_downURLs removeObject:url];
        //下载完成调用的方法
        if (handle) {
            handle(filePath.path);
        }
    }];
    //开始启动任务
    [task resume];
}
+(NSString *)mtGetExistFile:(NSString *)url{
    NSString *filePath =[JuChatMediaFile juGetAudioPath:[self setMD5:url]];
    if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
        return filePath;
    }
    return nil;
}
+ (NSString *)setMD5:(NSString *)str{
    if (!str) {
        return nil;
    }
    const char *cStr = [str UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), r);
    NSString *strFileName=[NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    return strFileName;
}
@end
