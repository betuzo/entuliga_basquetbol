//
//  PartidosViewController.h
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 12/10/11.
//  Copyright 2011 Valle del Bit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasquetbolService.h"
#import "JugadorCellView.h"

@interface PartidosViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>
{
    BasquetbolService * service;
    NSMutableArray * equipos;
}

@property(nonatomic, retain)BasquetbolService * service;

-(void)setEquipos:(NSMutableArray *) losEquipos;

-(NSMutableArray *) equipos;

@end