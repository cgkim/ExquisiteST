//
//  MovieController.m
//  ExquisiteST
//
//  Created by kim on 13-10-16.
//
//

#import "MovieController.h"

@interface MovieController ()

@end

@implementation MovieController


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIDeviceOrientationLandscapeLeft);
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

@end
