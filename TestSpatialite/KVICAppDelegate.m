//
//  AppDelegate.m
//  TestSpatialite
//
//  Created by Gaurav on 24/07/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

#import "KVICAppDelegate.h"
#import "Constant.h"
#import "SingletonClass.h"
#import "TestSpatialite-Swift.h"

//@interface AppDelegate ()
//
//@end

@implementation KVICAppDelegate
@synthesize fileMgr,homeDir,title,splashViewController;
@synthesize orientationLock;
@synthesize topSpace,bottomSpace;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

 
    if (@available(iOS 11.0, *)) {
        if (IS_IPHONE_X_XR_XMAX) {
            [SingletonClass sharedSingleton].iPhoneX_TopPadding = self.window.safeAreaInsets.top;
            [SingletonClass sharedSingleton].iPhoneX_BottomPadding = self.window.safeAreaInsets.bottom;
            
            topSpace =   self.window.safeAreaInsets.top;
            bottomSpace =  self.window.safeAreaInsets.bottom;
            
            NSLog(@"%f",  [SingletonClass sharedSingleton].iPhoneX_BottomPadding);
            NSLog(@"%f",  [SingletonClass sharedSingleton].iPhoneX_TopPadding);
        }
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.orientationLock = UIInterfaceOrientationMaskPortrait;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

//    GISViewController *aObjVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"GISViewController"];
     GISSplashScreenViewControllerSwift *aObjVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"GISSplashScreenViewControllerSwift"];

    //KhadiStoreListViewController *aObjVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"KhadiStoreListViewController"];
//     InspectionFormViewController *aObjVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"InspectionFormViewController"];
//    PreviewViewController *aObjVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"PreviewViewController"];
   // KhadiStoreListViewController *aObjVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"KhadiStoreListViewController"];
   //  InspectionFormViewController *aObjVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"InspectionFormViewController"];


    
    self.navigationController=[[UINavigationController alloc] initWithRootViewController:aObjVC];
    self.navigationController.navigationBar.hidden = YES;
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    

    [self checkAndCreateDatabase];
    
    return YES;
}

-(NSString *)GetDocumentDirectory{
    self.fileMgr = [NSFileManager defaultManager];
    self.homeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    return homeDir;
}

-(void) checkAndCreateDatabase{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *databasePath = [self.GetDocumentDirectory stringByAppendingPathComponent:@"GISdb.sqlite"];
    success = [fileManager fileExistsAtPath:databasePath];
    if(success) {
        NSLog(@"working");
        return;}
    else{
        NSLog(@"notworking");
        NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"GISdb.sqlite"];
        [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return self.orientationLock;
}

@end
