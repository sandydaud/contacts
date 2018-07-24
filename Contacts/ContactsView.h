//
//  ContactsView.h
//  Contacts
//
//  Created by Daud Sandy Christianto on 23/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsView : UIView

@property (weak, nonatomic) IBOutlet UICollectionView *contactsCollectionView;
@property (weak, nonatomic) IBOutlet UIView *snackbarView;
@property (weak, nonatomic) IBOutlet UILabel *snackbarText;

@end
