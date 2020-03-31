//
//  LeftPanelViewController.h
//  Karnataka Tourism
//
//  Created by Mayank Bhatt on 8/20/15.
//  Copyright (c) 2015 Mayank Bhatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface KMLeftPanelViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic)  UITableView *tableLeftPanel;
@property (nonatomic, retain) NSMutableArray *itemsInTable;
@end
