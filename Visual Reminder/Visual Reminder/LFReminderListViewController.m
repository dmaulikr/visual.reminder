//
//  LFMainViewController.m
//  Visual Reminder
//
//  Created by Vincent on 10/09/13.
//  Copyright (c) 2013 Little Factory. All rights reserved.
//

#import "LFReminderListViewController.h"

#import "LFUtils.h"
#import "LFReminderCell.h"
#import "ReminderList.h"
#import "Reminder.h"

static NSString * const REMINDER_CELL_IDENTIFIER = @"LFReminderCellIdentifier";
static CGSize const IMAGE_RESIZE_FORMAT = {480.f, 640.f};

@interface LFReminderListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *sortedReminders;

@end

@implementation LFReminderListViewController

@synthesize reminderList;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"LFReminderCell" bundle:nil]
         forCellReuseIdentifier:REMINDER_CELL_IDENTIFIER];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    [self refreshData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshData
{
    self.sortedReminders = [self.reminderList.reminders sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        Reminder *reminder1 = (Reminder *)obj1;
        Reminder *reminder2 = (Reminder *)obj2;
        
        return [reminder2.date compare:reminder1.date];
    }];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                  withRowAnimation:UITableViewRowAnimationAutomatic];
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
    createdReminder.image = [LFUtils resizeImage:capturedImage
                                          toSize:IMAGE_RESIZE_FORMAT];
    createdReminder.date = [NSDate date];
    
    [self.reminderList addRemindersObject:createdReminder];
    [self.managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self refreshData];
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
    return [self.sortedReminders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LFReminderCell *cell = [self.tableView dequeueReusableCellWithIdentifier:REMINDER_CELL_IDENTIFIER];
    
    Reminder *reminder = [self.sortedReminders objectAtIndex:indexPath.row];
    cell.reminderImageView.image = reminder.image;
    cell.shortCommentLabel.text = @"Lorem ipsum dolor sit amet"; //reminder.shortComment;
    cell.polaroidView.layer.shadowColor = [[UIColor blackColor] CGColor];
    cell.polaroidView.layer.shadowOffset = CGSizeMake(0.0, 3.0);
    cell.polaroidView.layer.shadowOpacity = 1.0;
    
    return cell;
}

#pragma mark - UITableViewDelegate

@end
