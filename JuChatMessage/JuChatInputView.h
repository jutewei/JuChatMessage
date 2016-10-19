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
@property (strong,nonatomic) UITextView *ju_TextView;
@property (nonatomic,copy  ) juTextResult ju_TextResult;
-(void)juViewWillAppear;
-(void)juViewWillDisAppear;
@end
