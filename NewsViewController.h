//
//  NewsViewController.h
//  Figures
//
//  Created by Jason on 2014/10/7.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *newsData;
    NSArray *dateData;
}

@property (nonatomic, strong) IBOutlet UITableView *newsTableView;
@end
