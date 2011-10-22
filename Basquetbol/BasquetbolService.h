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
    NSArray * estadisticas;
    NSArray * valorTipoEnceste;
}

-(void)initializePersistanceStoreCoordinator;
-(void)initializeManagedObjectContext;
-(void)initializeManageObjectModel;
-(void)inicializeCoreData;
- (void) salvarContexto;

-(UIImage *)getImageByPosicion:(NSString *)posicion;
-(UIImage *)getImageByRow:(int)row;
-(void) initializeDatosTest;

-(NSMutableArray *) partidos;
-(NSArray *)estadisticas;

-(NSMutableArray *) getPartidosOfContext;

-(NSArray *)estadisticas;
-(UIImage *)getImageByRow:(int) row;
-(int) getEstadisticasByRow:(int) row byPeriodo:(int) periodo atJuego:(Jugador *) jugador;
-(NSString *)getNombreEstadisticaByRow:(int) row;
-(NSArray *) informacionDeEstadistica:(NSString *) estadistica paraJugador:(Jugador *) jugador;
-(int)valorPorTipoEnceste:(NSString *) tipoEnceste;
- (NSArray *)estadisticasPorJugador:(Jugador *) jugador PorTipo:(NSString *) tipoEstadistica;
- (void)registraEstadistica:(NSString *) estadistica paraJugador:(Jugador *) jugador enMinuto:(NSString *) min deTipo:(NSString *) tipoEsta involucradoAJugador:(Jugador *) involJugador;
@end
