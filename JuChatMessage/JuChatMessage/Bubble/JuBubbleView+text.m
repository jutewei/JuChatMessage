//
//  JuBubbleView+text.m
//  JuChatMessage
//
//  Created by Juvid on 2018/9/17.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuBubbleView+text.h"

@implementation JuBubbleView (text)
-(void)shSetTextView:(BOOL)isLeft{
    self.ju_labMessage=[[UILabel alloc]init];
    [self addSubview:self.ju_labMessage];
    self.ju_labMessage.numberOfLines=0;
    if (isLeft) {
        self.ju_labMessage.juEdge(UIEdgeInsetsMake(10, 12, 10, 10));
    }else{
        self.ju_labMessage.juEdge(UIEdgeInsetsMake(10, 10, 10, 12));
    }
}

-(void)juSetTextData:(JuMessageModel *)juModel{

}

@end
