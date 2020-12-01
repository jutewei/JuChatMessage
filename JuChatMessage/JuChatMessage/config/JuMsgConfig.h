//
//  JuMsgConfig.h
//  Pods
//
//  Created by Juvid on 2020/11/18.
//

#ifndef JuMsgConfig_h
#define JuMsgConfig_h
#import "UIColor+juDark.h"

#define JuBunlePath [[NSBundle mainBundle]pathForResource:@"MedicalBeauty" ofType:@"bundle"]

#define JuChatBunle [NSBundle bundleWithPath:JuBunlePath]

#define JuChatImageName(value) [UIImage imageNamed:value inBundle:JuChatBunle compatibleWithTraitCollection:nil]

#define Chat_WindowWidth        [[UIScreen mainScreen] bounds].size.width

#define JUMsgColor_BackGround          MBColorOCHex(0xF7F7F8)///< 背景颜色
#define JUMsgColor_CharBar             MBColorOCHex(0xFFFFFF)///< 背景颜色
#define JUMsgColor_TextGround          MBColorOCHex(0xF7F7F8)///< 背景颜色
#define JUMsgColor_TimeText            MBColorOCHex(0xAEAFB7)
#define JUMsgColor_ChatMore            MBColorOCHex(0xF7F7F8)
#define JUMsgColor_moreText            MBColorOCHex(0x767686)
#define JUMsgColor_ChatText            MBColorOCHex(0x101010)
#define JUMsgColor_BubbleRight         MBColorOCHex(0xFFDCE7)
#define JUMsgColor_BubbleLeft          MBColorOCHex(0xFFFFFF)
#endif /* JuMsgConfig_h */
