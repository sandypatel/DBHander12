//
//  ViewController.m
//  Register
//
//  Created by Rushik Shah on 08/04/15.
//  Copyright (c) 2015 Rushik Shah. All rights reserved.
//

#import "ViewController.h"
#import "DBManger.h"
@interface ViewController ()
{
    DBManger *objDBManger;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [txtName becomeFirstResponder];
    objDBManger=[[DBManger alloc]init];
    // Do any additional setup after loading the view, typically from a nib.
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    int length = [currentString length];
    if (length > 10) {
        return NO;
    }
    return YES;
}
-(IBAction)btnSaveTapped:(id)sender{
    if ([txtName.text isEqualToString:@""]) {
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please Enter Name" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alt show];
    }else if ([txtCity.text isEqualToString:@""]){
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please Enter City" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alt show];
    }else if ([txtMobile.text isEqualToString:@""]){
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please Enter Mobile Number" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alt show];
    }else{
         NSString *query = [NSString stringWithFormat:@"INSERT INTO TblRegister('Name','City','Mobile')VALUES('%@','%@','%@')",txtName.text,txtCity.text,txtMobile.text];
        [objDBManger insertData:query];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
