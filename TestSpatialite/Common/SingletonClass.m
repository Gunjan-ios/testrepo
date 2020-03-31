//
//  SingletoncClass.m
//  ePathshala
//
//  Created by Sana on 10/12/15.
//  Copyright © 2015 Sana Desai. All rights reserved.
//

#import "SingletonClass.h"
#import "KVICAppDelegate.h"

@implementation SingletonClass
@synthesize strDBPath, strBookFolderPath, strBookCoverPath,strChapName;
@synthesize iPhoneX_TopPadding, iPhoneX_BottomPadding;

+(SingletonClass *)sharedSingleton {
    
    static SingletonClass* theSignleton = nil;
    @synchronized([SingletonClass class])
    {
        if (theSignleton == nil)
        {
            theSignleton = [[SingletonClass alloc] init];
            [theSignleton allocateValues];
        }
    }
    return theSignleton;
}

-(void)allocateValues {
    appDelegate = (KVICAppDelegate *)[[UIApplication sharedApplication] delegate];
  
    self.iPhoneX_TopPadding = 0;
    self.iPhoneX_BottomPadding = 0;
}

-(NSString *)getstrDBPath{
    
    return strDBPath;
}

-(NSString *)getStrBookFolderPath{
    return  strBookFolderPath;
}
-(NSString *)getStrBookCoverPath{
    
    return strBookCoverPath;
}
-(NSString *)getStrChapName{
    
    return strChapName;
}

@end
