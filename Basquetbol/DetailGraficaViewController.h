//
//  DetailGraficaViewController.h
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 25/10/11.
//  Copyright (c) 2011 Valle del Bit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasquetbolService.h"
#import "GraphView.h"


@interface DetailGraficaViewController : UIViewController
{
    CALayer * layerGrafica;
}

@property (nonatomic, strong) IBOutlet UILabel * estadistica;

- (IBAction) selEstadisticaChanged:     (UISlider *) sender;

- (GraphView *) graficaByRect:(CGRect) frameGraphView;

@end
