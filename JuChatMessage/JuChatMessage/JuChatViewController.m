//
//  JuChatViewController.m
//  JuChatMessage
//
//  Created by Juvid on 2016/10/19.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuChatViewController.h"
#import "JuLayoutFrame.h"
#import "JuChatMessageCell.h"
#import "JuChatDataAdapter.h"
#import "JuChatBarDelegate.h"
#import "JuMessageModel.h"
#import "JuDeviceManage.h"
#import "JuPhotoPickers.h"
#import "JuChatMediaFile.h"
#import "JuLargeImageVC.h"
#import "JuAudioDownManage.h"
#import "JuChatMsgTimeCell.h"
@interface JuChatViewController ()<JuChatMessageDelegate,JuChatBarDelegate,SHChoosePhotoDelegate>{
    JuChatBarView * _ju_InputView;
   
   
}

@end

@implementation JuChatViewController
@synthesize ju_InputView=_ju_InputView;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self juSetTableView];
    [self juSetInputView];
    _sh_MArrList =[NSMutableArray array];

    // Do any additional setup after loading the view.
}
-(void)juSetTableView{
    ju_tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    ju_tableView.rowHeight=44;
    ju_tableView.delegate=self;
    ju_tableView.dataSource=self;
    ju_tableView.estimatedSectionFooterHeight=0;
    ju_tableView.estimatedRowHeight=0;
    ju_tableView.estimatedSectionHeaderHeight=0;
    ju_tableView.backgroundColor=JUMsgColor_BackGround;
    ju_tableView.rowHeight=UITableViewAutomaticDimension;
    ju_tableView.estimatedRowHeight=50;
    ju_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:ju_tableView];
    ju_tableView.juEdge(UIEdgeInsetsMake(0, 0, 0, 0));
    self.view.backgroundColor=[UIColor whiteColor];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_ju_InputView juViewWillAppear];
    self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan=NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_ju_InputView juViewWillDisAppear];
    self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan=YES;
}
-(BOOL)shIsGrouped{
    return YES;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sh_MArrList.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JuChatDataAdapter *juM=_sh_MArrList[indexPath.section];
    JuChatMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:juM.ju_identifier];
    if (!cell) {
        cell=[[JuChatMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:juM.ju_identifier withModel:juM];
        cell.delegate=self;
    }
    cell.ju_Model=juM;
    return cell;
}

-(void)juSetInputView{
    _ju_InputView =[[JuChatBarView alloc]init];
    _ju_InputView.delegate=self;
    [self.view addSubview:_ju_InputView];
    _ju_InputView.ju_tableView=ju_tableView;
    _ju_InputView.juSafeFrame(CGRectMake(0.01, -0.01, 0, ChatBarHeight));
    ju_tableView.juBottom.safe.equal(ChatBarHeight);
}
#pragma mark 气泡点击代理
-(void)juSelectReSend:(UIButton *)sender{
    NSIndexPath *indexPath = [self juIndexWithView:sender];
    JuChatDataAdapter *juM=_sh_MArrList[indexPath.section];
    [self mtSendMessage:juM indexPath:indexPath];
    [self juReloadTable:indexPath];
}

