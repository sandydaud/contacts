//
//  ContactDetailView.h
//  Contacts
//
//  Created by Daud Sandy Christianto on 23/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactDetailView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *contactImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIView *collectionButtonView;
@property (weak, nonatomic) IBOutlet UIView *imageBackground;

@property (weak, nonatomic) IBOutlet UIView *snackbarView;
@property (weak, nonatomic) IBOutlet UILabel *snackbarMessage;
@end
