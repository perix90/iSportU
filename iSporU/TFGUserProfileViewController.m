//
//  TFGUserProfileViewController.m
//  iSporU
//
//  Created by Pedro Gordillo Rios on 13/03/15.
//  Copyright (c) 2015 Pedro Gordillo Rios. All rights reserved.
//

#import "TFGUserProfileViewController.h"
#import "AZNotification.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface TFGUserProfileViewController ()

@end

@implementation TFGUserProfileViewController

// We need to synthesize the properties declared in the header file
@synthesize nameLabel;
@synthesize countryextField;
@synthesize cityextField;
@synthesize ageTextField;
@synthesize phoneTextField;
@synthesize FavouritesportTextField;
@synthesize levelTextField;
@synthesize addupdateprofileButton;

// These are all the implementation codes for the Actions to be performed
- (IBAction)selectPhoto:(UIButton *)sender{
    
    // This block is basically to say that we will be using the photolibrary to get the user picture
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}
- (IBAction)deleteUser:(id)sender {
    
    // First we need to get the current user in order to delete it
    PFUser *currentUser = [PFUser currentUser];
    // We have to check whether the user has been securely authenticated via Parse secure login
    if(currentUser.isAuthenticated){
        
        // We perfom a query to delete all the events CREATED by the User.
        PFQuery *querytodeletecreatedevent = [PFQuery queryWithClassName:@"Event"];
        [querytodeletecreatedevent whereKey:@"Username" equalTo:currentUser.username];
        [querytodeletecreatedevent findObjectsInBackgroundWithBlock:^(NSArray *Events, NSError *error) {
            if (!error)
            {
                for (PFObject *Event in Events) // We search an Event in the Events array
                {
                    [Event deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {}];
                }
                
            }
            
            
        }];
        
        // We perfom a query to delete all the events which the User has JOINED in.
        PFQuery *querytodeletejoinedevent = [PFQuery queryWithClassName:@"Event"];
        [querytodeletejoinedevent whereKey:@"Participants" equalTo:currentUser.username];
        [querytodeletejoinedevent findObjectsInBackgroundWithBlock:^(NSArray *Events, NSError *error) {
            if (!error)
            {
                
                
                for (PFObject *Event in Events) {
                    
                    NSMutableArray *arrayofParticipants = nil;
               
                    arrayofParticipants = [Event valueForKey:@"Participants"];
                    [arrayofParticipants removeObject:currentUser.username];
                    
                    
                    
                    [Event setObject:arrayofParticipants forKey:@"Participants"];
                    [Event incrementKey:@"Vacants" byAmount:[NSNumber numberWithInt:+1]];
                    [Event saveInBackground];
                }
            }
            
            
        }];
        
        
        // Once all the created and joined events have been deteles, we detele the User
        [currentUser deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        }];
        
        [PFUser logOut];
  
        
    }


}
- (IBAction)saveProfile:(id)sender {
    
    // First we create an Object (an actual User profile) assigned to the current User
    PFObject *UserProfile = [PFUser currentUser];
    // We add the values of the text fields to the Parse columns
    [UserProfile setObject:countryextField.text forKey:@"Country"];
    [UserProfile setObject:cityextField.text forKey:@"City"];
    [UserProfile setObject:ageTextField.text forKey:@"Age"];
    [UserProfile setObject:phoneTextField.text forKey:@"Phone"];
    [UserProfile setObject:FavouritesportTextField.text forKey:@"FavouriteSport"];
    [UserProfile setObject:levelTextField.text forKey:@"Level"];
    
    NSData *imageData = UIImagePNGRepresentation(self.profileimageImageView.image);
    PFFile *imageFile = [PFFile fileWithName:@"Profileimage.png" data:imageData];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            if (succeeded) {
                PFUser *user = [PFUser currentUser];
                user[@"Picture"] = imageFile;
                [user saveInBackground];
            }
        } else {
            // Handle error
        }
    }];
    
    // We commit all the adds made just previously
    [UserProfile saveInBackground];
        
    // Shows off a notification saying that the profile has been updated
    [AZNotification showNotificationWithTitle:@"Perfil actualizado" controller:self notificationType:AZNotificationTypeSuccess shouldShowNotificationUnderNavigationBar:YES];
    
    
    
    
}

// This methods belong to the ImagePicker delegate methods. Used to handle the Action of picking an image, among other stuff
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    self.profileimageImageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

// The viewDidLoad methods is a special method. It triggers whatever is inside this methods just when the view has been lodaded
- (void)viewDidLoad{
    [super viewDidLoad];
   
    // We must query the current user to load the user information
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" equalTo:[[PFUser currentUser]username]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (NSObject *object in objects){
            
                countryextField.text = [object valueForKey:@"Country"];
                cityextField.text = [object valueForKey:@"City"];
                ageTextField.text = [object valueForKey:@"Age"];
                phoneTextField.text = [object valueForKey:@"Phone"];
                FavouritesportTextField.text = [object valueForKey:@"FavouriteSport"];
                levelTextField.text = [object valueForKey:@"Level"];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    PFQuery *queryUser = [PFUser query];
    if(queryUser != nil){
        [queryUser whereKey:@"username" equalTo:[[PFUser currentUser] username]];
        [queryUser getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
            
            //Cargo la imagen de la celda
            PFFile *theImage = [object objectForKey:@"Picture"];
            NSData *imageData = [theImage getData];
            UIImage *profileImage = [UIImage imageWithData:imageData];
            
            if (profileImage == nil) {
                self.profileImage.image = [UIImage imageNamed:@"profil@2x.jpg"];
            } else {
                self.profileImage.image = profileImage;
            }
        }];
    }
    
    // we get the curren user's username to show it in a label
    PFUser *currentuser = [PFUser currentUser];
    nameLabel.text = currentuser.username;
    
    
    
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// This method is just for hiding the keyboard by tapping anywhere in the screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end



