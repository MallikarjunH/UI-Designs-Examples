//
//  ViewController.m
//  Show_Hide_Password_ObjC
//
//  Created by mallikarjun on 09/09/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *hideShow = [[UIButton alloc] initWithFrame:CGRectMake(0,0,20,20)];
    
    [hideShow setImage:[UIImage imageNamed:@"show"]  forState:UIControlStateNormal];
    
    self.passwordTexyField.secureTextEntry = YES;
    self.passwordTexyField.rightView = hideShow;
    self.passwordTexyField.rightViewMode = UITextFieldViewModeAlways;
    [hideShow addTarget:self action:@selector(hideShow:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)hideShow:(id)sender
{
    UIButton *hideShow = (UIButton *)self.passwordTexyField.rightView;
    
    if (!self.passwordTexyField.secureTextEntry)
    {
        self.passwordTexyField.secureTextEntry = YES;
        [hideShow setImage:[UIImage imageNamed:@"show"] forState:UIControlStateNormal];
    }
    else
    {
        self.passwordTexyField.secureTextEntry = NO;
        [hideShow setImage:[UIImage imageNamed:@"hide"] forState:UIControlStateNormal];
    }
    [self.passwordTexyField becomeFirstResponder];
}

- (IBAction)loginButtonClicked:(id)sender {
    
    NSLog(@"Cliked");
    // write logic for your login method
}
@end
