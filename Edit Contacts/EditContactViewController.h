//
//  EditContactViewController.h
//  Contacts
//
//  Created by Daud Sandy Christianto on 23/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContactDetailViewModel;
@class ContactDetailModel;

@protocol EditContactDelegate <NSObject>
@optional

- (void)editContactHasFinished:(ContactDetailModel *)contactDetail response:(NSString *)response;
- (void)addContactFinished:(NSString *)response;

@end

@interface EditContactViewController : UIViewController

@property (weak, nonatomic) id<EditContactDelegate> delegate;
@property (assign, nonatomic) BOOL isAddContact;

- (instancetype)initWithViewModel:(nonnull ContactDetailViewModel *)viewModel;

@end
