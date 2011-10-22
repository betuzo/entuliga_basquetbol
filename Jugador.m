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

-(NSString *) description
{
    return [NSString stringWithFormat:@"%@ - %@ %@", [self numero], [self nombre], [self apellido]];
}

- (int) puntosTotal
{
    int puntosTotal = 0;
    for (Enceste* enceste in [self puntos]) 
    {
        puntosTotal = puntosTotal + [[enceste valor] shortValue];
    }
    return puntosTotal;
}

- (int) asistenciasEntre:(int)inicio Y:(int)fin
{
    int asistenciaTotal = 0;
    for (Asistencia * asistencia in [self asistenciasRealizadas]) 
    {
        if ([[asistencia min] intValue] >= inicio && [[asistencia min] intValue] <= fin)
            asistenciaTotal = asistenciaTotal + 1;
    }
    return asistenciaTotal;
}

- (int) bloqueosEntre:(int)inicio Y:(int)fin
{
    int bloqueosTotal = 0;
    for (id bloqueo in [self bloqueosRealizados]) 
    {
        if ([[bloqueo min] intValue] >= inicio && [[bloqueo min] intValue] <= fin)
            bloqueosTotal = bloqueosTotal + 1;
    }
    return bloqueosTotal;
}

- (int) rebotesEntre:(int)inicio Y:(int)fin
{
    int reboteTotal = 0;
    for (id rebote in [self rebotes]) 
    {
        if ([[rebote min] intValue] >= inicio && [[rebote min] intValue] <= fin)
            reboteTotal = reboteTotal + 1;
    }
    return reboteTotal;
}

- (int) robosEntre:(int)inicio Y:(int)fin
{
    int robosTotal = 0;
    for (id robo in [self robosRealizados]) 
    {
        if ([[robo min] intValue] >= inicio && [[robo min] intValue] <= fin)
            robosTotal = robosTotal + 1;
    }
    return robosTotal;
}

- (int) faltasEntre:(int)inicio Y:(int)fin
{
    int faltasTotal = 0;
    for (id falta in [self faltasRealizadas]) 
    {
        if ([[falta min] intValue] >= inicio && [[falta min] intValue] <= fin)
            faltasTotal = faltasTotal + 1;
    }
    return faltasTotal;
}

- (int) puntosEntre:(int)inicio Y:(int)fin
{
    int puntosTotal = 0;
    for (Enceste * enceste in [self puntos]) 
    {
        if ([[enceste min] intValue] >= inicio && [[enceste min] intValue] <= fin)
            puntosTotal = puntosTotal + [[enceste valor] intValue];
    }
    return puntosTotal;
}

- (int) minutosEntre:(int)inicio Y:(int)fin
{
    int minutosTotal = 0;
    for (Ingreso * ingreso in [self ingresos]) 
    {
        if ([[ingreso min] intValue] >= inicio && [[ingreso min] intValue] <= fin)
        {
            int estado = 0;
            for (Ingreso * salida in [self salidas]) 
            {
                if ([[salida min] intValue] >= inicio && [[salida min] intValue] <= fin
                    && [[salida min] intValue] > [[ingreso min] intValue] && estado == 0)
                {
                    minutosTotal = minutosTotal + ([[salida min] intValue] - [[ingreso min] intValue]);
                    estado = 1;
                }
            }
            if (estado==0) {
                minutosTotal = minutosTotal + (fin - [[ingreso min] intValue]);
            }
        }       
    }
    return minutosTotal;
}
@end
