//
//  MoviesViewController.h
//  rottenTomatoes
//
//  Created by Rishit Shroff on 10/15/14.
//  Copyright (c) 2014 Rishit Shroff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *moviesTable;

@end
