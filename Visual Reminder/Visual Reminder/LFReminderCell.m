//
//  LFReminderCell.m
//  Visual Reminder
//
//  Created by Vincent on 10/09/13.
//  Copyright (c) 2013 Little Factory. All rights reserved.
//

#import "LFReminderCell.h"

@implementation LFReminderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setUpCell];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setUpCell];
}

- (void)setUpCell
{
    self.reminderImageView.image = self.reminder.image;
    self.shortCommentField.text = self.reminder.shortComment;
    
    self.shortCommentField.placeholder = NSLocalizedString(@"Reminder.cell.comment.placeholder",);
    self.shortCommentField.delegate = self;
    
    self.polaroidView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.polaroidView.layer.shadowOffset = CGSizeMake(0.0, 3.0);
    self.polaroidView.layer.shadowOpacity = 1.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.reminderCellDelegate cellCommentWillBeginEditing:self];
    return YES;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.reminder.shortComment = textField.text;
    [self.reminderCellDelegate cellCommentDidEndEditing:self];
    return YES;
}

@end
