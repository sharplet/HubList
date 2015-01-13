//
//  ViewController.m
//  HubList
//
//  Created by Adam Sharp on 12/01/2015.
//  Copyright (c) 2015 Adam Sharp. All rights reserved.
//

#import "ViewController.h"
#import "HLTopRepositoriesUI.h"
#import "HLGitHubClient.h"
#import "HLGitHubRepository.h"

@interface ViewController ()
@property HLTopRepositoriesUI *ui;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.dataSource = self;

    HLGitHubClient *client = [HLGitHubClient new];
    self.ui = [[HLTopRepositoriesUI alloc] initWithRemoteGateway:client];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.ui addObserver:self forKeyPath:@"repositories" options:NSKeyValueObservingOptionNew context:nil];
    [self.ui refresh];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.ui removeObserver:self forKeyPath:@"repositories"];
    [super viewWillDisappear:animated];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"repositories"]) {
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ui.repositories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HLGitHubRepository *repository = self.ui.repositories[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Repository"];
    cell.textLabel.text = repository.name;
    return cell;
}

@end
