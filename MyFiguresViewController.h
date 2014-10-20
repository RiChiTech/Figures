//
//  MyFiguresViewController.h
//  Figures
//
//  Created by Jason on 2014/7/30.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FiguresListTableViewCell.h"
#import "AddMyFiguresViewController.h"
#import "EditFiguresViewController.h"
#import "ReviewFiguresViewController.h"

@interface MyFiguresViewController : UIViewController <UINavigationBarDelegate, UITableViewDataSource, UITableViewDelegate, AddMyFiguresDelegate, EditFiguresDelegate>
{
    NSMutableArray *onlineArray;
    NSMutableArray *transactionsArray;
    NSMutableArray *historyArray;
}

@property (nonatomic, strong) NSMutableArray *wantListArray;
@property (nonatomic, strong) NSMutableArray *timeLocationListArray;
@property (nonatomic, strong) NSMutableArray *onlineEventArray;
@property (nonatomic, strong) NSMutableArray *onlineFigureArray;
@property (nonatomic, strong) NSMutableArray *onlineImageArray;
@property (nonatomic, strong) NSMutableArray *transactionsEventArray;
@property (nonatomic, strong) NSMutableArray *transactionsFigureArray;
@property (nonatomic, strong) NSMutableArray *transactionsImageArray;
@property (nonatomic, strong) NSMutableArray *historyEventArray;
@property (nonatomic, strong) NSMutableArray *historyFigureArray;
@property (nonatomic, strong) NSMutableArray *historyImageArray;
@property (nonatomic, strong) NSString *onlineEventString;
@property (nonatomic, strong) NSString *onlineFigureString;
@property (nonatomic, weak) IBOutlet UITableView *figuresListTableView;
@property (nonatomic, weak) IBOutlet UIView *bgView;
@property (nonatomic, weak) IBOutlet UIView *fbLoginAlertView;


@end
