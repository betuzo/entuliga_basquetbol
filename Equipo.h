//
//  Equipo.h
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 12/10/11.
//  Copyright (c) 2011 Valle del Bit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Jugador;

@interface Equipo : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * local;
@property (nonatomic, retain) NSString * mascota;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSNumber * numeroEquipo;
@property (nonatomic, retain) NSSet *jugadores;
@property (nonatomic, retain) NSManagedObject *partido;
@end

@interface Equipo (CoreDataGeneratedAccessors)

- (void)addJugadoresObject:(Jugador *)value;
- (void)removeJugadoresObject:(Jugador *)value;
- (void)addJugadores:(NSSet *)values;
- (void)removeJugadores:(NSSet *)values;
- (NSString *) tipoEquipo;
- (int) puntosTotal;

@end
