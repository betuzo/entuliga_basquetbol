//
//  Equipo.m
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 12/10/11.
//  Copyright (c) 2011 Valle del Bit. All rights reserved.
//

#import "Equipo.h"
#import "Jugador.h"


@implementation Equipo
@dynamic local;
@dynamic mascota;
@dynamic nombre;
@dynamic jugadores;

-(NSString *) tipoEquipo
{
    NSString * tmp = @"";
    if(self != nil)
    {
        if([[self local] isEqualToString:@"Si"])
            tmp = @"Local";
        else
            tmp = @"Visitante";
    }
    return tmp;
    //¿Tengo que hacer algun release?
}

@end
