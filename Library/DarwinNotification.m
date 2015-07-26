//
//  Created by Tate Johnson on 20/07/2015.
//  Copyright (c) 2015 Tate Johnson. All rights reserved.
//

#import "DarwinNotification.h"
#import <notify.h>

static void DarwinNotificationCallback(CFNotificationCenterRef center,
									   void *observer,
									   CFStringRef name,
									   void const *object,
									   CFDictionaryRef userInfo) {
	DarwinNotification *darwinNotification = (__bridge DarwinNotification *)observer;
	darwinNotification.observerHandler();
}

@interface DarwinNotification ()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) DarwinNotificationObserverHandler observerHandler;

@end

@implementation DarwinNotification

- (instancetype)initWithName:(NSString *)name observerHandler:(DarwinNotificationObserverHandler)observerHandler {
	self = [super init];
	if (self) {
		self.name = name;
		self.observerHandler = observerHandler;

		CFNotificationCenterRef const center = CFNotificationCenterGetDarwinNotifyCenter();
		CFStringRef str = (__bridge CFStringRef)self.name;
		CFNotificationCenterAddObserver(center,
										(__bridge const void *)(self),
										DarwinNotificationCallback,
										str,
										NULL,
										CFNotificationSuspensionBehaviorDeliverImmediately);

	}
	return self;
}

- (void)dealloc {
	CFNotificationCenterRef const center = CFNotificationCenterGetDarwinNotifyCenter();
	CFStringRef str = (__bridge CFStringRef)self.name;
	CFNotificationCenterRemoveObserver(center,
									   (__bridge const void *)(self),
									   str,
									   NULL);
	CFNotificationCenterRemoveEveryObserver(center, (__bridge const void *)(self));
}

+ (void)postNotification:(NSString *)name {
	notify_post([name UTF8String]);
}

@end
