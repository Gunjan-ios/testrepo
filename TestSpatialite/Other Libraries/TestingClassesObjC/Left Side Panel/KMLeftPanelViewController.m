//
//  LeftPanelViewController.m
//  Karnataka Tourism
//
//  Created by Mayank Bhatt on 8/20/15.
//  Copyright (c) 2015 Mayank Bhatt. All rights reserved.
//

#import "KMLeftPanelViewController.h"
#import "GISMainViewController.h"
#import "Constant.h"
#import "KMNavigationViewController.h"
#import "SingletonClass.h"
#import "GISAddLayersViewController.h"
#import "FMDB.h"
#import "KVICAppDelegate.h"

@interface KMLeftPanelViewController ()

@property (nonatomic, retain) UIButton *btnKMK;
@end

@implementation KMLeftPanelViewController
@synthesize btnKMK;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    UIImageView *imgSideMenuLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 32+[SingletonClass sharedSingleton].iPhoneX_TopPadding, 17, 11)];
    [imgSideMenuLogo setImage:[UIImage imageNamed:@"icn_leftpanel.png"]];
    [self.view addSubview:imgSideMenuLogo];
    
    self.btnKMK = [[UIButton alloc] initWithFrame:CGRectMake(-12, 21+[SingletonClass sharedSingleton].iPhoneX_TopPadding, 180, 33)];
    [self.btnKMK addTarget:self action:@selector(goToHome:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnKMK setTitle:@"GIS" forState:UIControlStateNormal];
    [self.btnKMK.titleLabel setFont:[UIFont fontWithName:@"Futura-medium" size:14.0]];
    [self.btnKMK.titleLabel setContentMode:UIViewContentModeRight];
    [self.btnKMK.titleLabel setTextAlignment:NSTextAlignmentRight];
    [self.btnKMK setBackgroundColor:[UIColor clearColor]];
    self.btnKMK.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.view addSubview:self.btnKMK];
    
    self.tableLeftPanel = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationViewHeight+[SingletonClass sharedSingleton].iPhoneX_TopPadding, SCREEN_WIDTH, SCREEN_HEIGHT-kNavigationViewHeight)];
    self.tableLeftPanel.delegate = self;
    self.tableLeftPanel.dataSource = self;
    [self.tableLeftPanel setBackgroundColor:[UIColor clearColor]];
    self.tableLeftPanel.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableLeftPanel];

    
    self.tableLeftPanel.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);
    
    self.itemsInTable = [[NSMutableArray alloc]init];

	[self.itemsInTable addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Add Layer",@"Name",@"",@"unselected",@"",@"selected",@"0",@"status", nil]];

}

-(void)loadOptions {
    
    KVICAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSString *dbPath2 = [[appDelegate GetDocumentDirectory] stringByAppendingPathComponent:@"GISdb.sqlite"];
    NSLog(@"%@",dbPath2);
    
    //NSString *dbPath2 = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"GISdb.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath2];
    
    if (![db open]) {
        // [db release];   // uncomment this line in manual referencing code; in ARC, this is not necessary/permitted
        db = nil;
    } else {
        NSLog(@"Database is open");
    }
    
    
    FMResultSet *rs = [db executeQuery:@"select * from layer_table"];
    while ([rs next])
    {
        id object = [rs resultDictionary];
        
        
        
        NSLog(@"%@", object);
    }
    
    NSString *sqlQuery = [NSString stringWithFormat:@"INSERT INTO data_4 (geometry, position, geom ,ggg) VALUES(%s, %s, %s, %s)", "'Point'", "'-135789.862744 6833532.539844'", "GeomFromText('Point(-135789.862772297 6833532.539886988)', 3857)", "'dfd'"];
    
    NSLog(@"%@",sqlQuery);
    
    BOOL success = [db executeUpdate:sqlQuery];
    if (!success) {
        NSLog(@"error = %@", [db lastErrorMessage]);
    }
    
    
    [db close];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.itemsInTable count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
    }
    // progress dialog #81B8DA
    // blue color #407397

    //label
    UILabel *LBLTItle = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 230, 30)];
//    LBLTItle.font = [kRegularFont];
    //LBLTItle.textColor = kGrayColor;
//    LBLTItle.textColor = kBlueTextColor;
    LBLTItle.text = [[self.itemsInTable objectAtIndex:indexPath.row] objectForKey:@"Name"];
    
    //check if selected
    if ([[[self.itemsInTable objectAtIndex:indexPath.row] objectForKey:@"status"]isEqualToString:@"1"]) {
		[self setHighlightLabelColor:LBLTItle];
    }
    
    //add icon and text in content view
    [cell.contentView addSubview:LBLTItle];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //set every row to 0 status
    for (int i = 0; i < self.itemsInTable.count; i++) {
        
        NSMutableDictionary *d1 = [[NSMutableDictionary alloc] initWithDictionary:[self.itemsInTable objectAtIndex:i]];
        [d1 setValue:@"0" forKey:@"status"];
        [self.itemsInTable replaceObjectAtIndex:i withObject:d1];
    }
    
    //change current row status in array
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[self.itemsInTable objectAtIndex:indexPath.row]];
    [dic setValue:@"1" forKey:@"status"];
    [self.itemsInTable replaceObjectAtIndex:indexPath.row withObject:dic];
    

    if (indexPath.row == 0) {// about us

//        GISAddLayersViewController *vcGISAddLayersViewController;
//        vcGISAddLayersViewController = [[GISAddLayersViewController alloc] initWithNibName:@"GISAddLayersViewController" bundle:nil];
//        KMNavigationViewController *navigationController = [[KMNavigationViewController alloc] initWithRootViewController:vcGISAddLayersViewController];
//        self.frostedViewController.contentViewController = navigationController;
    }
   
    GISMainViewController *objVC = (GISMainViewController*)((UINavigationController*)self.frostedViewController.contentViewController).visibleViewController;
    [objVC loadAddLayerScreen];

    [tableView reloadData];
    [self.frostedViewController hideMenuViewController];
}

#pragma mark-actions
- (IBAction)goToHome:(id)sender {
    //set every row to 0 status
    for (int i = 0; i < self.itemsInTable.count; i++) {
        
        NSMutableDictionary *d1 = [[NSMutableDictionary alloc] initWithDictionary:[self.itemsInTable objectAtIndex:i]];
        [d1 setValue:@"0" forKey:@"status"];
        [self.itemsInTable replaceObjectAtIndex:i withObject:d1];
    }
    [self.tableLeftPanel reloadData];
    
    //go to home
//    KMHomeViewController *homeViewController = [[KMHomeViewController alloc] init];
//    KMNavigationViewController *navigationController = [[KMNavigationViewController alloc] initWithRootViewController:homeViewController];
//    self.frostedViewController.contentViewController = navigationController;
//    
    [self.frostedViewController hideMenuViewController];
}

#pragma mark - set color
-(void)setHighlightLabelColor:(UILabel*)cellLabel {
	cellLabel.layer.shadowColor = [[UIColor whiteColor] CGColor];
	cellLabel.layer.shadowRadius = 4.0f;
	cellLabel.layer.shadowOpacity = .9;
	cellLabel.layer.shadowOffset = CGSizeZero;
	cellLabel.layer.masksToBounds = NO;
}

@end
