//
//  Partido.m
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 12/10/11.
//  Copyright (c) 2011 Valle del Bit. All rights reserved.
//

#import "Partido.h"
#import "Arbitro.h"
#import "Equipo.h"


@implementation Partido
@dynamic estado;
@dynamic fecha;
@dynamic lugar;
@dynamic numeroPartido;
@dynamic arbitros;
@dynamic equipos;

- (NSString *)description
{
    if ([[self equipos] count]==2)
        return [NSString stringWithFormat:@"%@ vs %@", [[[[self equipos] allObjects] objectAtIndex:0] nombre], [[[[self equipos] allObjects] objectAtIndex:1] nombre]];
    else if (([[self equipos] count]==1))
        return [NSString stringWithFormat:@"%@ vs Sin Equipo", [[[[self equipos] allObjects] objectAtIndex:0] nombre]];
    else
        return @"Partido sin equipos";
}

- (NSString *) detailShortFecha
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    return [dateFormatter stringFromDate:[self fecha]];
}

- (NSString *) detailLongFecha
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    
    return [dateFormatter stringFromDate:[self fecha]];
}

- (NSString *)detailPartido
{
    return [NSString stringWithFormat:@"%@ | %@", [self detailShortFecha], [self lugar]];
}

- (Equipo *)getEquipoLocal:(BOOL) isLocal
{
    for (id equipo in [self equipos]) 
    {
        if (isLocal && [[equipo local] isEqualToString:@"Si"]) 
            return equipo;
        else if(!isLocal && [[equipo local] isEqualToString:@"No"])
            return equipo;
        
    }
    return nil;
}

@end
