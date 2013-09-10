//
//  Reminder.h
//  Visual Reminder
//
//  Created by Vincent on 10/09/13.
//  Copyright (c) 2013 Little Factory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Reminder : NSManagedObject

@property (nonatomic, retain) NSNumber * done;
@property (nonatomic, retain) id image;
@property (nonatomic, retain) NSString * longComment;
@property (nonatomic, retain) NSString * shortComment;
@property (nonatomic, retain) NSDate * date;

@end
