//
//  Partido.h
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 16/10/11.
//  Copyright (c) 2011 Valle del Bit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Arbitro, Equipo;

@interface Partido : NSManagedObject

@property (nonatomic, retain) NSString * estado;
@property (nonatomic, retain) NSDate * fecha;
@property (nonatomic, retain) NSString * lugar;
@property (nonatomic, retain) NSNumber * numeroPartido;
@property (nonatomic, retain) NSNumber * numeroPeriodos;
@property (nonatomic, retain) NSNumber * minPorPeriodo;
@property (nonatomic, retain) NSSet *arbitros;
@property (nonatomic, retain) NSSet *equipos;
@end

@interface Partido (CoreDataGeneratedAccessors)

- (void)addArbitrosObject:(Arbitro *)value;
- (void)removeArbitrosObject:(Arbitro *)value;
- (void)addArbitros:(NSSet *)values;
- (void)removeArbitros:(NSSet *)values;

- (void)addEquiposObject:(Equipo *)value;
- (void)removeEquiposObject:(Equipo *)value;
- (void)addEquipos:(NSSet *)values;
- (void)removeEquipos:(NSSet *)values;

- (NSString *)detailPartido;
- (id)getEquipoLocal:(BOOL) isLocal;
- (NSString *) detailLongFecha;
- (NSString *) detailShortFecha;

@end
