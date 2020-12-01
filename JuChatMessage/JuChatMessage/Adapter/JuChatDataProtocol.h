//
//  JuChatDataProtocol.h
//  MTIMKit_Example
//
//  Created by Juvid on 2019/6/4.
//  Copyright © 2019 美图. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum{
    JUMessageBodyTypeText       =0,    /*! \~chinese 文本类型 \~english Text */
    JUMessageBodyTypeImage      =1,         /*! \~chinese 图片类型 \~english Image */
    JUMessageBodyTypeGif        =3,         /*! \~chinese 表情类型 \~english Image */
    JUMessageBodyTypeVoice      =2,         /*! \~chinese 语音类型 \~english Voice */
    JUMessageBodyTypeVideo      =4,         /*! \~chinese 视频类型 \~english Video */
    JUMessageBodyTypeLocation   =5,      /*! \~chinese 位置类型 \~english Location */
    JUMessageBodyTypeFile       =6,          /*! \~chinese 文件类型 \~english File */
    JUMessageBodyTypeCmd        =7,           /*! \~chinese 命令类型 \~english Cmd */
}JUMessageBodyType;
NS_ASSUME_NONNULL_BEGIN

@protocol JuChatDataProtocol <NSObject>

- (NSString *)ju_messageText;
//原模型数据
- (id)juData;

//图片资源使用
- (CGSize)ju_conSize;
- (NSString *)ju_messageUrl;///内容
- (NSString *)ju_thumbUrl;///小图

//音视频资源使用
- (NSString *)ju_duration;

//用户信息
- (NSString *)ju_userHeadUrl;
- (NSString *)ju_userName;

//信息状态
- (BOOL)isSend;
- (BOOL)isRead;
- (NSInteger )sendeStatus;///< 0正在发送 1成功 2失败

- (NSString *)ju_msgTime;
- (NSTimeInterval )ju_creatTime;

//拓展信息
- (id)juMsgExtM;
- (NSAttributedString *)ju_attributeText;

//cell标记
- (NSString *)ju_identifier;
- (JUMessageBodyType )ju_mesageType;
@end

NS_ASSUME_NONNULL_END
