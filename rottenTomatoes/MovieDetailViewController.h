//
//  MovieDetailViewController.h
//  rottenTomatoes
//
//  Created by Rishit Shroff on 10/19/14.
//  Copyright (c) 2014 Rishit Shroff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailViewController : UIViewController
@property (nonatomic, weak) NSDictionary *movie;
@property (nonatomic, weak) UIImage *image;

@property (strong, nonatomic) IBOutlet UIScrollView *scroller;

@property (strong, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UIImageView *poster;

@property (strong, nonatomic) IBOutlet UILabel *details;

@property (strong, nonatomic) IBOutlet UILabel *cast;
@end
