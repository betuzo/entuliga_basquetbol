//
//  DetailEstadisticaViewController.h
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 20/10/11.
//  Copyright (c) 2011 Valle del Bit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasquetbolService.h"

@interface DetailEstadisticaViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource,UITableViewDataSource, UITableViewDelegate>
{
    NSArray * infoEstadistica;
    CGRect primeraPos;
    NSString * minuto;
    NSString * tipo;
    Jugador * jugadorEstadistica;
}

@property (nonatomic, strong) IBOutlet UIPickerView * estadisticaPickerView;
@property (nonatomic, strong) NSString * estadistica;
@property (nonatomic, strong) IBOutlet UITableView * tableEstadisticaView;

- (void) presentaVistaInicial:(BOOL) si;

@end
