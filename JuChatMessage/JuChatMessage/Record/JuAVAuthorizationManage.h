//
//  PFBAVAuthorizationManage.h
//  MTSkinPublic
//
//  Created by Juvid on 2018/9/4.
//  Copyright © 2018年 Juvid(zhutianwei). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>
@interface JuAVAuthorizationManage : NSObject
+(void)shCanRecordCompletion:(void(^)(AVAuthorizationStatus status))completion;
/**
 恢复其他app播放
 */
+(void)shRePlayOthersAppVoice;
@end
