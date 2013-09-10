//
//  LFMainViewController.h
//  Visual Reminder
//
//  Created by Vincent on 10/09/13.
//  Copyright (c) 2013 Little Factory. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "ReminderList.h"

@interface LFReminderListViewController : UIViewController <UIImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) ReminderList *reminderList;

@end
