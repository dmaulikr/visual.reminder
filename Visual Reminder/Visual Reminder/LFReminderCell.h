//
//  LFReminderCell.h
//  Visual Reminder
//
//  Created by Vincent on 10/09/13.
//  Copyright (c) 2013 Little Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Reminder.h"

@protocol LFReminderCellDelegate;
@interface LFReminderCell : UITableViewCell <UITextFieldDelegate>

@property (strong, nonatomic) Reminder *reminder;
@property (weak, nonatomic) id<LFReminderCellDelegate> reminderCellDelegate;

@property (weak, nonatomic) IBOutlet UIView *polaroidView;
@property (weak, nonatomic) IBOutlet UIImageView *reminderImageView;
@property (weak, nonatomic) IBOutlet UITextField *shortCommentField;

- (void)setUpCell;

@end

@protocol LFReminderCellDelegate <NSObject>

@required
- (void)cellCommentWillBeginEditing:(LFReminderCell *)cell;
- (void)cellCommentDidEndEditing:(LFReminderCell *)cell;

@end
