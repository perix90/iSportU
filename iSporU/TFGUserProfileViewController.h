//
//  TFGUserProfileViewController.h
//  iSporU
//
//  Created by Pedro Gordillo Rios on 13/03/15.
//  Copyright (c) 2015 Pedro Gordillo Rios. All rights reserved.
//

@interface TFGUserProfileViewController : UIViewController<UIActionSheetDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UIPickerViewDelegate,UINavigationControllerDelegate>{ // Delegates
    
    IBOutlet UIScrollView *scroller;
}

// Here we declare all the properties we will use
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet SingleLineTextField *countryextField;
@property (strong, nonatomic) IBOutlet SingleLineTextField *cityextField;
@property (strong, nonatomic) IBOutlet SingleLineTextField *ageTextField;
@property (strong, nonatomic) IBOutlet SingleLineTextField *phoneTextField;
@property (strong, nonatomic) IBOutlet SingleLineTextField *FavouritesportTextField;
@property (strong, nonatomic) IBOutlet SingleLineTextField *levelTextField;
@property (strong, nonatomic) IBOutlet UIButton *addupdateprofileButton;
@property (strong, nonatomic) IBOutlet UIImageView *profileimageImageView;
@property (strong, nonatomic) IBOutlet UIButton *selectPicButton;


// Here we declare all the Actions triggered in the class
- (IBAction)saveProfile:(id)sender;
- (IBAction)selectPhoto:(UIButton *)sender;
- (IBAction)deleteUser:(id)sender;




@end
