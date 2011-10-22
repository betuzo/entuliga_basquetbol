//
//  Robo.m
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 12/10/11.
//  Copyright (c) 2011 Valle del Bit. All rights reserved.
//

#import "Robo.h"
#import "Jugador.h"


@implementation Robo
@dynamic min;
@dynamic tipo;
@dynamic robado;
@dynamic robador;

-(NSString *) description
{
    return [NSString stringWithFormat:@"Min: @% - @%", [self min], [self tipo]];
}

@end
