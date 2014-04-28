//
//  MELViewController.m
//  ejercicio_tres
//
//  Created by Lorena Pressiani on 4/24/14.
//  Copyright (c) 2014 Lorena Pressiani. All rights reserved.
//

#import "MELViewController.h"
#import "MELItemsViewController.h"

@interface MELViewController ()

@property (nonatomic, strong) NSMutableData   *buffer;

@property (nonatomic, strong) NSURLConnection *connection;

@end

@implementation MELViewController

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
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)itemsTable{
    NSLog(@"%@", @"llegó a numberOfSectionsInTableView");
    return 1;
}

- (NSInteger) tableView: (UITableView *) itemsTable numberOfRowsInSection: (NSInteger) section{
    NSLog(@"%@", @"llegó a numberOfRowsInSection");
    return [dataArray count];
}

//cómo se verá la tabla
- (UITableViewCell *) tableView: (UITableView *) itemsTable cellForRowAtIndexPath: (NSIndexPath *) indexPah{
    NSLog(@"%@", @"llegó a cómo se verá la tabla");
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.itemsTable dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    /*cell.textLabel.text = [dataArray objectAtIndex:indexPah.row];
    
    NSArray *results = dataArray;
    for ( NSDictionary *theItem in results )
    {
        NSLog(@"----");
        NSLog(@"Title in cell: %@", theItem[@"title"] );
        NSLog(@"Price in cell: %@", theItem[@"price"] );
        NSLog(@"Image in cell: %@", theItem[@"thumbnail"] );
        NSLog(@"----");
    }*/

    
    NSDictionary *item = (NSDictionary *)[dataArray objectAtIndex:indexPah.row];
    //NSLog(@"%@", item);
    
    NSLog(@"%@", [item objectForKey:@"title"]);
    NSLog(@"%@", [item objectForKey:@"price"]);
    
    cell.textLabel.text = [item objectForKey:@"title"];
    
    //cell.detailTextLabel.text = [item objectForKey:@"price"];  Esto no anda porque era un nro y la celda string
    
    NSString *priceString = [NSString stringWithFormat:@"$ %@", [item objectForKey:@"price"]];
    
    cell.detailTextLabel.text = priceString;
    
    
    NSString * urlString = [item objectForKey:@"thumbnail"];
    NSURL *imageURL = [NSURL URLWithString:urlString];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *theImage = [UIImage imageWithData:imageData];
    
    cell.imageView.image = theImage;
    
    return cell;
}

//handler evet for UITableViewCellAccessoryDetailDisclosureButton
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", @"llegó a accessoryButtonTappedForRowWithIndexPath");
    
    /* inizialicing items list view*/
    MELItemsViewController *itemsView = [[MELItemsViewController alloc] initWithNibName:nil                                              bundle:nil];
    
    /*set title inizialized view*/
    NSString *searchTitleString = @"Searching ";
     
    NSString *itemString = self.inputItem.text;
     
    itemsView.title = [searchTitleString stringByAppendingString:itemString];
    
    /*pushing new view*/
    [self.navigationController pushViewController:itemsView
     animated:YES];

}


-(UITableView *)makeItemsTable
{
    NSLog(@"%@", @"llegó a makeItemsTable");
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
    
    
     NSError *error;
     NSDictionary *allItems = [NSJSONSerialization
     JSONObjectWithData:self.buffer
     options:kNilOptions
     error:&error];
     
     if( error )
     {
         NSLog(@"%@", [error localizedDescription]);
     }
     else {
         results = allItems[@"results"];
         /*for ( NSDictionary *theItem in results )
         {
             NSLog(@"----");
             NSLog(@"Title: %@", theItem[@"title"] );
             NSLog(@"Price: %@", theItem[@"price"] );
             NSLog(@"Image: %@", theItem[@"thumbnail"] );
             NSLog(@"----");
         }*/
     }
    
     //NSLog(@"%@", results);
    return results;
    
}


- (IBAction)findItem:(id)sender {
    /* disable the fetch button during the request */
    [self.findItem setEnabled:NO];
    
    /* begin animating the spinner */
    [self.loadingControl startAnimating];
    
    NSString *urlString = @"https://api.mercadolibre.com/sites/MLA/search?q=";
    NSString *itemString = self.inputItem.text;
    urlString = [urlString stringByAppendingString:itemString];
    NSLog(@"%@", urlString);
    
    /* create the request */
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    /* create the connection */
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    /* ensure the connection was created */
    if (self.connection)
    {
        /* initialize the buffer */
        self.buffer = [NSMutableData data];
        
        /* start the request */
        [self.connection start];
    }
    else
    {
        self.inputItem.text = @"Connection Failed";
    }
    
    
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

    /* clear the connection &amp; the buffer */
    
    self.connection = nil;
    
    self.buffer     = nil;

    self.inputItem.text = [error localizedDescription];
    
    NSLog(@"Connection failed! Error - %@ %@",
          
    [error localizedDescription],
          
    [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);

}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    /* reset the buffer length each time this is called */
    [self.buffer setLength:0];
}




- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    /* Append data to the buffer */
    [self.buffer appendData:data];
    
    /* Append data to item view object*/
    [dataDetailItem appendData: data];
}





- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    /* dispatch off the main queue for json processing */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSError *error = nil;
        NSString *jsonString = [[NSJSONSerialization JSONObjectWithData:_buffer options:0 error:&error] description];
        
        /* dispatch back to the main queue for UI */
        dispatch_async(dispatch_get_main_queue(), ^{
            
            /* check for a JSON error */
            if (!error)
            {
                //NSLog(@"%@", jsonString);
                //self.inputItem.text = jsonString;
                self.itemsTable = [self makeItemsTable];
                dataArray = [self returnTableContent];
                [self.view addSubview:self.itemsTable];

            }
            else
            {
                self.inputItem.text = [error localizedDescription];
                            }
            
            /* stop animating &amp; re-enable the fetch button */
            [self.loadingControl stopAnimating];
            [self.findItem setEnabled:YES];
            
            /* clear the connection &amp; the buffer */
            self.connection = nil;
            self.buffer     = nil;
        });
        
    });
}


@end
