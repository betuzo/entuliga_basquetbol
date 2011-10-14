//
//  Falta.h
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 12/10/11.
//  Copyright (c) 2011 Valle del Bit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Jugador;

@interface Falta : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * min;
@property (nonatomic, retain) NSString * tipo;
@property (nonatomic, retain) Jugador *agredido;
@property (nonatomic, retain) Jugador *agresor;

@end
