//
//  Enceste.m
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 14/10/11.
//  Copyright (c) 2011 Valle del Bit. All rights reserved.
//

#import "Enceste.h"
#import "Jugador.h"


@implementation Enceste
@dynamic min;
@dynamic tipo;
@dynamic valor;
@dynamic jugador;

-(NSString *) description
{
    return [NSString stringWithFormat:@"Min: @% - @%", [self min], [self tipo]];
}

@end
