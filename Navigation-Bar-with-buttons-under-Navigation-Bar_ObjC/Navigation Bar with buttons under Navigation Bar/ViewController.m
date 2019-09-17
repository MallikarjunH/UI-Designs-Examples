//
//  ViewController.m
//  Navigation Bar with buttons under Navigation Bar
//
//  Created by Mallikarjun on 09/05/18.
//  Copyright © 2018 Mallikarjun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
     UINavigationBar*  navbar;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    navbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 50)];
    navbar.barTintColor = [UIColor whiteColor];
    
    
     // Step 2 : Adding title and changing its color
//    /* Create navigation item object & set the title of navigation bar. */
//    UINavigationItem* navItem = [[UINavigationItem alloc] initWithTitle:@"New Title"];
//
//    /* changing color of tile on navigation bar */
//    navbar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor yellowColor]};
//
//    //*****End
    
    
    
    // Step 3 : Adding button on left and right
    
    // ********** butttons with text button ************
//    /* Create left button item. */
//    UIBarButtonItem* cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onTapCancel)];
//    navItem.leftBarButtonItem = cancelBtn;
//
//    /* Create left button item. */
//    UIBarButtonItem* doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onTapDone)];
//    navItem.rightBarButtonItem = doneBtn;
    
    // ********** butttons with text button end ************
    
    
    //*****buttons with image and adjusting size of it *********
    
    UINavigationItem* navItem = [[UINavigationItem alloc] init];
    
    UIImage *image1 = [UIImage imageNamed:@"ic_file_upload2_2x.png"];
    UIImage *image2 = [UIImage imageNamed:@"ic_notifications2_2x.png"];
    UIImage *image5 = [UIImage imageNamed:@"ic_search2_2x.png"];
    
    
    UIBarButtonItem *button1 = [[UIBarButtonItem alloc] initWithImage:image5 style:UIBarButtonItemStylePlain  target:self action:@selector(onTapDone)];
    navItem.leftBarButtonItem = button1;
    
    
    UIBarButtonItem *button2 = [[UIBarButtonItem alloc] initWithImage:image2 style:UIBarButtonItemStylePlain  target:self action:@selector(onTapDone)]; //@selector(onNavButtonTapped:event:)];
    navItem.rightBarButtonItem = button2;
    
    
    
    
    //chnaging size of img
    CGRect rect = CGRectMake(0,0,26,26);
    UIGraphicsBeginImageContext( rect.size );
    [image1 drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImagePNGRepresentation(picture1);
    UIImage *img3=[UIImage imageWithData:imageData];
    
    UIImageView* img = [[UIImageView alloc] initWithImage:img3];
    
    //giving action to image
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapDone)];
    singleTap.numberOfTapsRequired = 1;
    [img setUserInteractionEnabled:YES];
    [img addGestureRecognizer:singleTap];
    
    
    navItem.titleView = img;
    
    
    
    // **********end buttton with image ************
    
    
    
    /* Assign the navigation item to the navigation bar.*/
    [navbar setItems:@[navItem]];
    
    // to add and show this new navigation on view
    [self.view addSubview:navbar];
  
    
    navbar.hidden=YES;
    
    
    
}

-(void)onTapCancel
{
    NSLog(@"clicked");
}
-(void)onTapDone
{
    NSLog(@"clicked");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showNavigation:(id)sender {
    
     navbar.hidden=NO;
}

- (IBAction)hideNavigation:(id)sender {
    
     navbar.hidden=YES;
}
@end
