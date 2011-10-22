//
//  Falta.m
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 12/10/11.
//  Copyright (c) 2011 Valle del Bit. All rights reserved.
//

#import "Falta.h"
#import "Jugador.h"


@implementation Falta
@dynamic min;
@dynamic tipo;
@dynamic agredido;
@dynamic agresor;

-(NSString *) description
{
    return [NSString stringWithFormat:@"Min: @% - @%", [self min], [self tipo]];
}

@end
