//
//  SingletoncClass.h
//  ePathshala
//
//  Created by Sana on 10/12/15.
//  Copyright © 2015 Sana Desai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class KVICAppDelegate;
@interface SingletonClass : NSObject
{
    KVICAppDelegate *appDelegate;
}
@property(nonatomic,  strong)   NSString *strDBPath;
@property(nonatomic,  strong)   NSString *strBookFolderPath;
@property(nonatomic,  strong)   NSString *strBookCoverPath;
@property(nonatomic,  strong)   NSString *strChapName;
@property(nonatomic,assign) CGFloat iPhoneX_TopPadding,iPhoneX_BottomPadding;

+(SingletonClass *)sharedSingleton;

-(NSString *)getstrDBPath;
-(NSString *)getStrBookFolderPath;
-(NSString *)getStrBookCoverPath;
-(NSString *)getStrChapName;
@end
