//
//  ContactsTests.m
//  ContactsTests
//
//  Created by Daud Sandy Christianto on 23/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ContactsModel.h"
#import "ContactDetailModel.h"
#import "ContactDetailViewModel.h"

@interface ContactsTests : XCTestCase

@end

@implementation ContactsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRequestData {
    NSString *path = @"https://gojek-contacts-app.herokuapp.com/contacts.json";
    ContactsModel *contactModel = [[ContactsModel alloc] init];
    [contactModel requestData:path completion:^(ContactsModel *result) {
        XCTAssertNotNil(result.contactList, @"");
    }];
}

- (void)testContactDetailModel {
    NSDictionary *dict = @{@"id":@"1732",@"first_name":@"50C",@"last_name":@"Cahyout",@"profile_pic":@"/images/missing.png",@"favorite":@YES, @"email":@"budi@gmail.com",@"phone_number":@"081340154586"};
    ContactDetailModel *contactDetail = [[ContactDetailModel alloc] initWithContactDetailDictionary:dict];
    XCTAssertEqual(@"1732", contactDetail.idContact, @"");
    XCTAssertEqual(@"50C", contactDetail.firstName, @"");
    XCTAssertEqual(@"Cahyout", contactDetail.lastName, @"");
    XCTAssertEqual(@"081340154586", contactDetail.phoneNumber, @"");
    XCTAssertEqual(@"budi@gmail.com", contactDetail.email, @"");
    XCTAssertEqual([@YES boolValue], contactDetail.isFavorite, @"");
}

- (void)testRequestContactDetail {
    NSString *path = @"https://gojek-contacts-app.herokuapp.com/contacts/1732.json";
    ContactDetailModel *contactDetail = [[ContactDetailModel alloc] init];
    [contactDetail requestContactDetail:path completion:^(ContactDetailModel *result) {
        XCTAssertNotNil(result, @"");
    }];
}

- (void)testUpdateContactDetail {
    NSString *path = @"https://gojek-contacts-app.herokuapp.com/contacts/1732.json";
    NSDictionary *dict = @{@"id":@"1732",@"first_name":@"50C",@"last_name":@"Cahyout",@"profile_pic":@"/images/missing.png",@"favorite":@YES, @"email":@"budi@gmail.com",@"phone_number":@"081340154586"};
    ContactDetailModel *contactDetail = [[ContactDetailModel alloc] initWithContactDetailDictionary:dict];
    [contactDetail updateContactDetail:path contactDetail:contactDetail completion:^(BOOL isError, NSString *response) {
        XCTAssertNotNil(response, @"");
    }];
}

- (void)testAddContact {
    NSString *path = @"https://gojek-contacts-app.herokuapp.com/contacts/1732.json";
    NSDictionary *dict = @{@"id":@"1732",@"first_name":@"50C",@"last_name":@"Cahyout",@"profile_pic":@"/images/missing.png",@"favorite":@YES, @"email":@"budi@gmail.com",@"phone_number":@"081340154586"};
    ContactDetailModel *contactDetail = [[ContactDetailModel alloc] initWithContactDetailDictionary:dict];
    [contactDetail addContactDetail:path contactDetail:contactDetail completion:^(BOOL isError, NSString *response) {
        XCTAssertNotNil(response, @"");
    }];
}

- (void)testContactDetailViewModelInitialization {
    NSDictionary *dict = @{@"id":@"1732",@"first_name":@"50C",@"last_name":@"Cahyout",@"profile_pic":@"/images/missing.png",@"favorite":@YES, @"email":@"budi@gmail.com",@"phone_number":@"081340154586"};
    ContactDetailModel *contactDetail = [[ContactDetailModel alloc] initWithContactDetailDictionary:dict];
    ContactDetailViewModel *viewModel = [[ContactDetailViewModel alloc] initWithContactDetail:contactDetail];
    XCTAssertEqual(@"1732", viewModel.contactDetail.idContact, @"");
    XCTAssertEqual(@"50C", viewModel.contactDetail.firstName, @"");
    XCTAssertEqual(@"Cahyout", viewModel.contactDetail.lastName, @"");
    XCTAssertEqual(@"081340154586", viewModel.contactDetail.phoneNumber, @"");
    XCTAssertEqual(@"budi@gmail.com", viewModel.contactDetail.email, @"");
    XCTAssertEqual([@YES boolValue], viewModel.contactDetail.isFavorite, @"");
}

- (void)testUpdateContactDetailInViewModel {
    ContactDetailModel *contactDetailUpdate = [[ContactDetailModel alloc] init];
    contactDetailUpdate.firstName = @"Bagus";
    contactDetailUpdate.lastName = @"Budiman";
    contactDetailUpdate.phoneNumber = @"08212121212";
    contactDetailUpdate.email = @"bagus@gmail.com";
    
    NSDictionary *dict = @{@"id":@"1732",@"first_name":@"50C",@"last_name":@"Cahyout",@"profile_pic":@"/images/missing.png",@"favorite":@YES, @"email":@"budi@gmail.com",@"phone_number":@"081340154586"};
    ContactDetailModel *contactDetail = [[ContactDetailModel alloc] initWithContactDetailDictionary:dict];
    ContactDetailViewModel *viewModel = [[ContactDetailViewModel alloc] initWithContactDetail:contactDetail];
    
    [viewModel updateContactDetail:contactDetailUpdate];
    XCTAssertEqual(@"Bagus", viewModel.contactDetail.firstName, @"");
    XCTAssertEqual(@"Budiman", viewModel.contactDetail.lastName, @"");
    XCTAssertEqual(@"08212121212", viewModel.contactDetail.phoneNumber, @"");
    XCTAssertEqual(@"bagus@gmail.com", viewModel.contactDetail.email, @"");
}

@end
