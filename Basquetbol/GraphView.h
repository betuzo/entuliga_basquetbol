//
//  GraphView.h
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 27/10/11.
//  Copyright (c) 2011 Valle del Bit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasquetbolService.h"

@class ValorEstadistico;
@interface GraphView : UIView

@property (nonatomic, strong) NSString * estadistica;
@property int totalX;
@property int totalY;

@end
