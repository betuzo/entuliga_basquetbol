//
//  BasquetbolService.h
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 11/10/11.
//  Copyright 2011 Valle del Bit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jugador.h"
#import "Equipo.h"
#import "Arbitro.h"
#import "Enceste.h"
#import "Robo.h"
#import "Rebote.h"
#import "Partido.h"
#import "Falta.h"
#import "Bloqueo.h"
#import "Ingreso.h"
#import "Asistencia.h"

@interface BasquetbolService : NSObject
{
    NSManagedObjectModel * managedObjectModel;
    NSPersistentStoreCoordinator * persistentStoreCoordinator; 
    NSManagedObjectContext * managedObjectContext;
    
    NSMutableArray * partidos;
    
    //NSMutableArray * jugadores;
    //NSMutableArray * equipos;
}

-(void)initializePersistanceStoreCoordinator;
-(void)initializeManagedObjectContext;
-(void)initializeManageObjectModel;
-(void)inicializeCoreData;

-(UIImage *)getImageByPosicion:(NSString *)posicion;
-(void) initializeDatosTest;

-(NSMutableArray *) partidos;
-(void)setPartidos:(NSMutableArray *) losPartidos;

-(NSMutableArray *) getPartidosOfContext;
@end
