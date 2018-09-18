//
//  JuMessageModel.h
//  JuChatMessage
//
//  Created by Juvid on 2016/10/19.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    JUMessageBodyTypeText       =0,    /*! \~chinese 文本类型 \~english Text */
    JUMessageBodyTypeImage      =1,         /*! \~chinese 图片类型 \~english Image */
    JUMessageBodyTypeGif        =2,         /*! \~chinese 表情类型 \~english Image */
    JUMessageBodyTypeVoice      =3,         /*! \~chinese 语音类型 \~english Voice */
    JUMessageBodyTypeVideo      =4,         /*! \~chinese 视频类型 \~english Video */
    JUMessageBodyTypeLocation   =5,      /*! \~chinese 位置类型 \~english Location */
    JUMessageBodyTypeFile       =6,          /*! \~chinese 文件类型 \~english File */
    JUMessageBodyTypeCmd        =7,           /*! \~chinese 命令类型 \~english Cmd */
}JUMessageBodyType;

@interface JuMessageModel : NSObject
@property BOOL isSend;
@property (nonatomic, assign) JUMessageBodyType type;
@property (nonatomic, strong) NSString *ju_Identifier;
@property (nonatomic,strong) NSString *ju_messageText;
@property (nonatomic,assign) float ju_scale;

@end
