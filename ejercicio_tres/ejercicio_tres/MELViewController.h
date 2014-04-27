//
//  MELViewController.h
//  ejercicio_tres
//
//  Created by Lorena Pressiani on 4/24/14.
//  Copyright (c) 2014 Lorena Pressiani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MELViewController : UIViewController <NSURLConnectionDataDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSArray *dataArray;
    NSMutableData *dataDetailItem;
}


@property (strong, nonatomic) IBOutlet UIButton *findItem;

- (IBAction)findItem:(id)sender;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingControl;

@property (strong, nonatomic) IBOutlet UITextField *inputItem;

@property (strong, nonatomic) IBOutlet UITableView *itemsTable;


@end
