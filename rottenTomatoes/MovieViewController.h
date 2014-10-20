//
//  MovieViewController.h
//  rottenTomatoes
//
//  Created by Rishit Shroff on 10/16/14.
//  Copyright (c) 2014 Rishit Shroff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) NSDictionary *movieDictonary;
@end
