//
//  PFBAVAuthorizationManage.m
//  MTSkinPublic
//
//  Created by Juvid on 2018/9/4.
//  Copyright © 2018年 Juvid(zhutianwei). All rights reserved.
//

#import "JuAVAuthorizationManage.h"
//#import "JuAlertView+actiont.h"
@implementation JuAVAuthorizationManage

+(void)shCanRecordCompletion:(void(^)(AVAuthorizationStatus status))completion
{
    AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (videoAuthStatus == AVAuthorizationStatusNotDetermined) {
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!granted) {
//                    [JuAlertView shAlertTitle:@"无法使用麦克风" message:@"请在iPhone的“设置-隐私-麦克风”中允许访问麦克风"];
                }
            });
        }];
        if (completion) {
            completion(videoAuthStatus);
        }
    }
    else if(videoAuthStatus == AVAuthorizationStatusRestricted || videoAuthStatus == AVAuthorizationStatusDenied) {
//        [JuAlertView shAlertTitle:@"无法使用麦克风" message:@"请在iPhone的“设置-隐私-麦克风”中允许访问麦克风"];
        completion(videoAuthStatus);
    }
    else{
        completion(videoAuthStatus);
    }
}
/*
 *首先，我们需要先向设备注册激活声音打断AudioSessionSetActive(YES);,当然我们也可以通过 [AVAudioSession sharedInstance].otherAudioPlaying;这个方法来判断还有没有其它业务的声音在播放。 当我们播放完视频后，需要恢复其它业务或App的声音，这时我们可以在退到后台的事件中调用如下方法:
 */
+(void)shRePlayOthersAppVoice{
    NSError *error =nil;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    // [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    BOOL isSuccess = [session setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];

    if (!isSuccess) {
        NSLog(@"__%@",error);
    }else{
        NSLog(@"成功了");
    }
}
@end
