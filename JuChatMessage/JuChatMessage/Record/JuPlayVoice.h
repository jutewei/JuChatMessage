//
//  JuPlayVoice.h
//  MTSkinPublic
//
//  Created by Juvid on 2017/11/30.
//  Copyright © 2017年 Juvid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface JuPlayVoice : NSObject<AVAudioPlayerDelegate>
+ (instancetype) sharedInstance;
@property (nonatomic ,strong)AVAudioPlayer *ju_Player;//播放
@property (nonatomic ,readonly)NSString *sh_voiceFile;//播放路径
@property (nonatomic) BOOL isFaorbadePlay;///< 禁止播放
-(void)juPlayVoice:(NSString *)voiceFile
        completion:(void(^)(NSError *error))completon;
-(void)juPlayVoice:(NSString *)voiceFile isBundle:(BOOL)isBundle;
-(void)juStopPlay;
@end

