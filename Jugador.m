//
//  Jugador.m
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 12/10/11.
//  Copyright (c) 2011 Valle del Bit. All rights reserved.
//

#import "Jugador.h"
#import "Asistencia.h"
#import "Equipo.h"
#import "Ingreso.h"


@implementation Jugador
@dynamic apellido;
@dynamic estado;
@dynamic nombre;
@dynamic numero;
@dynamic numeroJugador;
@dynamic posicion;
@dynamic asistenciasRealizadas;
@dynamic asistenciasRecibidas;
@dynamic bloqueosRealizados;
@dynamic bloqueosRecibidos;
@dynamic equipo;
@dynamic faltasRealizadas;
@dynamic faltasRecibidas;
@dynamic ingresos;
@dynamic puntos;
@dynamic rebotes;
@dynamic robosRealizados;
@dynamic robosRecibidos;
@dynamic salidas;

- (int) puntosTotal
{
    int puntosTotal = 0;
    for (Enceste* enceste in [self puntos]) 
    {
        puntosTotal = puntosTotal + [[enceste valor] shortValue];
    }
    return puntosTotal;
}

@end
