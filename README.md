# Objective-C Race Condition Bug

This repository demonstrates a common but subtle race condition in Objective-C. The bug occurs because of asynchronous operation without proper synchronization.  The main thread attempts to access an object before a background task that modifies it has finished. 

## Bug Description

The `bug.m` file contains code that uses `performSelectorInBackground:withObject:` to start a background task. However, the main thread continues execution and accesses the object `myObject` before the background task has completed its modification. This can lead to unexpected behavior, including crashes or data corruption.

## Solution

The `bugSolution.m` file provides a fix using Grand Central Dispatch (GCD). A dispatch semaphore ensures that the main thread waits for the background task to finish before accessing `myObject`. This prevents the race condition.

## How to reproduce

1. Clone this repository.
2. Open the project in Xcode.
3. Build and run the application. 
4. Observe the potential inconsistencies (depending on the execution speed). 

The solution demonstrates a safer approach to handle asynchronous operations in Objective-C, ensuring that data access is properly synchronized.