-(void)juSelectHeadImage:(UIButton *)sender{
//    NSIndexPath *indexPath=[sender juSubViewTable:sh_TableView];
//    JuChatDataAdapter *juM=_sh_MArrList[indexPath.section];

}
-(void)juSelectBubble:(UIView *)sender{
    NSIndexPath *indexPath=[self juIndexWithView:sender];
    JuChatDataAdapter *juM=_sh_MArrList[indexPath.section];
    if (juM.ju_mesageType==JUMessageBodyTypeVoice) {
        if ([juM.ju_messageUrl hasPrefix:@"http"]) {///< 网络语音
            [self juReadAudio:indexPath];
            if (![JuAudioDownManage mtGetExistFile:juM.ju_messageUrl]) {
//                [MBProgressHUD juShowHUDText:@"正在准备语音文件..."];
            }
            [[JuAudioDownManage sharedInstance]mtDownDataURL:juM.ju_messageUrl handle:^(id result) {
                [[JuDeviceManage sharedInstance]asyncPlayingWithPath:result completion:^(NSError * _Nonnull error) {

                }];
            }];
            return;
        }
        //本地语音播放
        [[JuDeviceManage sharedInstance]asyncPlayingWithPath:juM.ju_messageUrl completion:^(NSError * _Nonnull error) {
            
        }];
    }else if(juM.ju_mesageType==JUMessageBodyTypeImage){
        JuChatMessageCell *cell=[ju_tableView cellForRowAtIndexPath:indexPath];
        CGRect frame= [cell convertRect:cell.ju_viewBubble.frame toView:cell.ju_viewBubble.window];
        NSString *stringUrl=juM.isSend?[NSURL fileURLWithPath:juM.ju_messageUrl].absoluteString:juM.ju_messageUrl;
        [[JuLargeImageVC initRect:frame images:@[stringUrl] currentIndex:0 thumbSize:CGSizeMake(80, 80) finishHandle:^CGRect(id result) {
            return frame;
        }] juShow];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    [_ju_InputView juHidderAll];
}

#pragma mark chatBar delegate
-(void)juDidSendText:(NSString *)text{
    JuChatDataAdapter *adapter=[self juSetMessageWithData:text type:JUMessageBodyTypeText];
    [self juInsterData:adapter isScroll:YES];
    [self mtSendMessage:adapter indexPath:[NSIndexPath indexPathForRow:0 inSection:_sh_MArrList.count-1]];
}

-(void)juDidSelectMore:(UIView *)sender{
    [[JuPhotoPickers sharedInstance] juSelectWithType:sender.tag presentVC:self finishHandle:^(id  _Nullable result) {
        [self fbFinishImage:result];
    }];
}

/*选择照片完成*/
-(void)fbFinishImage:(UIImage *)imageData{
    NSDictionary *imagePath = [JuChatMediaFile juSaveImage:imageData];
    if (imagePath) {
        [self juSetAdapter:[self juSetMessageWithData:imagePath type:JUMessageBodyTypeImage]];
    }
}
-(void)juDidSendVoice:(id)voicePath{
    [self juSetAdapter:[self juSetMessageWithData:voicePath type:JUMessageBodyTypeVoice]];
}
-(void)juSetAdapter:(JuChatDataAdapter *)adapter{
    if (adapter) {
        [self juInsterData:adapter isScroll:YES];
        [self mtSendMessage:adapter indexPath:nil];
    }
}
-(void)juInsterData:(JuChatDataAdapter *)adapter isScroll:(BOOL)isScroll{
    [_sh_MArrList addObject:adapter];
    [ju_tableView beginUpdates];
    [ju_tableView insertSections:[NSIndexSet indexSetWithIndex:_sh_MArrList.count-1] withRowAnimation:UITableViewRowAnimationNone];
    [ju_tableView endUpdates];
    if (isScroll) {
        [self juScrollPositionBottom:YES];
    }
}
-(void)juScrollPositionBottom:(BOOL)animated{
    if (ju_tableView.numberOfSections>0) {
        [self.view layoutIfNeeded];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\
            [self->ju_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self->ju_tableView.numberOfSections-1] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
        });
    }
}
-(void)juReloadTable:(NSIndexPath *)indexPath{
    if (indexPath) {
        JuChatDataAdapter *juM=_sh_MArrList[indexPath.section];
        JuChatMessageCell *cell=[ju_tableView cellForRowAtIndexPath:indexPath];
        cell.ju_Model=juM;
    }else{
        [ju_tableView reloadData];
    }
}

- ( id <JuChatDataProtocol>)juSetMessageWithData:(id)content type:(JUMessageBodyType )type{
    JuMessageModel *juM=[JuMessageModel new];
    juM.isSend=YES;
    juM.type=type;
    if (type==JUMessageBodyTypeText) {
        juM.ju_messageText=content;
    }else if (type==JUMessageBodyTypeImage){
        juM.ju_content=content;
    }else if (type==JUMessageBodyTypeVoice){
        juM.ju_content=content;
    }
    return [JuChatDataAdapter initWithData:juM];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JuChatDataAdapter *juM=_sh_MArrList[indexPath.section];
    if (juM.ju_mesageType==JUMessageBodyTypeImage) {
        return juM.ju_conSize.height+32;
    }
    return UITableViewAutomaticDimension;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([self isHidderTime:section]) return nil;
    JuChatDataAdapter *juM=_sh_MArrList[section];
    UIView *view=[JuChatMsgTimeCell mtTimeView:juM.ju_msgTime];
    view.backgroundColor=ju_tableView.backgroundColor;
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=ju_tableView.backgroundColor;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self isHidderTime:section]) {
        return 0.01;
    }else if(section==0)return 28;
    return 18;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(BOOL)isHidderTime:(NSInteger)section{
    if (section>0) {
        JuChatDataAdapter *juM=_sh_MArrList[section];
        JuChatDataAdapter *juLastM=_sh_MArrList[section-1];
        if (juM.ju_creatTime-juLastM.ju_creatTime<60*1000) {
            return YES;
        }
    }
    return NO;
}

-(void)mtSendMessage:(id <JuChatDataProtocol> )mesage indexPath:(NSIndexPath *)indexPath{

}
-(void)juReadAudio:(NSIndexPath *)indexPath{

}
-(NSIndexPath *)juIndexWithView:(UIView *)view{
    UIView *superView=view;
    while (superView) {
        if ([superView isKindOfClass:[UITableViewCell class]]) {
            break;
        }
        superView=[superView superview];
    }
    NSIndexPath *indexPath = [ju_tableView indexPathForCell:(UITableViewCell *)superView];
    return indexPath;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
