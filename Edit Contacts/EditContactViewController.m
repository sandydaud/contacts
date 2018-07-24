//
//  EditContactViewController.m
//  Contacts
//
//  Created by Daud Sandy Christianto on 23/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import "EditContactViewController.h"
#import "ContactDetailViewModel.h"
#import "EditContactView.h"
#import "ContactDetailModel.h"

@interface EditContactViewController () <UITextFieldDelegate>

@property (strong, nonatomic) ContactDetailViewModel *viewModel;
@property (strong, nonatomic) EditContactView *view;

@end

@implementation EditContactViewController
@dynamic view;

- (instancetype)initWithViewModel:(nonnull ContactDetailViewModel *)viewModel {
    self = [super initWithNibName:@"EditContactViewController" bundle:nil];
    if (self) {
        self.viewModel = viewModel;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Edit Contact";
    [self bindToViewModel];
    [self viewModelDidUpdate];
    
    self.view.firstNameTextField.delegate = self;
    self.view.lastNameTextField.delegate = self;
    self.view.phoneNumberTextField.delegate = self;
    self.view.emailTextField.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"Done"
                                              style:UIBarButtonItemStylePlain
                                              target:self
                                              action:@selector(doneEditing:)];
    self.navigationItem.rightBarButtonItem = doneButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)bindToViewModel {
    __weak typeof(self) weakSelf = self;
    self.viewModel.didUpdate = ^{
        [weakSelf viewModelDidUpdate];
    };
}

- (void)viewModelDidUpdate {
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.isAddContact ? @"https://gojek-contacts-app.herokuapp.com/images/missing.png" : self.viewModel.contactDetail.imageUrl]];
    self.view.contactImageView.image = [UIImage imageWithData:imageData];
    self.view.firstNameTextField.text = self.viewModel.contactDetail.firstName;
    self.view.lastNameTextField.text = self.viewModel.contactDetail.lastName;
    self.view.phoneNumberTextField.text = self.viewModel.contactDetail.phoneNumber;
    self.view.emailTextField.text = self.viewModel.contactDetail.email;
    self.view.nameLabel.text = self.isAddContact ? @"" : [NSString stringWithFormat:@"%@ %@", self.viewModel.contactDetail.firstName, self.viewModel.contactDetail.lastName];
}

- (void)dismissKeyboard {
    [self.view.firstNameTextField resignFirstResponder];
    [self.view.lastNameTextField resignFirstResponder];
    [self.view.phoneNumberTextField resignFirstResponder];
    [self.view.emailTextField resignFirstResponder];
}

- (void)keyboardShown:(NSNotification *)notification {
    CGFloat heightkeyboard = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    self.view.scrollViewBottomConstraint.constant = heightkeyboard;
    [UIView animateWithDuration:0.25f animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)keyboardHidden:(NSNotification *)notification {
    self.view.scrollViewBottomConstraint.constant = 0.0f;
    [UIView animateWithDuration:0.25f animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)doneEditing:(id)sender {
    
//    if (self.view.)
    ContactDetailModel *contactDetail = [[ContactDetailModel alloc] init];
    contactDetail.firstName = self.view.firstNameTextField.text;
    contactDetail.lastName = self.view.lastNameTextField.text;
    contactDetail.phoneNumber = self.view.phoneNumberTextField.text;
    contactDetail.email = self.view.emailTextField.text;
    
    if (!self.isAddContact) {
        contactDetail.imageUrl = self.viewModel.contactDetail.imageUrl;
        NSString *url = [NSString stringWithFormat:@"https://gojek-contacts-app.herokuapp.com/contacts/%@.json", self.viewModel.contactDetail.idContact];
        [contactDetail updateContactDetail:url contactDetail:contactDetail completion:^(BOOL isError, NSString *response) {
            if (isError) {
                self.view.errorView.hidden = NO;
                self.view.errorMessageLabel.text = response;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:3.0 animations:^{
                        [self.view.errorView setAlpha:0.0f];
                    } completion:^(BOOL finished){
                        if (finished) {
                            self.view.errorView.hidden = YES;
                            [self.view.errorView setAlpha:1.0f];
                        }
                    }];
                });
            }
            else {
                if ([self.delegate respondsToSelector:@selector(editContactHasFinished:response:)]) {
                    [self.delegate editContactHasFinished:contactDetail response:response];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }];
    }
    else {
        contactDetail.isFavorite = NO;
        
        NSString *url = @"https://gojek-contacts-app.herokuapp.com/contacts.json";
        [contactDetail addContactDetail:url contactDetail:contactDetail completion:^(BOOL isError, NSString *response){
            if (isError) {
                self.view.errorView.hidden = NO;
                self.view.errorMessageLabel.text = response;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:3.0 animations:^{
                        [self.view.errorView setAlpha:0.0f];
                    } completion:^(BOOL finished){
                        if (finished) {
                            self.view.errorView.hidden = YES;
                            [self.view.errorView setAlpha:1.0f];
                        }
                    }];
                });
            }
            else {
                if ([self.delegate respondsToSelector:@selector(addContactFinished:)]) {
                    [self.delegate addContactFinished:response];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }];
    }
    
    
}

@end
