//
//  MELViewController.h
//  ejercicio_dos
//
//  Created by Lorena Pressiani on 4/19/14.
//  Copyright (c) 2014 Lorena Pressiani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MELViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UITextField *textToSendToAlert;

- (IBAction)doSomething:(id)sender;

- (IBAction)showSecondView:(UIButton *)sender;

@end
