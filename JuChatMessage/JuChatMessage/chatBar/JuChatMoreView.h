//
//  JuChatMoreView.h
//  JuChatMessage
//
//  Created by Juvid on 2018/9/18.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JuChatBarDelegate;
@interface JuChatMoreView : UIView
@property (weak, nonatomic) id<JuChatBarDelegate> delegate;

-(void)juShowView:(UIView *)view;

+(CGFloat)mbHeight;

@end
