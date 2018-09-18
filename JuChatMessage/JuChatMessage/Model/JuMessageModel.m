//
//  JuMessageModel.m
//  JuChatMessage
//
//  Created by Juvid on 2016/10/19.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuMessageModel.h"

@implementation JuMessageModel

-(NSString *)ju_Identifier{
    NSArray *arrSend=@[@"left",@"right"];
//    NSArray *arrType=@[@"text",@"image",@"voice"];
    return [NSString stringWithFormat:@"message%@%u",arrSend[_isSend],self.type];
}

@end
