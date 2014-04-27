//
//  MELItemsViewController.h
//  ejercicio_tres
//
//  Created by Lorena Pressiani on 4/26/14.
//  Copyright (c) 2014 Lorena Pressiani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MELItemsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSArray *dataArray;
}

@property (strong, nonatomic) IBOutlet UITableView *itemsTable;

@end
