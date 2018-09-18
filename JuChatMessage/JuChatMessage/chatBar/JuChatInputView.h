//
//  PFBChatInputView.h
//  TestIM
//
//  Created by Juvid on 16/7/25.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^juTextResult)(NSString *text);//下步操作后有跟新数据
@interface JuChatInputView : UIView<UITextViewDelegate>
@property (readonly,nonatomic) UITextView *ju_TextView;///< 文本
@property (readonly,nonatomic) UIButton *ju_btnVoice;///< 语音
@property (readonly,nonatomic) UIButton *ju_btnRecord;///< 录音
@property (readonly,nonatomic) UIButton *ju_btnMedia;///< 多媒体
@property (nonatomic,copy  ) juTextResult ju_TextResult;
-(void)juViewWillAppear;
-(void)juViewWillDisAppear;
@end