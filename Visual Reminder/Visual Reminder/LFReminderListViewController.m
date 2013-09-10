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

@interface LFReminderListViewController () {
    LFReminderCell *activeCell;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *sortedReminders;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation LFReminderListViewController

@synthesize reminderList;
@synthesize managedObjectContext;
@synthesize fetchReminderListsRequest;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"Reminder.list.title",);

    [self.tableView registerNib:[UINib nibWithNibName:@"LFReminderCell"
                                               bundle:nil]
         forCellReuseIdentifier:REMINDER_CELL_IDENTIFIER];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    [self fetchPersistedReminderList];
    
    [self refreshData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
}

#pragma mark - Private Methods

- (void)fetchPersistedReminderList
{
    NSArray *reminderLists = [self.managedObjectContext executeFetchRequest:self.fetchReminderListsRequest
                                                                      error:nil];
    if ([reminderLists count] > 0) {
        self.reminderList = [reminderLists objectAtIndex:0];
    } else {
        self.reminderList = (ReminderList *) [NSEntityDescription insertNewObjectForEntityForName:@"ReminderList"
                                                                                 inManagedObjectContext:self.managedObjectContext];
    }
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

- (Reminder *)reminderForDisplayAtIndex:(NSUInteger)idx
{
    return [self.sortedReminders objectAtIndex:idx];
}

#pragma mark - Handling Keyboard

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height - self.toolbar.frame.size.height, 0.0);
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
    
    [self.tableView scrollRectToVisible:activeCell.frame
                               animated:YES];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [self.tableView scrollRectToVisible:activeCell.frame
                               animated:YES];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
    
    
}

#pragma mark - Button Events

- (IBAction)addButtonClicked:(id)sender
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.allowsEditing = NO;
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
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self refreshData];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - LFReminderCellDelegate

- (void)cellCommentWillBeginEditing:(LFReminderCell *)cell
{
    activeCell = cell;
}

- (void)cellCommentDidEndEditing:(LFReminderCell *)cell
{
    
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
    
    cell.reminder = [self reminderForDisplayAtIndex:indexPath.row];
    [cell setUpCell];
    cell.reminderCellDelegate = self;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.reminderList removeRemindersObject:[self reminderForDisplayAtIndex:indexPath.row]];
    [self refreshData];
}

@end
