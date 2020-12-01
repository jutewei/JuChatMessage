//
//  JuDeviceManage.m
//  MTIMKit_Example
//
//  Created by Juvid on 2019/6/5.
//  Copyright © 2019 美图. All rights reserved.
//

#import "JuDeviceManage.h"

#import "JuAudioManage.h"
void EMSystemSoundFinishedPlayingCallback(SystemSoundID sound_id, void* user_data)
{
    AudioServicesDisposeSystemSoundID(sound_id);
}
@implementation JuDeviceManage{
    NSDate *mt_lastPlaySoundDate;
}
+ (instancetype) sharedInstance
{
    static JuDeviceManage *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (void)asyncPlayingWithPath:(NSString *)aFilePath
                  completion:(void(^)(NSError *error))completon{

    NSString *wavFilePath=[[JuAudioManage sharedInstance] convertAMRToWAV:aFilePath];
    if ([JuPlayVoice sharedInstance].ju_Player.isPlaying) {
        [[JuPlayVoice sharedInstance] juStopPlay];
        if ([[JuPlayVoice sharedInstance].sh_voiceFile isEqual:wavFilePath]) {///< 相同路径停止播放
            return;
        }
    }

    if (wavFilePath) {
        [[JuPlayVoice sharedInstance]juPlayVoice:wavFilePath completion:^(NSError *error) {
            NSLog(@"%@",error);
            if (completon) {
                completon(error);
            }
        }];
    }else{
        completon([NSError errorWithDomain:@"语音文件损坏"
                                      code:JUErrorFileTypeConvertionFailure
                                  userInfo:nil]);
    }

}
- (void)mtStopPlay{
    [[JuPlayVoice sharedInstance]juStopPlay];
}

- (SystemSoundID)playNewMessageSound
{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:mt_lastPlaySoundDate];
    if (timeInterval < 3) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        return 1007;
    }
    // Path for the audio file
//    NSURL *bundlePath = [[NSBundle mainBundle] URLForResource:@"EaseUIResource" withExtension:@"bundle"];
//    NSURL *audioPath = [[NSBundle bundleWithURL:bundlePath] URLForResource:@"in" withExtension:@"caf"];
//
//    SystemSoundID soundID;
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(audioPath), &soundID);
    // Register the sound completion callback.
    AudioServicesAddSystemSoundCompletion(1007,
                                          NULL, // uses the main run loop
                                          NULL, // uses kCFRunLoopDefaultMode
                                          EMSystemSoundFinishedPlayingCallback, // the name of our custom callback function
                                          NULL // for user data, but we don't need to do that in this case, so we just pass NULL
                                          );

    AudioServicesPlaySystemSound(1007);
    mt_lastPlaySoundDate = [NSDate date];
    return 1007;
}
- (void)playVibration
{
    // Register the sound completion callback.
    AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate,
                                          NULL, // uses the main run loop
                                          NULL, // uses kCFRunLoopDefaultMode
                                          EMSystemSoundFinishedPlayingCallback, // the name of our custom callback function
                                          NULL // for user data, but we don't need to do that in this case, so we just pass NULL
                                          );

    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
@end
