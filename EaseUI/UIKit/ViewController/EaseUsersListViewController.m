/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "EaseUsersListViewController.h"

#import "UIViewController+HUD.h"
#import "EaseMessageViewController.h"

@interface EaseUsersListViewController ()

@property (strong, nonatomic) UISearchBar *searchBar;

@end

@implementation EaseUsersListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter

- (void)setShowSearchBar:(BOOL)showSearchBar
{
    if (_showSearchBar != showSearchBar) {
        _showSearchBar = showSearchBar;
        
//        if (_showSearchBar) {
//            <#statements#>
//        }
//        else{
//            
//        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        if ([_dataSource respondsToSelector:@selector(numberOfRowInUserListViewController:)]) {
            return [_dataSource numberOfRowInUserListViewController:self];
        }
        return 0;
    }
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [EaseUserCell cellIdentifierWithModel:nil];
    EaseUserCell *cell = (EaseUserCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[EaseUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        return nil;
    } else {
        id<IUserModel> model = nil;
        if ([_dataSource respondsToSelector:@selector(userListViewController:userModelForIndexPath:)]) {
            model = [_dataSource userListViewController:self userModelForIndexPath:indexPath];
        }
        else {
            model = [self.dataArray objectAtIndex:indexPath.row];
        }
        
        if (model) {
            cell.model = model;
        }
        
        return cell;
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [EaseUserCell cellHeightWithModel:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id<IUserModel> model = nil;
    if (_dataSource && [_dataSource respondsToSelector:@selector(userListViewController:userModelForIndexPath:)]) {
        model = [_dataSource userListViewController:self userModelForIndexPath:indexPath];
    }
    else {
        model = [self.dataArray objectAtIndex:indexPath.row];
    }
    
    if (model) {
        if (_delegate && [_delegate respondsToSelector:@selector(userListViewController:didSelectUserModel:)]) {
            [_delegate userListViewController:self didSelectUserModel:model];
        } else {
            EaseMessageViewController *viewController = [[EaseMessageViewController alloc] initWithConversationChatter:model.buddy conversationType:EMConversationTypeChat];
            viewController.title = model.nickname;
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }}

#pragma mark - data

- (void)tableViewDidTriggerHeaderRefresh
{
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = nil;
        NSArray *buddyList = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
        if (!error) {
            [weakself.dataArray removeAllObjects];
            NSMutableArray *contactsSource = [NSMutableArray arrayWithArray:buddyList];
            
            //从获取的数据中剔除黑名单中的好友
            NSArray *blockList = [[EMClient sharedClient].contactManager getBlackListFromDB];
            for (NSInteger i = (buddyList.count - 1); i >= 0; i--) {
                NSString *buddy = [buddyList objectAtIndex:i];
                if (![blockList containsObject:buddy]) {
                    [contactsSource addObject:buddy];
                    
                    id<IUserModel> model = nil;
                    if (weakself.dataSource && [weakself.dataSource respondsToSelector:@selector(userListViewController:modelForBuddy:)]) {
                        model = [weakself.dataSource userListViewController:self modelForBuddy:buddy];
                    }
                    else{
                        model = [[EaseUserModel alloc] initWithBuddy:buddy];
                    }
                    
                    if(model){
                        [weakself.dataArray addObject:model];
                    }
                }
            }
        }
        [weakself tableViewDidFinishTriggerHeader:YES reload:YES];
    });
}

- (void)dealloc
{
}

@end
