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

@interface BasquetbolService : NSObject
{
    NSManagedObjectModel * managedObjectModel;
    NSPersistentStoreCoordinator * persistentStoreCoordinator; 
    NSManagedObjectContext * managedObjectContext;
    
    NSMutableArray * jugadores;
    NSMutableArray * equipos;
}

-(void)initializePersistanceStoreCoordinator;
-(void)initializeManagedObjectContext;
-(void)initializeManageObjectModel;
-(void)inicializeCoreData;

-(UIImage *)getImageByPosicion:(NSString *)posicion;
-(void) initializeDatosTest;

-(NSMutableArray *) jugadores;
-(void)setJugadores:(NSMutableArray *) losJugadores;
-(NSMutableArray *) equipos;
-(void)setEquipos:(NSMutableArray *) losEquipos;

-(NSMutableArray *) getJugadoresOfContext;
-(NSMutableArray *) getEquiposOfContext;
@end
