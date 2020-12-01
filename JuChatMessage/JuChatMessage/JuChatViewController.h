//
//  JuChatViewController.h
//  JuChatMessage
//
//  Created by Juvid on 2016/10/19.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JuChatDataAdapter.h"
//#import "JuBaseTableVC.h"
#import "JuChatBarView.h"
@interface JuChatViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    UITableView *ju_tableView;
    NSMutableArray *_sh_MArrList;
}

@property (nonatomic,readonly)UIView *ju_InputView;

/**
 刷新indexPath

 @param indexPath indexPath
 */
-(void)juReloadTable:(NSIndexPath *)indexPath;

/**
 在table最后插入一条数据

 @param isScroll 是否滚动
 */
-(void)juInsterData:(id<JuChatDataProtocol>)adapter isScroll:(BOOL)isScroll;

/**
 点击气泡

 @param sender 气泡
 */
-(void)juSelectBubble:(UIView *)sender;

-(void)juDidSelectMore:(UIView *)sender;
/**
 设置输入框
 */
-(void)juSetInputView;
-(void)juScrollPositionBottom:(BOOL)animated;
@end
