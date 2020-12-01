//
//  JuRecordManage.m
//  MTIMKit_Example
//
//  Created by Juvid on 2019/6/4.
//  Copyright © 2019 美图. All rights reserved.
//

#import "JuAudioManage.h"
#import <AVFoundation/AVFoundation.h>
#import "JuVoiceConvert.h"
#import "JuAVAuthorizationManage.h"
@implementation JuAudioManage{
    AVAudioPlayer *ju_player;//播放
    AVAudioRecorder *ju_recorder;//录音
    NSURL *ju_recordedFile;//录音地址
    NSDate *ju_recordDate;
}
+ (instancetype) sharedInstance
{
    static JuAudioManage *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
/**开始录音**/
-(void)juStartRecordWithPath:(NSString *)path{
    _ju_voicePath=[[path stringByDeletingPathExtension] stringByAppendingPathExtension:@"wav"];
    [JuAVAuthorizationManage shCanRecordCompletion:^(AVAuthorizationStatus status) {
        if (status==AVAuthorizationStatusAuthorized) {
            [self juSetRecord];
        }else{
            [self juEndRecord];
        }
    }];
}
/**停止录音**/
-(void)juEndRecord{
    if (ju_recorder) {
        NSError *error=nil;
        @try {
            [ju_recorder stop];
            //[self toMp3];
        }
        @catch (NSException *exception) {
            NSLog(@"%@",[exception description]);
        }
        @finally {
            NSLog(@"%@",[error description]);
        }
        NSLog(@"录音结束，语音文件路径：%@", ju_recordedFile);
        _ju_voicePath=[self convertWAVToAMR:_ju_voicePath];
        ju_recorder=nil;
        
        NSTimeInterval time=[[NSDate date] timeIntervalSinceDate:ju_recordDate];
        ju_recordDate=nil;
        if (time<1) {
//            [MBProgressHUD juShowHUDText:@"说话时间太短了"];
            return;
        }
        CGFloat fileSize=([[NSFileManager defaultManager] attributesOfItemAtPath:_ju_voicePath error:nil].fileSize)/1024;
        
        NSMutableDictionary *ju_mediaM=[NSMutableDictionary dictionary];
        [ju_mediaM setValue:_ju_voicePath forKey:@"url"];
        [ju_mediaM setValue:[NSString stringWithFormat:@"%.1f",time] forKey:@"duration"];
        [ju_mediaM setValue:[NSString stringWithFormat:@"%.0f",fileSize] forKey:@"size"];
        _ju_mediaM=ju_mediaM;
    }
}
/**录音初始化**/
-(void)juSetRecord{
    if (!ju_recorder) {
        [ju_recorder stop];
    }
    ju_recordedFile = [NSURL fileURLWithPath:_ju_voicePath];

    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];

    if(session == nil)
        NSLog(@"Error creating session: %@", [sessionError description]);
    else
        [session setActive:YES error:nil];

    NSError *error;
    ju_recorder = [[AVAudioRecorder alloc] initWithURL:ju_recordedFile settings:[self shGetRecord] error:&error];
    if (ju_recorder&&error==nil) {
        [ju_recorder prepareToRecord];//创建文件，并准备录音
        ju_recorder.meteringEnabled = YES;//开启音量检测
        [ju_recorder record];
        ju_recordDate=[NSDate date];
    }

}

-(NSDictionary *)shGetRecord{
   /* NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] initWithCapacity:10];
    //    kAudioFormatMPEG4AAC
    //1 ID号
    [recordSettings setObject:[NSNumber numberWithInt: kAudioFormatMPEG4AAC] forKey: AVFormatIDKey];
    //2 采样率
    [recordSettings setObject:[NSNumber numberWithFloat:2000.0] forKey: AVSampleRateKey];
    //3 通道的数目
    [recordSettings setObject:[NSNumber numberWithInt:1]forKey:AVNumberOfChannelsKey];
    //4 采样位数  默认 16
    [recordSettings setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //5
    [recordSettings setObject:[NSNumber numberWithBool:NO]forKey:AVLinearPCMIsBigEndianKey];
    //6 采样信号是整数还是浮点数
    [recordSettings setObject:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];

    [recordSettings setObject:[NSNumber numberWithInt: AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    return recordSettings;*/
    NSDictionary *dicRecordSet=[[NSDictionary alloc] initWithObjectsAndKeys:
                             [NSNumber numberWithFloat: 11025],AVSampleRateKey, //采样率
                             [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                             [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,//采样位数 默认 16
                             [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,//通道的数目
                             [NSNumber numberWithInt: AVAudioQualityHigh],AVEncoderAudioQualityKey,
                             nil];
    return dicRecordSet;
}
-(double)juGetVoiceMeters{
    [ju_recorder updateMeters];//刷新音量数据
    //获取音量的平均值  [recorder averagePowerForChannel:0];
    double lowPassResults = pow(10, (0.05 * [ju_recorder peakPowerForChannel:0]));
 
    return lowPassResults;
}

- (NSString *)convertAMRToWAV:(NSString *)amrFilePath{
//
//    NSString *wavFilePath=[[amrFilePath stringByDeletingPathExtension] stringByAppendingPathExtension:@"mp3"];
//    BOOL isFileExists = [[NSFileManager defaultManager] fileExistsAtPath:amrFilePath];
//    if (isFileExists) {
//        [EMVoiceConverter amrToWav:amrFilePath wavSavePath:wavFilePath];
//        isFileExists = [[NSFileManager defaultManager] fileExistsAtPath:wavFilePath];
//        if (!isFileExists) {
//           return amrFilePath;
//        }
//    }
    return amrFilePath;
}

- (NSString *)convertWAVToAMR:(NSString *)wavFilePath{
    NSString *amrFilePath=[[wavFilePath stringByDeletingPathExtension] stringByAppendingPathExtension:@"mp3"];
    BOOL isFileExists = [[NSFileManager defaultManager] fileExistsAtPath:wavFilePath];
    if (isFileExists) {
        [JuVoiceConvert wavToMp3:wavFilePath mp3SavePath:amrFilePath];
        isFileExists = [[NSFileManager defaultManager] fileExistsAtPath:amrFilePath];
        if (!isFileExists) {
            return wavFilePath;
        }else{
            // Remove the wav
            NSFileManager *fm = [NSFileManager defaultManager];
            [fm removeItemAtPath:wavFilePath error:nil];
        }
    }
    return amrFilePath;
}

@end
