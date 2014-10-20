//
//  MyFiguresViewController.m
//  Figures
//
//  Created by Jason on 2014/7/30.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "MyFiguresViewController.h"
#import "FBLoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>

#define  DIC_EXPANDED @"expanded" //是否是展开 0收缩 1展开
#define  DIC_ARARRY @"array"

#define ACCESS_TOKEN_KEY @"fb_access_token"
#define EXPIRATION_DATE_KEY @"fb_expiration_date"

@interface MyFiguresViewController ()



@end

@implementation MyFiguresViewController
@synthesize figuresListTableView;
@synthesize onlineEventString;
@synthesize onlineFigureString;
@synthesize onlineEventArray, onlineFigureArray, onlineImageArray;
@synthesize transactionsEventArray, transactionsFigureArray, transactionsImageArray;
@synthesize historyEventArray, historyFigureArray, historyImageArray;
@synthesize wantListArray, timeLocationListArray;
@synthesize fbLoginAlertView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"個人商品";
    
    [self initData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    NSString *fbAccessToken = [[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN_KEY];

    if ([FBSession.activeSession.accessTokenData.accessToken isEqualToString:fbAccessToken]) {
        [figuresListTableView setHidden:NO];
        [fbLoginAlertView setHidden:YES];
        [self.navigationItem.rightBarButtonItem setEnabled:YES];

    }
    else
    {
        [figuresListTableView setHidden:YES];
        [fbLoginAlertView setHidden:NO];
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
    }
    
    
//    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
//        // If there's one, just open the session silently, without showing the user the login UI
//        [figuresListTableView setHidden:YES];
//        [fbLoginAlertView setHidden:NO];
//        [self.navigationItem.rightBarButtonItem setEnabled:NO];
//        
//        // If there's no cached session, we will show a login button
//    }else if (FBSession.activeSession.state == FBSessionStateOpen){
////        UIButton *loginButton = [self.viewController loginButton];
////        [loginButton setTitle:@"Log in with Facebook" forState:UIControlStateNormal];
//        [figuresListTableView setHidden:NO];
//        [fbLoginAlertView setHidden:YES];
//        [self.navigationItem.rightBarButtonItem setEnabled:YES];
//    }
//    else
//    {
//        [figuresListTableView setHidden:YES];
//        [fbLoginAlertView setHidden:NO];
//        [self.navigationItem.rightBarButtonItem setEnabled:NO];
//    
//    }
//    

    
}


- (void)initData
{
    onlineArray = [[NSMutableArray alloc] init];
    transactionsArray = [[NSMutableArray alloc] init];
    historyArray = [[NSMutableArray alloc] init];
    
    onlineEventArray = [[NSMutableArray alloc] init];
    onlineFigureArray = [[NSMutableArray alloc] init];
    transactionsEventArray = [[NSMutableArray alloc] init];
    transactionsFigureArray = [[NSMutableArray alloc] init];
    historyEventArray = [[NSMutableArray alloc] init];
    historyFigureArray = [[NSMutableArray alloc] init];
    
    [transactionsEventArray addObjectsFromArray:[NSArray arrayWithObjects:@"七龍珠", @"灌籃高手", nil]];
    [transactionsFigureArray addObjectsFromArray:[NSArray arrayWithObjects:@"孫悟空", @"櫻木花道", nil]];
    
    [historyEventArray addObjectsFromArray:[NSArray arrayWithObjects:@"幽遊白書", @"灌籃高手", nil]];
    
    [historyFigureArray addObjectsFromArray:[NSArray arrayWithObjects:@"浦飯幽助", @"仙道彰", nil]];
    
    NSMutableDictionary *onlineDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:onlineEventArray, DIC_ARARRY, [NSNumber numberWithInt:1], DIC_EXPANDED, nil];
    NSMutableDictionary *transactionsDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:transactionsEventArray, DIC_ARARRY, [NSNumber numberWithInt:1], DIC_EXPANDED, nil];
    NSMutableDictionary *historyDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:historyEventArray, DIC_ARARRY, [NSNumber numberWithInt:1], DIC_EXPANDED, nil];
    
    
    [onlineArray addObject:onlineDic];
    [transactionsArray addObject:transactionsDic];
    [historyArray addObject:historyDic];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"addmyfigures"]) {
        id addMyFigures = segue.destinationViewController;
        [addMyFigures setValue:self forKey:@"delegate"];
    }
    
    if ([segue.identifier isEqualToString:@"editselectedfigures"]) {
        NSIndexPath *indexPath = [self.figuresListTableView indexPathForSelectedRow];
        NSString *eventString = [onlineEventArray objectAtIndex:indexPath.row];
        NSString *figureString = [onlineFigureArray objectAtIndex:indexPath.row];
        EditFiguresViewController *editFiguresViewController = segue.destinationViewController;
        editFiguresViewController.eventString = eventString;
        editFiguresViewController.figureString = figureString;
        editFiguresViewController.wantList = wantListArray;
        editFiguresViewController.timeLocationList = timeLocationListArray;

        
    }
    
    if ([segue.identifier isEqualToString:@"reviewfigures"]) {
        NSIndexPath *indexPath = [self.figuresListTableView indexPathForSelectedRow];
        ReviewFiguresViewController *reviewFiguresViewController = segue.destinationViewController;
        reviewFiguresViewController.eventNameString = [transactionsEventArray objectAtIndex:indexPath.row];
        reviewFiguresViewController.figuresNameString = [transactionsFigureArray objectAtIndex:indexPath.row];
    }
}

