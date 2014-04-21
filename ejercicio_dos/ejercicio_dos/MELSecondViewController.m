//
//  MELSecondViewController.m
//  ejercicio_dos
//
//  Created by Lorena Pressiani on 4/20/14.
//  Copyright (c) 2014 Lorena Pressiani. All rights reserved.
//

#import "MELSecondViewController.h"

@interface MELSecondViewController ()

@end

@implementation MELSecondViewController
@synthesize musicList;

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

    self.musicList = [self makeMusicList];
    //[self.musicList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"newFriendCell"];
    [self.view addSubview:self.musicList];

}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)musicList{
    return 1;
}

- (NSInteger) tableView: (UITableView *) musicList numberOfRowsInSection: (NSInteger) section{
    return [dataArray count];
}

//cómo se verá la tabla
- (UITableViewCell *) tableView: (UITableView *) musicList cellForRowAtIndexPath: (NSIndexPath *) indexPah{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.musicList dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [dataArray objectAtIndex:indexPah.row];

    return cell;
}


-(UITableView *)makeMusicList
{
    CGFloat x = 0;
    CGFloat y = 50;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - 50;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    musicList = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    
    musicList.rowHeight = 45;
    musicList.sectionFooterHeight = 22;
    musicList.sectionHeaderHeight = 22;
    musicList.scrollEnabled = YES;
    musicList.showsVerticalScrollIndicator = YES;
    musicList.userInteractionEnabled = YES;
    musicList.bounces = YES;
    
    musicList.delegate = self;
    musicList.dataSource = self; //[self returnTableContent];
    
    return musicList;
}


- (NSArray *)returnTableContent
{
    NSArray *musicArray =[NSArray arrayWithObjects:@"the one that got away", @"you make me", @"wake me up", nil];
    
    /*NSMutableDictionary *musicDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                            @"danceMusic", musicArray,
                                            nil];
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"league" ofType:@"plist"];
    [musicDictionary writeToFile:@"ejercicio_dos" atomically:YES];
    
    
    plistPath = [[NSBundle mainBundle] pathForResource:@"league" ofType:@"plist"];
    NSArray *contentArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    return contentArray;*/
    return musicArray;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
