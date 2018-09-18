//
//  JuChatViewController.m
//  JuChatMessage
//
//  Created by Juvid on 2016/10/19.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuChatViewController.h"
#import "JuChatInputView.h"
#import "UIView+JuLayGroup.h"
#import "JuChatMessageCell.h"
#import "JuMessageModel.h"
@interface JuChatViewController ()<JuChatMessageDelegate>{
    JuChatInputView * ju_InputView;
    __weak IBOutlet UITableView *ju_TableView;
    NSMutableArray *ju_MArrList;
}

@end

@implementation JuChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"chatDome";
    ju_TableView.rowHeight=UITableViewAutomaticDimension;
    ju_TableView.estimatedRowHeight=50;
    ju_TableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self juSetInputView];
    ju_MArrList =[NSMutableArray array];
    for (int i=0; i<100; i++) {
        JuMessageModel *juM=[JuMessageModel new];
        if (i%2==0) {
            juM.isSend=YES;
        }
        if (i%4==0) {
            juM.type=JUMessageBodyTypeText;
        }else if(i%4==1){
            juM.type=JUMessageBodyTypeImage;
            juM.ju_scale=0.05*i+1;
        }else if(i%4==2){
            juM.type=JUMessageBodyTypeGif;
            juM.ju_scale=1;
        }
        else{
            juM.type=JUMessageBodyTypeVoice;
        }
        juM.ju_messageText=@"这是条测试行家里的规定时间发链接而对方";
        [ju_MArrList addObject:juM];
    }
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ju_MArrList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JuMessageModel *juM=ju_MArrList[indexPath.row];
    JuChatMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:juM.ju_Identifier];
    if (!cell) {
        cell=[[JuChatMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:juM.ju_Identifier withModel:juM];
        cell.delegate=self;
    }
    cell.ju_Model=juM;
    return cell;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [ju_InputView juViewWillAppear];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [ju_TableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:ju_MArrList.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [ju_InputView juViewWillDisAppear];
}
- (IBAction)juTouchNext:(id)sender {
  }

-(void)juSetInputView{
    ju_InputView =[[JuChatInputView alloc]init];
    [self.view addSubview:ju_InputView];
    __weak typeof(self) weakSelf=self;
    ju_InputView.ju_TextResult=^(NSString *text){
        [weakSelf juGetText:text];
    };
    ju_InputView.ju_tableView=ju_TableView;
    ju_InputView.juFrame(CGRectMake(0.01, -0.01, 0, 47));
}
-(void)juGetText:(NSString *)text{
    JuMessageModel *juM=[JuMessageModel new];
    juM.isSend=YES;
    juM.type=JUMessageBodyTypeText;
    juM.ju_messageText=text;
    [ju_MArrList addObject:juM];
    [ju_TableView reloadData];
     [ju_TableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:ju_MArrList.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
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
