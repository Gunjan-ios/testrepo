//
//  AppDelegate.h
//  TestSpatialite
//
//  Created by Gaurav on 24/07/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GISSplashScreenViewController;
@interface KVICAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) GISSplashScreenViewController *splashViewController;
@property (nonatomic,retain) NSFileManager *fileMgr;
@property (nonatomic,retain) NSString *homeDir;
@property (nonatomic,retain) NSString *title;
@property(nonatomic, readwrite) UIInterfaceOrientationMask orientationLock;
@property(nonatomic,assign) CGFloat topSpace,bottomSpace;

-(NSString *)GetDocumentDirectory;

@end

