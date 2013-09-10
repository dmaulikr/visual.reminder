//
//  LFAboutViewController.m
//  Visual Reminder
//
//  Created by Vincent on 10/09/13.
//  Copyright (c) 2013 Little Factory. All rights reserved.
//

#import "LFAboutViewController.h"

#import "LFUtils.h"
#import <Social/Social.h>

static NSString * const MAIL_ADDRESS = @"little.facto@gmail.com";
static NSString * const MAIL_SUBJECT = @"Application Visual Reminder (iOS)";
static NSString * const TWITTER_ACCOUNT = @"@LittleFacto ";
static NSString * const PAYPAL_DONATE_URL = @"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=WH83BE9VFEJJS";

@interface LFAboutViewController ()

@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
@property (weak, nonatomic) IBOutlet UILabel *supportLabel;
@property (weak, nonatomic) IBOutlet UIButton *donateButton;

@end

@implementation LFAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"Reminder.about.title",);
    self.contactLabel.text = NSLocalizedString(@"Reminder.about.contact.label",);
    self.supportLabel.text = NSLocalizedString(@"Reminder.about.contact.support.label",);
    [self.donateButton setTitle:NSLocalizedString(@"Reminder.about.contact.support.button",)
                       forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mailButtonPressed:(UIButton *)sender
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailComposeController = [[MFMailComposeViewController alloc] init];
        mailComposeController.mailComposeDelegate = self;
        
        [mailComposeController setToRecipients:[NSArray arrayWithObject:MAIL_ADDRESS]];
        [mailComposeController setSubject:MAIL_SUBJECT];
        [mailComposeController setMessageBody:@""
                                       isHTML:YES];
        
        [self presentViewController:mailComposeController
                           animated:YES
                         completion:nil];
    } else {
        [[LFUtils alertWithTitle:@"Attention" message:@"Vous devez d'abord configurer un compte mail"] show];
    }
    
}
- (IBAction)twitterButtonPressed:(UIButton *)sender
{
    [self presentComposerForServiceType:SLServiceTypeTwitter
                        withInitialText:TWITTER_ACCOUNT
                        andErrorMessage:@"Vous devez d'abord configurer un compte Twitter"];
}

- (IBAction)donateButtonPressed:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:PAYPAL_DONATE_URL]];
}

- (void)presentComposerForServiceType:(NSString *)serviceType withInitialText:(NSString *)accountName andErrorMessage:(NSString *)errorMessage
{
    if ([SLComposeViewController isAvailableForServiceType:serviceType]) {
        SLComposeViewController *composeController = [SLComposeViewController composeViewControllerForServiceType:serviceType];
        composeController.completionHandler = ^(SLComposeViewControllerResult result) {
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        
        [composeController setInitialText:accountName];
        
        [self presentViewController:composeController
                           animated:YES
                         completion:nil];
    } else {
        [[LFUtils alertWithTitle:@"Attention" message:errorMessage] show];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