- (void)passEventName:(NSString *)eventName passFiguresName:(NSString *)figuresName passImageName:(NSString *)imageName passWantList:(NSMutableArray *)wantList passTimeLocationList:(NSMutableArray *)timeLocationList
{
    onlineEventString = eventName;
    onlineFigureString = figuresName;
    wantListArray = [[NSMutableArray alloc] initWithArray:wantList];
    timeLocationListArray = [[NSMutableArray alloc] initWithArray:timeLocationList];
    
    [self reloadFigureListTable];

}

- (void)reloadFigureListTable
{
    [onlineEventArray addObject:[NSString stringWithFormat:@"%@", onlineEventString]];
    [onlineFigureArray addObject:[NSString stringWithFormat:@"%@", onlineFigureString]];
    
    if ([self.onlineEventArray count] > 0) {
        NSTimeInterval animationDuration = 0.3;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:animationDuration];
        self.bgView.alpha = 0.0;
        self.figuresListTableView.alpha = 1.0;
        
        [UIView commitAnimations];

    }
    
    [self.figuresListTableView reloadData];

}

#pragma mark -
#pragma mark UITableViewDataDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        NSMutableDictionary *dic = [onlineArray objectAtIndex:0];
        NSArray *array=[dic objectForKey:DIC_ARARRY];
        
        //判断是收缩還是展開
        if ([[dic objectForKey:DIC_EXPANDED] intValue]) {
            return [array count];
        }else
        {
            return 0;
        }

    }
    else if(section == 1)
    {
        NSMutableDictionary *dic = [transactionsArray objectAtIndex:0];
        NSArray *array=[dic objectForKey:DIC_ARARRY];
        
        //判断是收缩還是展開
        if ([[dic objectForKey:DIC_EXPANDED] intValue]) {
            return [array count];
        }else
        {
            return 0;
        }

    
    }
    else
    {
        NSMutableDictionary *dic = [historyArray objectAtIndex:0];
        NSArray *array=[dic objectForKey:DIC_ARARRY];
        
        //判断是收缩還是展開
        if ([[dic objectForKey:DIC_EXPANDED] intValue]) {
            return [array count];
        }else
        {
            return 0;
        }

    
    }
    
}

