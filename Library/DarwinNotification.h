//
//  Created by Tate Johnson on 20/07/2015.
//  Copyright (c) 2015 Tate Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DarwinNotificationObserverHandler)();

@interface DarwinNotification : NSObject

@property (readonly) NSString *name;
@property (readonly) DarwinNotificationObserverHandler observerHandler;

- (instancetype)initWithName:(NSString *)name observerHandler:(DarwinNotificationObserverHandler)observerHandler;

+ (void)postNotification:(NSString *)name;

@end
