//
//  MoviesViewController.m
//  rottenTomatoes
//
//  Created by Rishit Shroff on 10/15/14.
//  Copyright (c) 2014 Rishit Shroff. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailViewController.h"
#import "SVProgressHUD.h"

NSString *kURL = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=emd747sju5m72r326hnebbp7";

@interface MoviesViewController ()

@property (strong, nonatomic) NSDictionary *moviesDictonary;
@property (strong, nonatomic) NSArray *movies;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) UILabel *networkError;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.moviesTable.delegate = self;
    self.moviesTable.dataSource = self;
    self.moviesTable.rowHeight = 120;
    
    [self addAndInitNetworkErrorLabel];

    [self.moviesTable addSubview:self.networkError];
    
    UINib *movieCellNib = [UINib nibWithNibName:@"MovieViewCell" bundle:nil];
    
    [self.moviesTable registerNib:movieCellNib forCellReuseIdentifier:@"MovieViewCell"];
    
    [SVProgressHUD show];    
    NSURL *url = [NSURL URLWithString:kURL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            self.moviesDictonary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.movies = self.moviesDictonary[@"movies"];
            [SVProgressHUD dismiss];
            [self.moviesTable reloadData];
            self.networkError.hidden = true;
        } else {
            [SVProgressHUD dismiss];
            self.networkError.hidden = false;
        }
    }];
    
    // Refresh Control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.moviesTable insertSubview:self.refreshControl atIndex:0];
}

- (void)onRefresh {
    NSURL *url = [NSURL URLWithString:kURL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        if (!connectionError) {
            self.moviesDictonary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.movies = self.moviesDictonary[@"movies"];
            [self.moviesTable reloadData];
            [SVProgressHUD dismiss];
            [self.refreshControl endRefreshing];
            self.networkError.hidden = true;
        } else {
            [SVProgressHUD dismiss];
            self.networkError.hidden = false;
            [self.refreshControl endRefreshing];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieViewCell* movie = [tableView dequeueReusableCellWithIdentifier:@"MovieViewCell" forIndexPath:indexPath];
    NSString *moviePosterURL = self.movies[indexPath.row][@"posters"][@"thumbnail"];
    
    [movie.poster setImageWithURL:[NSURL URLWithString:moviePosterURL]];
    movie.title.text = self.movies[indexPath.row][@"title"];
    movie.synopsis.text = self.movies[indexPath.row][@"synopsis"];
    
    return movie;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MovieViewCell *movie = (MovieViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    MovieDetailViewController *detailsView = [[MovieDetailViewController alloc] init];
    
    detailsView.movie = [self.movies objectAtIndex:indexPath.row];
    detailsView.image = movie.poster.image;
        
    [self.navigationController pushViewController:detailsView animated:YES];
}

- (void) addAndInitNetworkErrorLabel {
    self.networkError = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 380, 50)];
    self.networkError.textColor=[UIColor whiteColor];
    self.networkError.backgroundColor=[UIColor blackColor];
    self.networkError.text = @"Network Error";
    self.networkError.textAlignment = NSTextAlignmentCenter;
    self.networkError.hidden = true;
}

@end
