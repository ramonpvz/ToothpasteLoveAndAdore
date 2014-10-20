//
//  ViewController.m
//  ToothpasteLoveAndAdore
//
//  Created by GLBMXM0002 on 10/16/14.
//  Copyright (c) 2014 globant. All rights reserved.
//

#import "AdoredToothpastesViewController.h"
#import "ToothpastesTableViewController.h"

@interface AdoredToothpastesViewController () <UITableViewDelegate, UITableViewDataSource>

@property NSMutableArray *adoredToothpastes;
@property (weak, nonatomic) IBOutlet UITableView *adoredTableView;
@end

@implementation AdoredToothpastesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self load];
    if (self.adoredToothpastes == nil) {
        self.adoredToothpastes = [NSMutableArray  array];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.adoredToothpastes.count;
}

-(UITableViewCell * ) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCellID"];
    cell.textLabel.text = [self.adoredToothpastes objectAtIndex:indexPath.row];
    return cell;
}

-(NSURL *) documetsDirectory {
    NSFileManager *fileManager = [NSFileManager defaultManager]; //Returns a "Singletone"
    NSArray *files = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]; //As for a URL using Domain Mask
    return files.firstObject; //Asking for all the local directories (Universal Resource Locator)
}

-(void) load {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSURL *pList = [[self documetsDirectory] URLByAppendingPathComponent:@"pastes.pList"];
    
    self.adoredToothpastes = [NSMutableArray arrayWithContentsOfURL:pList]; //This will allows to load our pList
    NSLog(@"date: %@", [userDefaults objectForKey:@"LastSaved"]);
    
}

-(void) save {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSURL *pList = [[self documetsDirectory] URLByAppendingPathComponent:@"pastes.pList"];
    
    [self.adoredToothpastes writeToURL:pList atomically:YES];
    [userDefaults setObject:[NSDate date] forKey:@"LastSaved"];
    [userDefaults synchronize];
    
}

-(IBAction)unwindToothpasteViewController:(UIStoryboardSegue *)segue
{
    ToothpastesTableViewController *viewController = segue.sourceViewController;
    [self.adoredToothpastes addObject:[viewController adoredToothpaste]]; //Calling the method added on ToothpastesVC..
    [self.adoredTableView reloadData];
    [self save];
}

@end
