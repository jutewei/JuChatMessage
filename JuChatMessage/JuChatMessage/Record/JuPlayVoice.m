//
//  JuPlayVoice.m
//  MTSkinPublic
//
//  Created by Juvid on 2017/11/30.
//  Copyright © 2017年 Juvid. All rights reserved.
//

#import "JuPlayVoice.h"
#import "JuAVAuthorizationManage.h"
#import "JuDeviceErrorCode.h"
@interface JuPlayVoice (){
    NSString *_sh_voiceFile;
    NSDate *sh_playDate;
    void (^playFinish)(NSError *error);
}

@end

@implementation JuPlayVoice
@synthesize ju_Player,sh_voiceFile=_sh_voiceFile;

+ (instancetype) sharedInstance
{
    static JuPlayVoice *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
-(id)init{
    self=[super init];
    if (self) {
//         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(juEnterBack:) name:UIApplicationWillResignActiveNotification object:nil];
        //添加监听
    }
    return self;
}
//处理监听触发事件
-(void)sensorStateChange:(NSNotificationCenter *)notification{
    //如果此时手机靠近面部放在耳朵旁，那么声音将通过听筒输出，并将屏幕变暗（省电啊）
    if ([[UIDevice currentDevice] proximityState] == YES){
        NSLog(@"Device is close to user");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    }
    else
    {
        NSLog(@"Device is not close to user");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
}
-(void)juPlayVoice:(NSString *)voiceFile
        completion:(void(^)(NSError *error))completon{

    playFinish=completon;
    _sh_voiceFile=voiceFile;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayback error:&sessionError];
    if(session == nil){
        NSLog(@"初始化失败");
        return;
    }
    else
        [session setActive:YES error:nil];

    NSURL *voiceUrl=[NSURL URLWithString:voiceFile];
    
    NSError *error;
    ju_Player=[[AVAudioPlayer alloc]initWithContentsOfURL:voiceUrl  error:&error];
    ju_Player.delegate=self;
    ju_Player.volume=1.0;
    //准备播放
    //    if(ju_Player!=nil&&error==nil) [ju_Player prepareToPlay];
    //播放
    if(error==nil&&[ju_Player play]){
        NSLog(@"正在播放语音");
        [self shStartNotification];
    }else{
        if (playFinish) {
            playFinish(error);
        }
        NSLog(@"文件损坏、播放失败");
    }

}
-(void)juPlayVoice:(NSString *)voiceFile isBundle:(BOOL)Bundle{
    NSTimeInterval spaceTime= [[NSDate date] timeIntervalSinceDate:sh_playDate];
    if ([ju_Player isPlaying]||_isFaorbadePlay||([_sh_voiceFile isEqual:voiceFile]&&spaceTime<2.1)) {
        return;
    }
    if (Bundle) {
        voiceFile = [[NSBundle mainBundle]pathForResource:_sh_voiceFile ofType:@"mp3"];
//        NSData *data=[[NSData alloc]initWithContentsOfURL:voiceUrl];
//        ju_Player=[[AVAudioPlayer alloc]initWithData:data error:&error];
//        voiceUrl=[[NSBundle mainBundle] URLForResource:voiceFile withExtension:@"mp3"];
    }
    [self juPlayVoice:voiceFile completion:nil];
}
-(void)setIsFaorbadePlay:(BOOL)isFaorbadePlay{
    _isFaorbadePlay=isFaorbadePlay;
    if (_isFaorbadePlay) {
         ju_Player.delegate=nil;
        [ju_Player stop];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [self juStopPlay:nil];
    NSLog(@"语音播放完成");
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
    [self juStopPlay:error];
    NSLog(@"语音播放失败");
}
//播放器遇到中断的时候（如来电），调用该方法
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
    [self juStopPlay:nil];
    NSLog(@"语音播放停止");
}
//中断事件结束后调用下面的方法
-(void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags{
    [self juStopPlay:nil];
    //可以什么都不做，让用户决定是继续播放还是暂停
}
-(void)dealloc{

    ju_Player.delegate=nil;
    [ju_Player stop];
    ju_Player=nil;
    [JuAVAuthorizationManage shRePlayOthersAppVoice];
}
-(void)juStopPlay:(NSError *)error{
    if (playFinish) {
        playFinish(error);
    }
    [self juStopPlay];
}
-(void)juStopPlay{
    [self shStopNotification];
    sh_playDate=[NSDate date];
    if (ju_Player) {
        ju_Player.delegate=nil;
        [ju_Player stop];
        ju_Player=nil;
    }
    playFinish=nil;
}
-(void)shStopNotification{
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIDeviceProximityStateDidChangeNotification" object:nil];
}
-(void)shStartNotification{
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sensorStateChange:)
                                                 name:@"UIDeviceProximityStateDidChangeNotification"
                                               object:nil];
}

@end
