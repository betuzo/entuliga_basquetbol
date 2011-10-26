//
//  Bloqueo.m
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 12/10/11.
//  Copyright (c) 2011 Valle del Bit. All rights reserved.
//

#import "Bloqueo.h"
#import "Jugador.h"


@implementation Bloqueo
@dynamic min;
@dynamic tipo;
@dynamic bloqueado;
@dynamic bloqueador;

-(NSString *) description
{
    return [NSString stringWithFormat:@"Min: %@ - %@", [self min], [self tipo]];
}

@end
