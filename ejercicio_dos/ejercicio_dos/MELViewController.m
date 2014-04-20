//
//  MELViewController.m
//  ejercicio_dos
//
//  Created by Lorena Pressiani on 4/19/14.
//  Copyright (c) 2014 Lorena Pressiani. All rights reserved.
//

#import "MELViewController.h"
#import "MELSecondViewController.h"

@interface MELViewController ()

@end

@implementation MELViewController

- (IBAction)doSomething:(id)sender {
    
    if (self.textToSendToAlert.text.length <= 10) {
        
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Ejercicio 2"
        message:self.textToSendToAlert.text
        delegate:nil
        cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
    
    [message show];
    }
    
}

- (IBAction)showSecondView:(UIButton *)sender {
    
    MELSecondViewController *nextView = [[MELSecondViewController alloc] initWithNibName:nil
        bundle:nil];
    
    nextView.title = self.textToSendToAlert.text;
    
    [self.navigationController pushViewController:nextView
        animated:YES];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
