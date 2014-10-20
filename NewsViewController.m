//
//  NewsViewController.m
//  Figures
//
//  Created by Jason on 2014/10/7.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

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
    self.title = @"最新消息";
    [self initData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    newsData = @[@"公仔APP全新上架囉！！！", @"7-11聯名Poter小錢包搶購一空啊！", @"7-11最新凱蒂貓女超人系列持續發燒中，各地換取人潮有如長蛇一般，擠爆各地7-11，造成交通小組塞", @"很不幸的，近來關於全家的黑心食品消息，所以我們APP決定全面下架全家的公仔系列，抵制黑心商人！！！"];
    dateData = @[@"2014/9/22", @"2014/10/1", @"2014/10/5", @"2014/10/12"];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -
#pragma mark UITableViewDataDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 列寬
    CGFloat contentWidth = tableView.frame.size.width;
    // 用何種字體進行顯示
    UIFont *font = [UIFont systemFontOfSize:16];
    
    // 該行要顯示的內容
    NSString *content = [newsData objectAtIndex:indexPath.row];
    // 計算出顯示完內容需要的最小尺寸
//    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 1000) lineBreakMode:UILineBreakModeWordWrap];
    
    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 1000)];
    
    // 這裏返回需要的高度
    return size.height + 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [newsData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0;
}


#pragma mark -
#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSString *newsString = [newsData objectAtIndex:indexPath.row];
    NSString *dateString = [dateData objectAtIndex:indexPath.row];
    
    [cell.textLabel setNumberOfLines:0];
    cell.textLabel.text = newsString;
    cell.detailTextLabel.text = dateString;
    
    return cell;

}


@end
