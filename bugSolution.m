This corrected code uses GCD and a dispatch semaphore to safely handle the background task. It ensures the main thread waits for the long-running task to complete before accessing `myObject`.

```objectivec
#import "MyObject.h"

@interface MyClass : NSObject
@property (strong, nonatomic) MyObject *myObject;

@end

@implementation MyClass

- (void)someMethod {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ 
        // ... some lengthy operation ...
        self.myObject = [[MyObject alloc] init];
        dispatch_semaphore_signal(semaphore);
    });

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog("My object: %@
", self.myObject);
    dispatch_release(semaphore); 
}

@end
```