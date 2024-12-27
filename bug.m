This code suffers from a potential race condition.  The `-performSelectorInBackground:withObject:` method isn't guaranteed to complete before the main thread continues execution. This could lead to `myObject` being accessed or modified in an inconsistent state.

```objectivec
@interface MyClass : NSObject
@property (strong, nonatomic) MyObject *myObject;

- (void)someMethod {
    [self performSelectorInBackground:@selector(longRunningTask) withObject:nil];

    // ... other code that might access myObject before the background task finishes ...
    NSLog("My object: %@
", self.myObject);
}

- (void)longRunningTask {
    // ... some lengthy operation ...
    self.myObject = [[MyObject alloc] init];
}
@end
```