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
    BasquetbolService * service;
    NSArray * infoEstadistica;
    Jugador * jugador;
    CGRect primeraPos;
    NSString * minuto;
    NSString * tipo;
    Jugador * jugadorEstadistica;
    NSArray * estadisticas;
}

@property (nonatomic, strong) IBOutlet UIPickerView * estadisticaPickerView;
@property (nonatomic, retain) BasquetbolService * service;
@property (nonatomic, strong) NSString * estadistica;
@property (nonatomic, strong) IBOutlet UITableView * tableEstadisticaView;

- (void) setJugador:(Jugador *) elJugador;
- (Jugador *) jugador;
- (void) presentaVistaInicial:(BOOL) si;
- (void) setEstadisticas:(NSArray *) lasEstadisticas;
- (NSArray *)estadisticas;

@end
