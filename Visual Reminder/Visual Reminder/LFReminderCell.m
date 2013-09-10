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
    self.shortCommentLabel.placeholder = NSLocalizedString(@"Reminder.cell.comment.placeholder",);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
