//
//  ContactDetailViewController.m
//  Contacts
//
//  Created by Daud Sandy Christianto on 23/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import "ContactDetailViewController.h"
#import "ContactDetailView.h"
#import "ContactDetailViewModel.h"
#import "ContactDetailModel.h"
#import "EditContactViewController.h"

@interface ContactDetailViewController () <EditContactDelegate>

@property (strong, nonatomic) ContactDetailViewModel *viewModel;
@property (strong, nonatomic) ContactDetailView *view;

@end

@implementation ContactDetailViewController
@dynamic view;

- (instancetype)initWithViewModel:(nonnull ContactDetailViewModel *)viewModel {
    self = [super initWithNibName:@"ContactDetailViewController" bundle:nil];
    if (self) {
        self.viewModel = viewModel;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Details";
    [self bindToViewModel];
    [self viewModelDidUpdate];
    
    UIBarButtonItem *editContactButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@"Edit"
                                             style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(editContact:)];
    self.navigationItem.rightBarButtonItem = editContactButtonItem;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self bindToViewModel];
    [self viewModelDidUpdate];
}

- (void)bindToViewModel {
    __weak typeof(self) weakSelf = self;
    self.viewModel.didUpdate = ^{
        [weakSelf viewModelDidUpdate];
    };
}

- (void)viewModelDidUpdate {
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.viewModel.contactDetail.imageUrl]];
    self.view.contactImage.image = [UIImage imageWithData:imageData];
    self.view.nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.viewModel.contactDetail.firstName, self.viewModel.contactDetail.lastName];
    self.view.mobileNumberLabel.text = self.viewModel.contactDetail.phoneNumber;
    self.view.emailLabel.text = self.viewModel.contactDetail.email;
    
    [self setFavoriteButton:self.viewModel.contactDetail.isFavorite];
}

- (void)editContact:(id)sender {
    EditContactViewController *editContactVC = [[EditContactViewController alloc] initWithViewModel:self.viewModel];
    editContactVC.delegate = self;
    [self.navigationController pushViewController:editContactVC animated:YES];
}

- (void)editContactHasFinished:(ContactDetailModel *)contactDetail response:(NSString *)response {
    [self.viewModel updateContactDetail:contactDetail];
    if (response) {
        self.view.snackbarView.hidden = NO;
        self.view.snackbarMessage.text = response;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1.0 animations:^{
                [self.view.snackbarView setAlpha:0.0f];
            } completion:^(BOOL finished){
                if (finished) {
                    self.view.snackbarView.hidden = YES;
                    [self.view.snackbarView setAlpha:1.0f];
                }
            }];
        });
    }
}

- (IBAction)emailButtonTapped:(id)sender {
    NSString *URLEMail = [NSString stringWithFormat:@"mailto:%@?subject=title&body=content", self.viewModel.contactDetail.email];
    
    NSString *url = [URLEMail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    [[UIApplication sharedApplication]  openURL: [NSURL URLWithString: url]];
}

- (IBAction)messageButtonTapped:(id)sender {
    NSString *sms = [NSString stringWithFormat:@"sms:%@?&body=Send a message!", [self.viewModel.contactDetail.phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""]];
    NSString *url = [sms stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (IBAction)callButtonTapped:(id)sender {
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:[self.viewModel.contactDetail.phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    
}

- (IBAction)favoriteButtonTapped:(id)sender {
    NSString *path = [NSString stringWithFormat:@"https://gojek-contacts-app.herokuapp.com/contacts/%@.json", self.viewModel.contactDetail.idContact];
    ContactDetailModel *contactDetail = [[ContactDetailModel alloc] init];
    contactDetail = self.viewModel.contactDetail;
    contactDetail.isFavorite = NO;
    [self.viewModel updateContactDetail:contactDetail];
    [contactDetail updateContactDetail:path contactDetail:self.viewModel.contactDetail completion:^(BOOL isError, NSString *response) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)setFavoriteButton:(BOOL)isFavorited {
    if (isFavorited) {
        self.view.favoriteButton.backgroundColor = [UIColor blueColor];
        [self.view.favoriteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else {
        self.view.favoriteButton.backgroundColor = [UIColor whiteColor];
        [self.view.favoriteButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
}

@end
