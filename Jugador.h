//
//  Jugador.h
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 12/10/11.
//  Copyright (c) 2011 Valle del Bit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Equipo;

@interface Jugador : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * apellido;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSNumber * numero;
@property (nonatomic, retain) NSString * posicion;
@property (nonatomic, retain) NSString * estado;
@property (nonatomic, retain) Equipo *equipo;

@end
