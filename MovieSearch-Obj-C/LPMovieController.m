//
//  LPMovieController.m
//  MovieSearch-Obj-C
//
//  Created by Luis Puentes on 7/25/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

#import "LPMovieController.h"
#import "LPMovie.h"

static NSString *const apiKey = @"cf80709bde7dcdd88536ad899c954660";

@interface LPMovieController()

@property (nonatomic, copy) NSString *baseURLString;
@property (nonatomic, copy) NSString *imageURLString;

@end

@implementation LPMovieController

- (instancetype)init {
    if (self) {
        _baseURLString = @"https://api.themoviedb.org/3/search/movie";
        _imageURLString = @"http://image.tmdb.org/t/p/w500";
    }
    return self;
}

+ (LPMovieController *)shared
{
    static LPMovieController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [LPMovieController new];
    });
    return shared;
}

// Fetch Movies

- (void)fetchMovieForSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray * movies))completion
{
    if (!completion) { completion = ^(NSArray *p){}; }
    
    NSURL *baseURL = [[NSURL alloc] initWithString:self.baseURLString];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:true];
    
    NSURLQueryItem *apiKeyItem = [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey];
    NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:@"query" value:searchTerm];
    
    NSArray *queryItems = @[apiKeyItem, queryItem];
    urlComponents.queryItems = queryItems;
    NSURL *movieResultEndpoint = urlComponents.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:movieResultEndpoint completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error %@", error);
            completion(nil);
        }
        
        if (!data) {
            NSLog(@"Error, no data returned.");
            completion(nil);
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!jsonDictionary) {
            NSLog(@"JSON could not be serialized");
            completion(nil);
        }
        
        // Add JSON to the movie array
        NSArray *movieDictionary = jsonDictionary[@"results"];
        NSMutableArray *movies = [NSMutableArray new];
        
        for (NSDictionary *movie in movieDictionary) {
            LPMovie *newMovie = [[LPMovie alloc]initWithDictionary:movie];
            if (newMovie) {
                [movies addObject:newMovie];
            }
        }
        completion(movies);
    }]resume];
}
// Fetching movie images
- (void)fetchMovieImage:(NSString *)imageURLString completion:(void (^)(UIImage *))completion
{
    if (!completion) { completion = ^(UIImage *p){}; }
    
    NSURL *imageURL = [[NSURL alloc]initWithString:self.imageURLString];
    NSURL *imageEndpoint = [imageURL URLByAppendingPathComponent:imageURLString];
    
    [[[NSURLSession sharedSession]dataTaskWithURL:imageEndpoint completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error){
            NSLog(@"Error handling image: %@", error);
            completion(nil);
        }
        
        if (!data) {
            NSLog(@"Error: No data received from image task");
            completion(nil);
        }
        
        UIImage *moviePoster = [[UIImage alloc]initWithData:data];
        completion(moviePoster);
    }]resume];
}

- (NSString *)fetchAPIFromPlist
{
    NSURL *apiKeyPlistURL = [[NSBundle mainBundle]URLForResource:@"APIKeys" withExtension:@"plist"];
    if (!apiKeyPlistURL) {
        NSLog(@"Error: API Key not found");
        return nil;
    }
    
    NSDictionary *apiKeys = [[NSDictionary alloc]initWithContentsOfURL:apiKeyPlistURL];
    NSString *apiKey= apiKeys[@"APIKey"];
    return apiKey;
}

@end








