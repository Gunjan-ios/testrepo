//
//  GISMainViewController.m
//  TestSpatialite
//
//  Created by Gaurav on 29/07/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

#import "GISMainViewController.h"
#import "Constant.h"
#import "SingletonClass.h"
#import <WebKit/WebKit.h>
#import "KMNavigationViewController.h"
#import "GISAddLayersViewController.h"

@interface GISMainViewController ()<WKNavigationDelegate> {
    UIView *viewHeader;
    GISAddLayersViewController *vcGISAddLayersViewController;
}
@property(nonatomic,  strong) WKWebView *webViewMain;
@property(nonatomic,  strong) GISAddLayersViewController *vcGISAddLayersViewController;

@end

@implementation GISMainViewController
@synthesize webViewMain,vcGISAddLayersViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initDesign];
}


-(void)initDesign {
    
    viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, [SingletonClass sharedSingleton].iPhoneX_TopPadding, SCREEN_WIDTH, 60)];
    viewHeader.backgroundColor = [UIColor grayColor];
    [self.view addSubview:viewHeader];
    
    UIButton *btbSettings = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    [btbSettings setImage:[UIImage imageNamed:@"sideMenu"] forState:UIControlStateNormal];
    [btbSettings addTarget:(KMNavigationViewController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    [viewHeader addSubview:btbSettings];
   
    NSURL *localPathURL = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@".html"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:localPathURL];
    
    WKPreferences *prefs = [[WKPreferences alloc] init];
    prefs.javaScriptEnabled = YES;
    prefs.javaScriptCanOpenWindowsAutomatically = YES;
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences = prefs;
    
    self.webViewMain = [[WKWebView alloc] initWithFrame:CGRectMake(0, 60+[SingletonClass sharedSingleton].iPhoneX_TopPadding, SCREEN_WIDTH, SCREEN_HEIGHT-[SingletonClass sharedSingleton].iPhoneX_TopPadding-60) configuration:config];
    self.webViewMain.navigationDelegate = self;
    self.webViewMain.backgroundColor = [UIColor grayColor];
    self.webViewMain.contentMode = UIViewContentModeScaleToFill;
    self.webViewMain.scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:self.webViewMain];
    
    [self.webViewMain loadRequest:request];
    
}

#pragma mark webview delegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
}

#pragma mark - add layers
-(void)loadAddLayerScreen {
    NSLog(@"add layers");
    
   
    self.vcGISAddLayersViewController = [[GISAddLayersViewController alloc] initWithNibName:@"GISAddLayersViewController" bundle:nil];
    
    [self.view addSubview:self.vcGISAddLayersViewController.view];
    
    
    
}


@end
