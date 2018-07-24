//
//  ContactDetailViewController.h
//  Contacts
//
//  Created by Daud Sandy Christianto on 23/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContactDetailViewModel;
@interface ContactDetailViewController : UIViewController

- (instancetype)initWithViewModel:(nonnull ContactDetailViewModel *)viewModel;

@end
