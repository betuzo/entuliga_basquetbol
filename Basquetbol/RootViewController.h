//
//  RootViewController.h
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 10/10/11.
//  Copyright 2011 Valle del Bit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasquetbolService.h"
#import "JugadorCellView.h"

@interface RootViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>
{
    BasquetbolService * service;
    NSMutableArray * equipos;
}

@property(nonatomic, retain)BasquetbolService * service;

@end
