//
//  NSObject(TS_Notification).h
//  HGShopAssistant
//
//  Created by JiaLei on 15/10/16.
//  Copyright © 2015年 Higegou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(TS_Notification)

- (void)ts_handleNotification:(NSNotification *)notification;
- (void)ts_addNotification:(NSString *)name;
- (void)ts_removeNotification:(NSString *)name;
- (void)ts_removeAllNotifications;

- (void)ts_postNotification:(NSNotification *)notification;
- (void)ts_postNotificationName:(NSString *)aName;
- (void)ts_postNotificationName:(NSString *)aName object:(id)anObject;
- (void)ts_postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo;

@end
