//
//  LFReminderCell.h
//  Visual Reminder
//
//  Created by Vincent on 10/09/13.
//  Copyright (c) 2013 Little Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFReminderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *polaroidView;
@property (weak, nonatomic) IBOutlet UIImageView *reminderImageView;
@property (weak, nonatomic) IBOutlet UITextField *shortCommentLabel;

@end
