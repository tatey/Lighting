#import <Foundation/Foundation.h>

typedef void (^DarwinNotificationObserverHandler)();

@interface DarwinNotification : NSObject

@property (readonly) NSString *name;
@property (readonly) DarwinNotificationObserverHandler observerHandler;

- (instancetype)initWithName:(NSString *)name observerHandler:(DarwinNotificationObserverHandler)observerHandler;

+ (void)postNotification:(NSString *)name;

@end
