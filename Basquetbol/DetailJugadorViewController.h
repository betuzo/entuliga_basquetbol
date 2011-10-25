//
//  DetailJugadorViewController.h
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 14/10/11.
//  Copyright 2011 Valle del Bit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasquetbolService.h"
#import "Jugador.h"
#import "DetailJugadorCellView.h"
#import "DetailEstadisticaViewController.h"

@interface DetailJugadorViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UIImageView * imagenJugador; 
    UILabel * numero;
    UILabel * nombre;
    UILabel * apellido;
    UILabel * posicion;
    UILabel * estado;
}
@property(nonatomic, retain)IBOutlet UIImageView * imagenJugador;
@property(nonatomic, retain)IBOutlet UILabel * numero;
@property(nonatomic, retain)IBOutlet UILabel * nombre;
@property(nonatomic, retain)IBOutlet UILabel * apellido;
@property(nonatomic, retain)IBOutlet UILabel * posicion;
@property(nonatomic, retain)IBOutlet UILabel * estado;


- (void)showDetailJugador;

@end
