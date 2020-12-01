//
//  JuDeviceManage.h
//  MTIMKit_Example
//
//  Created by Juvid on 2019/6/5.
//  Copyright © 2019 美图. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JuDeviceErrorCode.h"
#import "JuPlayVoice.h"
NS_ASSUME_NONNULL_BEGIN

@interface JuDeviceManage : NSObject
+ (instancetype) sharedInstance;
- (void)asyncPlayingWithPath:(NSString *)aFilePath
                  completion:(void(^)(NSError *error))completon;

- (void)mtStopPlay;

- (SystemSoundID)playNewMessageSound;

- (void)playVibration;
@end

NS_ASSUME_NONNULL_END
