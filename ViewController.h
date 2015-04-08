//
//  ViewController.h
//  Register
//
//  Created by Rushik Shah on 08/04/15.
//  Copyright (c) 2015 Rushik Shah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UIButton *btnSave;
    IBOutlet UITextField *txtName;
    IBOutlet UITextField *txtMobile;
    IBOutlet UITextField *txtCity;
}
-(IBAction)btnSaveTapped:(id)sender;
@end

