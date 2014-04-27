//
//  MELItemsViewController.m
//  ejercicio_tres
//
//  Created by Lorena Pressiani on 4/26/14.
//  Copyright (c) 2014 Lorena Pressiani. All rights reserved.
//

#import "MELItemsViewController.h"
#import "MELViewController.h"

@interface MELItemsViewController ()

@end

@implementation MELItemsViewController

@synthesize itemsTable;

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
    
    dataArray = [self returnTableContent];
    
    self.itemsTable = [self makeItemsTable];
    //[self.musicList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"newFriendCell"];
    [self.view addSubview:self.itemsTable];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)itemsTable{
    return 1;
}

- (NSInteger) tableView: (UITableView *) itemsTable numberOfRowsInSection: (NSInteger) section{
    return [dataArray count];
}

//cómo se verá la tabla
- (UITableViewCell *) tableView: (UITableView *) itemsTable cellForRowAtIndexPath: (NSIndexPath *) indexPah{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.itemsTable dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [dataArray objectAtIndex:indexPah.row];
    
    return cell;
}


-(UITableView *)makeItemsTable
{
    CGFloat x = 0;
    CGFloat y = 50;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - 50;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    itemsTable = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    
    itemsTable.rowHeight = 45;
    itemsTable.sectionFooterHeight = 22;
    itemsTable.sectionHeaderHeight = 22;
    itemsTable.scrollEnabled = YES;
    itemsTable.showsVerticalScrollIndicator = YES;
    itemsTable.userInteractionEnabled = YES;
    itemsTable.bounces = YES;
    
    itemsTable.delegate = self;
    itemsTable.dataSource = self; //[self returnTableContent];
    
    return itemsTable;
}


- (NSArray *)returnTableContent
{
    NSLog(@"%@", @"llegó a returnTableContent");
    
    NSArray *results;
    
    
    /*NSError *error;
    NSDictionary *allItems = [NSJSONSerialization
                              JSONObjectWithData:MELViewController.dataDetailItem
                              options:kNilOptions
                              error:&error];
    
    if( error )
    {
        NSLog(@"%@", [error localizedDescription]);
    }
    else {
        results = allItems[@"results"];*/
        /*for ( NSDictionary *theItem in results )
         {
         NSLog(@"----");
         NSLog(@"Title: %@", theItem[@"title"] );
         NSLog(@"Price: %@", theItem[@"price"] );
         NSLog(@"Image: %@", theItem[@"thumbnail"] );
         NSLog(@"----");
         }
    }*/
    
    //NSLog(@"%@", results);
    return results;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
