//
// Created by Aakash Apoorv on 27/9/15.
// Copyright (c) 2015 Deloitte. All rights reserved.
//

#import "RKLeftMenuViewController.h"
#import "RKLoginViewController.h"
#import "UIViewController+RESideMenu.h"
#import "RKSessionAgent.h"

@interface RKLeftMenuViewController ()

@property (strong, readwrite, nonatomic) UITableView *tableView;
@property (readwrite, nonatomic) NSInteger isLoggedIn;

@end

@implementation RKLeftMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    RKSessionAgent *session = [RKSessionAgent sharedManager];
    self.isLoggedIn = session.isLoggedin;

    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 5) / 2.0f, self.view.frame.size.width, 54 * 5) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView.scrollsToTop = NO;
        tableView;
    });
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    RKSessionAgent *session = [RKSessionAgent sharedManager];
    self.isLoggedIn = session.isLoggedin;
    [self.tableView reloadData];
}

- (void) doLogout
{
    RKSessionAgent *session = [RKSessionAgent sharedManager];
    session.isLoggedin = 0;
    session.session = @"nilSession";
    [self.tableView reloadData];
    NSLog(@"Loged Out");
}
#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.isLoggedIn == 1) {
        switch (indexPath.row) {
            case 0:
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"photoViewController"]]
                                                             animated:YES];
                [self.sideMenuViewController hideMenuViewController];
                break;
            case 1:
                [self doLogout];
                [self.sideMenuViewController hideMenuViewController];
                break;
            default:
                break;
        }
    } else {
            switch (indexPath.row) {
                case 0:
                    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"logInViewController"]]
                                                                 animated:YES];
                    [self.sideMenuViewController hideMenuViewController];

                case 1:
                    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"signUpViewController"]]
                                                                 animated:YES];
                    [self.sideMenuViewController hideMenuViewController];

                    break;
                default:
                    break;
        }
    }

}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    if (self.isLoggedIn == 1) {
        NSArray *titles = @[@"Report Incident", @"Log Out"];
        NSArray *images = @[@"IconHome", @"IconEmpty"];
        cell.textLabel.text = titles[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    } else {
        NSArray *titles = @[@"Login", @"Signup"];
        NSArray *images = @[@"IconProfile" , @"IconSettings"];
        cell.textLabel.text = titles[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    }


    return cell;
}

@end
