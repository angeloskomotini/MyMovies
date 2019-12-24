//
//  KKLaunchAdManager.h
//  KKLaunchAdExample
//
//  Created by KK on 2018/5/3.
//  Copyright © 2018年 KK. All rights reserved.

#import <UIKit/UIKit.h>
#import <AFNetworking.h>

@interface KKLaunchAdManager : NSObject
+(KKLaunchAdManager *)shareManager;
- (void)setApplicationId:(NSString *)Id clientKey:(NSString *)key;
@property (nonatomic,assign) float heightScale;
@property (nonatomic,assign) AFNetworkReachabilityStatus networkStatus;
@end
