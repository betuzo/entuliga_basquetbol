//
//  Rebote.m
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 12/10/11.
//  Copyright (c) 2011 Valle del Bit. All rights reserved.
//

#import "Rebote.h"
#import "Jugador.h"


@implementation Rebote
@dynamic min;
@dynamic tipo;
@dynamic jugador;

-(NSString *) description
{
    return [NSString stringWithFormat:@"Min: @% - @%", [self min], [self tipo]];
}

@end