#pragma mark -
#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"FigureListCell";
    NSString *transactionsCellIdentifier = @"TransactionsFigureListCell";
    FiguresListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    FiguresListTableViewCell *transactionsCell = [tableView dequeueReusableCellWithIdentifier:transactionsCellIdentifier];
    
    if (!cell) {
        cell = [[FiguresListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (!transactionsCell) {
        transactionsCell = [[FiguresListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:transactionsCellIdentifier];
    }
    
    if (indexPath.section == 0) {
        NSString *eventString = [onlineEventArray objectAtIndex:indexPath.row];
        NSString *figureString = [onlineFigureArray objectAtIndex:indexPath.row];
        cell.figureEventLabel.text = eventString;
        cell.figureLabel.text = figureString;
        return cell;
    }
    else if (indexPath.section == 1) {
        NSString *eventString = [transactionsEventArray objectAtIndex:indexPath.row];
        NSString *figureString = [transactionsFigureArray objectAtIndex:indexPath.row];
        transactionsCell.figureEventLabel.text = eventString;
        transactionsCell.figureLabel.text = figureString;
        return transactionsCell;
    }
    else {
        NSString *eventString = [historyEventArray objectAtIndex:indexPath.row];
        NSString *figureString = [historyFigureArray objectAtIndex:indexPath.row];
        transactionsCell.figureEventLabel.text = eventString;
        transactionsCell.figureLabel.text = figureString;
        return transactionsCell;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.figuresListTableView.frame.size.width, 20)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = view.frame;
    
    if ([self isExpanded:section])
        [btn setImage: [UIImage imageNamed:@"figures_expand.png" ]forState:UIControlStateNormal];
    else
        [btn setImage: [UIImage imageNamed:@"figures_collapse.png" ]forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    //btn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    if (section == 0) {
        [btn setTitle:[NSString stringWithFormat:@"上架中(%ld)",[onlineEventArray count]] forState:UIControlStateNormal];
    }
    else if (section == 1)
    {
        [btn setTitle:[NSString stringWithFormat:@"交易中(%ld)", [transactionsEventArray count]] forState:UIControlStateNormal];
    
    }
    else
    {
        [btn setTitle:[NSString stringWithFormat:@"歷史(%ld)", [historyEventArray count]] forState:UIControlStateNormal];
    }
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    //设置button的图片和标题的相对位置
    //4个参数是到上边界，左边界，下边界，右边界的距离
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 290, 0, 10)];
    
    btn.tag = section;
    [btn addTarget:self action:@selector(expandButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:btn];
    
    return view;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [onlineEventArray removeObjectAtIndex:indexPath.row];
        [onlineFigureArray removeObjectAtIndex:indexPath.row];
    }
    
    [self.figuresListTableView reloadData];
}

#pragma mark -
#pragma mark UITableViewExpandOrCollapse
-(void)collapseOrExpand:(int)section{
    if (section == 0) {
        NSMutableDictionary *onlineDic = [onlineArray objectAtIndex:0];
        
        int expanded = [[onlineDic objectForKey:DIC_EXPANDED] intValue];
        if (expanded) {
            [onlineDic setValue:[NSNumber numberWithInt:0]forKey:DIC_EXPANDED];
        }
        else
        {
            [onlineDic setValue:[NSNumber numberWithInt:1]forKey:DIC_EXPANDED];
        }

    }
    else if (section == 1)
    {
        NSMutableDictionary *transactionsDic = [transactionsArray objectAtIndex:0];
        
        int expanded=[[transactionsDic objectForKey:DIC_EXPANDED] intValue];
        if (expanded) {
            [transactionsDic setValue:[NSNumber numberWithInt:0]forKey:DIC_EXPANDED];
        }
        else
        {
            [transactionsDic setValue:[NSNumber numberWithInt:1]forKey:DIC_EXPANDED];
        }
    
    }
    else
    {
        NSMutableDictionary * historyDic = [historyArray objectAtIndex:0];
        
        int expanded=[[historyDic objectForKey:DIC_EXPANDED] intValue];
        if (expanded) {
            [historyDic setValue:[NSNumber numberWithInt:0]forKey:DIC_EXPANDED];
        }
        else
        {
            [historyDic setValue:[NSNumber numberWithInt:1]forKey:DIC_EXPANDED];
        }

    }
    
    
}

-(int)isExpanded:(int)section{
    
    int expanded;
    
    if (section == 0) {
        NSDictionary *onlineDic = [onlineArray objectAtIndex:0];
        expanded = [[onlineDic objectForKey:DIC_EXPANDED] intValue];
    }
    else if (section == 1)
    {
        NSMutableDictionary *transactionsDic = [transactionsArray objectAtIndex:0];
        expanded=[[transactionsDic objectForKey:DIC_EXPANDED] intValue];
    }
    else
    {
        NSMutableDictionary * historyDic = [historyArray objectAtIndex:0];
        expanded=[[historyDic objectForKey:DIC_EXPANDED] intValue];
    }
    return expanded;
}

//按钮被点击时触发
-(void)expandButtonClicked:(id)sender{
    
    UIButton* btn = (UIButton*)sender;
    int section = (int)[btn tag];//取得tag知道点击对应哪个块
    
    [self collapseOrExpand:section];
    
    //刷新tableview
    [figuresListTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    
}

#pragma mark -
#pragma mark FBLoginButton
- (IBAction)fbLogin:(id)sender
{
    UIStoryboard *myStoryboard = self.storyboard;
    FBLoginViewController *fbLoginViewController = (FBLoginViewController *)[myStoryboard instantiateViewControllerWithIdentifier:@"FBLoginViewController"];
    //[self presentViewController:fbLoginViewController animated:YES completion:nil];
    [fbLoginViewController presentFromController:self];

}




@end
