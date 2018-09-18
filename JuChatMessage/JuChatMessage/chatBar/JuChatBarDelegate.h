//
//  JuChatBarDelegate.h
//  JuChatMessage
//
//  Created by Juvid on 2018/9/18.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JuChatBarDelegate <NSObject>

@optional
- (void)juDidSendText:(NSString *)text;

- (void)juDidSendText:(NSString *)text withExt:(NSDictionary*)ext;

- (BOOL)juDidInputAtInLocation:(NSUInteger)location;

- (BOOL)juDidDeleteCharacterFromLocation:(NSUInteger)location;

- (void)juDidSendFace:(NSString *)faceLocalPath;

- (void)juDidSendVoice:(NSString *)voicePath;


- (void)juDidStartRecordingVoiceAction:(UIView *)recordView;

- (void)juDidCancelRecordingVoiceAction:(UIView *)recordView;

- (void)juDidFinishRecoingVoiceAction:(UIView *)recordView;

- (void)juDidDragOutsideAction:(UIView *)recordView;

- (void)juDidDragInsideAction:(UIView *)recordView;

@end
