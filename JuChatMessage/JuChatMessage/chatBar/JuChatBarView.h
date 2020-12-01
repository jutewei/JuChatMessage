//
//  PFBChatInputView.h
//  TestIM
//
//  Created by Juvid on 16/7/25.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ChatBarHeight 60

typedef void(^juTextResult)(NSString *text);//下步操作后有跟新数据
@protocol JuChatBarDelegate;
@interface JuChatBarView : UIView<UITextViewDelegate>

@property (nonatomic,weak) UITableView *ju_tableView;

@property (readonly,nonatomic) UITextView *ju_TextView;///< 文本
@property (readonly,nonatomic) UIButton *ju_btnVoice;///< 语音
@property (readonly,nonatomic) UIButton *ju_btnRecord;///< 录音
@property (readonly,nonatomic) UIButton *ju_btnMedia;///< 多媒体
@property (readonly,nonatomic) UIButton *ju_btnEmoji;///< 表情
//@property (nonatomic,copy  ) juTextResult ju_TextResult;

@property (weak, nonatomic) id<JuChatBarDelegate> delegate;
-(void)juHidderAll;
-(void)juViewWillAppear;
-(void)juViewWillDisAppear;
@end
