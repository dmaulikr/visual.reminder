//
//  ReminderList.h
//  Visual Reminder
//
//  Created by Vincent on 10/09/13.
//  Copyright (c) 2013 Little Factory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Reminder;

@interface ReminderList : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSOrderedSet *reminders;
@end

@interface ReminderList (CoreDataGeneratedAccessors)

- (void)insertObject:(Reminder *)value inRemindersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRemindersAtIndex:(NSUInteger)idx;
- (void)insertReminders:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeRemindersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInRemindersAtIndex:(NSUInteger)idx withObject:(Reminder *)value;
- (void)replaceRemindersAtIndexes:(NSIndexSet *)indexes withReminders:(NSArray *)values;
- (void)addRemindersObject:(Reminder *)value;
- (void)removeRemindersObject:(Reminder *)value;
- (void)addReminders:(NSOrderedSet *)values;
- (void)removeReminders:(NSOrderedSet *)values;
@end
