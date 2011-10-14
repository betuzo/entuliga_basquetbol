//
//  DetailPartidoController.h
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 13/10/11.
//  Copyright 2011 Valle del Bit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Partido.h"
#import "BasquetbolService.h"
#import "PartidosViewController.h"

@interface DetailPartidoController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    BasquetbolService * service;
    Partido * partido;
    
    UIImageView * imagenLocal; 
    UILabel * local;
    UILabel * localScore;
    UIImageView * imagenVisita; 
    UILabel * visita;
    UILabel * visitaScore;
    UILabel * horario;
    UILabel * lugar;
    UISwitch * estado;    
}
@property(nonatomic, retain)BasquetbolService * service;
@property (nonatomic, retain) IBOutlet UIImageView * imagenLocal;
@property (nonatomic, retain) IBOutlet UILabel * local;
@property (nonatomic, retain) IBOutlet UILabel * localScore;
@property (nonatomic, retain) IBOutlet UIImageView * imagenVisita;
@property (nonatomic, retain) IBOutlet UILabel * visita;
@property (nonatomic, retain) IBOutlet UILabel * visitaScore;
@property (nonatomic, retain) IBOutlet UILabel * horario;
@property (nonatomic, retain) IBOutlet UILabel * lugar;
@property (nonatomic, retain) IBOutlet UISwitch * estado;

- (void) setPartido:(Partido *) elPartido;
- (Partido *) partido;

@end
