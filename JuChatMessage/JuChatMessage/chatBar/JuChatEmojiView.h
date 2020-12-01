//
//  JuChatEmojiView.h
//  MedicalBeautySDK
//
//  Created by Juvid on 2020/11/27.
//

#import <UIKit/UIKit.h>
@protocol JuChatBarDelegate;
NS_ASSUME_NONNULL_BEGIN

@interface JuChatEmojiView : UIView
@property (weak, nonatomic) id<JuChatBarDelegate> delegate;
-(void)juShowView:(UIView *)view;
+(CGFloat)mbHeight;
@end

NS_ASSUME_NONNULL_END
