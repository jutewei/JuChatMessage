//
//  JuRecordView.h
//  JuChatMessage
//
//  Created by Juvid on 2018/9/18.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JuRecordView : UIView
@property (nonatomic) NSArray *ju_AnimationImages;
@property (nonatomic) NSString *ju_upCancelText;
@property (nonatomic) NSString *ju_loosenCancelText;

/**录音最长时间*/
@property (assign)  CGFloat ju_voiceMaxTime;
/**开始录音**/
-(void)juStartRecord:(UIView *)supView hanlde:(dispatch_block_t)hanlde;

/**停止录音**/
-(void)juStopRecord;

/**取消录音**/
-(void)juSetVoiceImage:(BOOL)isReadyCancle;

@end
