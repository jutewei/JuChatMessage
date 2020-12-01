//
//  JuChatDataAdapter.h
//  MTIMKit_Example
//
//  Created by Juvid on 2019/6/4.
//  Copyright © 2019 美图. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JuChatDataProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface JuChatDataAdapter : NSObject<JuChatDataProtocol>
+ (instancetype)initWithData:(id)data;
@property (nonatomic, strong) id mtData;

@property (nonatomic, strong) id mt_extMsgM;///< 拓展消息模型

@end

NS_ASSUME_NONNULL_END
