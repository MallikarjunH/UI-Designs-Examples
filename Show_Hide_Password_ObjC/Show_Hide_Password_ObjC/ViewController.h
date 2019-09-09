//
//  ViewController.h
//  Show_Hide_Password_ObjC
//
//  Created by mallikarjun on 09/09/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTexyField;

- (IBAction)loginButtonClicked:(id)sender;


@end

