//
//  Jugador.h
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 12/10/11.
//  Copyright (c) 2011 Valle del Bit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Enceste.h"

@class Asistencia, Equipo, Ingreso;

@interface Jugador : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * apellido;
@property (nonatomic, retain) NSString * estado;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSNumber * numero;
@property (nonatomic, retain) NSNumber * numeroJugador;
@property (nonatomic, retain) NSString * posicion;
@property (nonatomic, retain) NSSet *asistenciasRealizadas;
@property (nonatomic, retain) NSSet *asistenciasRecibidas;
@property (nonatomic, retain) NSSet *bloqueosRealizados;
@property (nonatomic, retain) NSSet *bloqueosRecibidos;
@property (nonatomic, retain) Equipo *equipo;
@property (nonatomic, retain) NSSet *faltasRealizadas;
@property (nonatomic, retain) NSSet *faltasRecibidas;
@property (nonatomic, retain) NSSet *ingresos;
@property (nonatomic, retain) NSSet *puntos;
@property (nonatomic, retain) NSSet *rebotes;
@property (nonatomic, retain) NSSet *robosRealizados;
@property (nonatomic, retain) NSSet *robosRecibidos;
@property (nonatomic, retain) NSSet *salidas;
@end

@interface Jugador (CoreDataGeneratedAccessors)

- (void)addAsistenciasRealizadasObject:(Asistencia *)value;
- (void)removeAsistenciasRealizadasObject:(Asistencia *)value;
- (void)addAsistenciasRealizadas:(NSSet *)values;
- (void)removeAsistenciasRealizadas:(NSSet *)values;

- (void)addAsistenciasRecibidasObject:(Asistencia *)value;
- (void)removeAsistenciasRecibidasObject:(Asistencia *)value;
- (void)addAsistenciasRecibidas:(NSSet *)values;
- (void)removeAsistenciasRecibidas:(NSSet *)values;

- (void)addBloqueosRealizadosObject:(NSManagedObject *)value;
- (void)removeBloqueosRealizadosObject:(NSManagedObject *)value;
- (void)addBloqueosRealizados:(NSSet *)values;
- (void)removeBloqueosRealizados:(NSSet *)values;

- (void)addBloqueosRecibidosObject:(NSManagedObject *)value;
- (void)removeBloqueosRecibidosObject:(NSManagedObject *)value;
- (void)addBloqueosRecibidos:(NSSet *)values;
- (void)removeBloqueosRecibidos:(NSSet *)values;

- (void)addFaltasRealizadasObject:(NSManagedObject *)value;
- (void)removeFaltasRealizadasObject:(NSManagedObject *)value;
- (void)addFaltasRealizadas:(NSSet *)values;
- (void)removeFaltasRealizadas:(NSSet *)values;

- (void)addFaltasRecibidasObject:(NSManagedObject *)value;
- (void)removeFaltasRecibidasObject:(NSManagedObject *)value;
- (void)addFaltasRecibidas:(NSSet *)values;
- (void)removeFaltasRecibidas:(NSSet *)values;

- (void)addIngresosObject:(Ingreso *)value;
- (void)removeIngresosObject:(Ingreso *)value;
- (void)addIngresos:(NSSet *)values;
- (void)removeIngresos:(NSSet *)values;

- (void)addPuntosObject:(NSManagedObject *)value;
- (void)removePuntosObject:(NSManagedObject *)value;
- (void)addPuntos:(NSSet *)values;
- (void)removePuntos:(NSSet *)values;

- (void)addRebotesObject:(NSManagedObject *)value;
- (void)removeRebotesObject:(NSManagedObject *)value;
- (void)addRebotes:(NSSet *)values;
- (void)removeRebotes:(NSSet *)values;

- (void)addRobosRealizadosObject:(NSManagedObject *)value;
- (void)removeRobosRealizadosObject:(NSManagedObject *)value;
- (void)addRobosRealizados:(NSSet *)values;
- (void)removeRobosRealizados:(NSSet *)values;

- (void)addRobosRecibidosObject:(NSManagedObject *)value;
- (void)removeRobosRecibidosObject:(NSManagedObject *)value;
- (void)addRobosRecibidos:(NSSet *)values;
- (void)removeRobosRecibidos:(NSSet *)values;

- (void)addSalidasObject:(Ingreso *)value;
- (void)removeSalidasObject:(Ingreso *)value;
- (void)addSalidas:(NSSet *)values;
- (void)removeSalidas:(NSSet *)values;

- (int) puntosTotal;
- (int) puntosEntre:(int)inicio Y:(int)fin;
- (int) asistenciasEntre:(int)inicio Y:(int)fin;
- (int) bloqueosEntre:(int)inicio Y:(int)fin;
- (int) rebotesEntre:(int)inicio Y:(int)fin;
- (int) robosEntre:(int)inicio Y:(int)fin;
- (int) faltasEntre:(int)inicio Y:(int)fin;
- (int) minutosEntre:(int)inicio Y:(int)fin;
@end
