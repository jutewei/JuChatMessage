//
//  JuChatEmojiView.m
//  MedicalBeautySDK
//
//  Created by Juvid on 2020/11/27.
//

#import "JuChatEmojiView.h"
#import "JuLayoutFrame.h"
#import "JuMsgConfig.h"
#import "JuChatBarDelegate.h"

@interface JuChatEmojiView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) NSMutableArray   *sh_MArrList;///< 数据
@end

@implementation JuChatEmojiView{
    UICollectionView *_ju_collectView;
}

-(instancetype)init{
    self=[super init];
    if (self) {
        [self juSetView];
    }
    return self;
}

-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    if (self.superview) {
        self.juSafeFrame(CGRectMake(0, -0.01, 0, [JuChatEmojiView mbHeight]));
        self.ju_Bottom.constant=-[JuChatEmojiView mbHeight];
        [self.superview layoutIfNeeded];
    }
}
-(void)juShowView:(UIView *)view{
    [self.superview layoutIfNeeded];
    if (view) {
        if (!self.superview) {
            [view addSubview:self];
        }
        self.hidden=NO;
        self.ju_Bottom.constant=0;
        [UIView animateWithDuration:0.3 animations:^{
            [self.superview layoutIfNeeded];
        }];
    }else{
        self.ju_Bottom.constant=-[JuChatEmojiView mbHeight]-34;
        [UIView animateWithDuration:0.3 animations:^{
            [self.superview layoutIfNeeded];
        }completion:^(BOOL finished) {
            self.hidden=YES;
        }];
    }
}
-(void)juSetView{

    UICollectionView *collectView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.juSetCollectLayout];
    collectView.dataSource = self;
    collectView.delegate=self;
    collectView.showsHorizontalScrollIndicator=NO;
    collectView.pagingEnabled=YES;
    collectView.showsVerticalScrollIndicator=NO;
    collectView.backgroundColor=[UIColor whiteColor];
    [collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self addSubview:collectView];
    collectView.juEdge(UIEdgeInsetsMake(0, 0, 35, 0));
    _ju_collectView=collectView;
    self.backgroundColor=_ju_collectView.backgroundColor=JUMsgColor_ChatMore;

    UIView *view=[[UIView alloc]init];
    [self addSubview:view];
    view.juEdgeH(JuEdgeHMake(0, 0, -.01, 35));

    UIButton *btnDelete=[[UIButton alloc]init];
    [btnDelete addTarget:self action:@selector(juTouchSend:) forControlEvents:UIControlEventTouchUpInside];
    btnDelete.backgroundColor=[UIColor greenColor];
    [view addSubview:btnDelete];
    btnDelete.juFrame(CGRectMake(-.01, 0, 50, 0));

    UIButton *btnSender=[[UIButton alloc]init];
    [btnSender addTarget:self action:@selector(juTouchDelete:) forControlEvents:UIControlEventTouchUpInside];
    btnSender.backgroundColor=[UIColor redColor];
    [view addSubview:btnSender];
    btnSender.juFrame(CGRectMake(-50, 0, 50, 0));
//    导入表情文件
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MBEmojisList" ofType:@"plist"]];
    _sh_MArrList=dic[@"People"];

}

-(UICollectionViewFlowLayout *)juSetCollectLayout{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset=UIEdgeInsetsMake(5, 0, 5, 0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize=CGSizeMake((Chat_WindowWidth)/8, ([JuChatEmojiView mbHeight]-45)/5);
    return layout;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _sh_MArrList.count;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(juDidSelectEmoji:)]) {
        [self.delegate juDidSelectEmoji:_sh_MArrList[indexPath.row]];
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    UILabel *labText=[cell.contentView viewWithTag:12345];
    if (!labText) {
        labText=[[UILabel alloc]init];
        labText.tag=12345;
        labText.textAlignment=NSTextAlignmentCenter;
        labText.font=[UIFont systemFontOfSize:30];
        [cell.contentView addSubview:labText];
        labText.juEdge(UIEdgeInsetsMake(0, 0, 0, 0));
    }
    labText.text=_sh_MArrList[indexPath.row];
    return cell;
}
-(void)juTouchDelete:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(juDidSelectEmoji:)]) {
        [self.delegate juDidSelectEmoji:@""];
    }
}
-(void)juTouchSend:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(juDidSelectEmoji:)]) {
        [self.delegate juDidSelectEmoji:nil];
    }
}
+(CGFloat)mbHeight{
    return 280;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
