//
//  BasquetbolAppDelegate.h
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 10/10/11.
//  Copyright 2011 Valle del Bit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "BasquetbolService.h"

@interface BasquetbolAppDelegate : NSObject <UIApplicationDelegate>
{
    BasquetbolService * serviceBasquetbol;
}
@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@end
