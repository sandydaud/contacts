//
//  ViewController.m
//  Contacts
//
//  Created by Daud Sandy Christianto on 23/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import "ViewController.h"
#import "EditContactViewController.h"
#import "ContactCollectionViewCell.h"
#import "ContactsModel.h"
#import "ContactDetailModel.h"
#import "ContactDetailViewModel.h"
#import "ContactsView.h"
#import "ContactDetailViewController.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, EditContactDelegate>

@property (strong, nonatomic) ContactsView *view;
@property (strong, nonatomic) NSMutableArray<ContactDetailModel *> *listContact;

@end

@implementation ViewController
@dynamic view;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Contacts";
    [self getData];
    self.view.contactsCollectionView.delegate = self;
    self.view.contactsCollectionView.dataSource = self;
    [self.view.contactsCollectionView registerNib:[UINib nibWithNibName:@"ContactCollectionViewCell" bundle:nil]
                      forCellWithReuseIdentifier:@"ContactCollectionViewCell"];
    
    UIBarButtonItem *addContactButtonItem = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Add"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(addContact:)];
    self.navigationItem.rightBarButtonItem = addContactButtonItem;
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getData];
    [self.view.contactsCollectionView reloadData];
}

- (void)addContact:(id)sender {
    EditContactViewController *editContactVC = [[EditContactViewController alloc] initWithNibName:@"EditContactViewController" bundle:nil];
    editContactVC.delegate = self;
    editContactVC.isAddContact = YES;
    [self.navigationController pushViewController:editContactVC animated:YES];
}

- (void)getData {
    NSString *path = @"https://gojek-contacts-app.herokuapp.com/contacts.json";
    [self requestData:path];
}

- (void)requestData:(NSString *)path {
    ContactsModel *contact = [[ContactsModel alloc] init];
    [contact requestData:path completion:^(ContactsModel *result) {
        self.listContact = result.contactList;
    }];
}

#pragma mark - EditContactDelegate
- (void)addContactFinished:(NSString *)response {
    if (response) {
        self.view.snackbarView.hidden = NO;
        self.view.snackbarText.text = response;
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

#pragma UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.contactsCollectionView.frame.size.width, 70);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *path = [NSString stringWithFormat:@"https://gojek-contacts-app.herokuapp.com/contacts/%@.json", self.listContact[indexPath.row].idContact];
    ContactDetailModel *contactDetail = [[ContactDetailModel alloc] init];
    [contactDetail requestContactDetail:path completion:^(ContactDetailModel *result) {
        ContactDetailViewModel *contactDetailVM = [[ContactDetailViewModel alloc] initWithContactDetail:result];
        ContactDetailViewController *contactdetailVC = [[ContactDetailViewController alloc] initWithViewModel:contactDetailVM];
        [self.navigationController pushViewController:contactdetailVC animated:YES];
    }];
}

#pragma UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listContact.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ContactCollectionViewCell *cell = (ContactCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ContactCollectionViewCell" forIndexPath:indexPath];
    [cell configureContactDetail:self.listContact[indexPath.row]];
    return cell;
}


@end
