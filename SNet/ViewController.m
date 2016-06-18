//
//  ViewController.m
//  SNet
//
//  Created by Claudia Toh Yi An on 18/6/16.
//  Copyright © 2016 Claudia Toh. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *inputTextField;
- (void) configureInputTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureInputTextField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) alertMessagePopUp: (NSString*) myMessage{
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:@"SocialShare" message:
                       myMessage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction: [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault
                                                       handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)actionButton:(id)sender {
    if([self.inputTextField isFirstResponder]){
        [self.inputTextField resignFirstResponder];
    }
    
    UIAlertController *actionController  = [UIAlertController alertControllerWithTitle:@"" message:@"Your tweet..." preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController: actionController
                       animated:YES completion:nil];
    UIAlertAction *cancelAction  = [UIAlertAction actionWithTitle:@"Cancel"style:
                                    UIAlertActionStyleDefault handler:nil];
    //handler nil removes the ui.
    UIAlertAction *tweetAction  = [UIAlertAction actionWithTitle:@"Tweet"style:
                                    UIAlertActionStyleDefault handler:^(UIAlertAction
                                                                        *testUserSignIn){
                                    if ([SLComposeViewController isAvailableForServiceType:
                                             SLServiceTypeTwitter]){
                                            SLComposeViewController *TwitterVC =
                                            [SLComposeViewController
                                             composeViewControllerForServiceType:
                                             SLServiceTypeTwitter];
                                        if([self.inputTextField.text length] <140){
                                            //Tweet succession.
                                                [TwitterVC setInitialText:self.inputTextField.text];
                                            
                                        }else{
                                            NSString *shortText = [self.inputTextField.text
                                                                   substringToIndex:140];
                                            [TwitterVC setInitialText:shortText];
                                            [self presentViewController:TwitterVC
                                                               animated:YES completion:nil];
                                        
                                        }
                                    }
                                    else{
                                            
                                            //Raise objection.
                                            [self alertMessagePopUp:@"Sign in to twitter"];
                                                                         }
                                        
                                        }
                                        ];
    UIAlertAction *facebookAction  = [UIAlertAction actionWithTitle:@"Post to Facebook"style:
                                   UIAlertActionStyleDefault handler:^(UIAlertAction
                                                                       *testUserSignIn){
                                       if ([SLComposeViewController isAvailableForServiceType:
                                            SLServiceTypeFacebook]){
                                           SLComposeViewController *facebookVC =
                                           [SLComposeViewController
                                            composeViewControllerForServiceType:
                                            SLServiceTypeFacebook];
                                           [facebookVC setInitialText:self.inputTextField.text];

                                           [self presentViewController:facebookVC
                                                              animated:YES completion:nil];
                                            }
                                       
                                       else{
                                           
                                           //Raise objection.
                                           [self alertMessagePopUp:@"Sign in to Facebook"];
                                       }}];
    UIAlertAction *moreAction  = [UIAlertAction actionWithTitle:@"More..."style:
                                      UIAlertActionStyleDefault handler:^(UIAlertAction
                                                                          *testUserSignIn){
                                          UIActivityViewController *moreVC = [[UIActivityViewController
                                                                          alloc]
                                      initWithActivityItems:@[self.inputTextField.text]
                                                  applicationActivities:nil];
                                          [self presentViewController:moreVC animated:YES
                                                           completion:nil];
                                      }];
    
                                
    [actionController addAction:tweetAction];
    [actionController addAction:facebookAction];
    [actionController addAction:moreAction];
    [actionController addAction:cancelAction];

    
    
}
- (void) configureInputTextField{
    self.inputTextField.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0].CGColor;
    self.inputTextField.layer.cornerRadius = 10.0;
    self.inputTextField.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.inputTextField.layer.borderWidth = 2.0;
}

@end
