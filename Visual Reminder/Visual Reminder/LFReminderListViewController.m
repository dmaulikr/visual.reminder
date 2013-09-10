//
//  LFMainViewController.m
//  Visual Reminder
//
//  Created by Vincent on 10/09/13.
//  Copyright (c) 2013 Little Factory. All rights reserved.
//

#import "LFReminderListViewController.h"

#import "LFReminderCell.h"
#import "ReminderList.h"
#import "Reminder.h"

static NSString * const REMINDER_CELL_IDENTIFIER = @"LFReminderCellIdentifier";

@interface LFReminderListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LFReminderListViewController

@synthesize reminderList;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"LFReminderCell" bundle:nil]
         forCellReuseIdentifier:REMINDER_CELL_IDENTIFIER];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Events

- (IBAction)addButtonClicked:(id)sender
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.delegate = self;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *capturedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    Reminder *createdReminder = [NSEntityDescription insertNewObjectForEntityForName:@"Reminder"
                                                              inManagedObjectContext:self.managedObjectContext];
    createdReminder.image = capturedImage;
    
    [self.reminderList addRemindersObject:createdReminder];
    [self.managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.tableView reloadData];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.reminderList.reminders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LFReminderCell *cell = [self.tableView dequeueReusableCellWithIdentifier:REMINDER_CELL_IDENTIFIER];
    
    Reminder *reminder = [self.reminderList.reminders objectAtIndex:indexPath.row];
    cell.imageView.image = reminder.image;
    cell.shortCommentLabel.text = reminder.shortComment;
    
    return cell;
}

#pragma mark - UITableViewDelegate

@end
