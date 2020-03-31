//
//  Constant.h
//  ePathshala
//
//  Created by Sana on 10/8/15.
//  Copyright (c) 2015 Sana Desai. All rights reserved.
//

#ifndef ePathshala_Constant_h
#define ePathshala_Constant_h

#define KEY_FROM_DOCUMENT_ID(doc_id) [NSString stringWithFormat:@"bookmarks_%@",(doc_id)]

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4 (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

//#define IS_IPHONE_X      (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0)
#define IS_IPHONE_X_XR_XMAX      (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0 || IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 896.0)

#define kNavigationViewHeight 70

#endif
