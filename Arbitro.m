//
//  Arbitro.m
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 12/10/11.
//  Copyright (c) 2011 Valle del Bit. All rights reserved.
//

#import "Arbitro.h"


@implementation Arbitro
@dynamic apellido;
@dynamic nombre;
@dynamic numeroArbitro;
@dynamic ubicacion;
@dynamic partido;

- (NSString *)description
{

    return [NSString stringWithFormat:@"%@ %@", [self nombre], [self apellido]];
    
}

- (NSString *)detailArbitro
{
    return [self ubicacion];
}

@end
