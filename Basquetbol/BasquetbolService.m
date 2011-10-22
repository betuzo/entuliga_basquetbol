//
//  BasquetbolService.m
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 11/10/11.
//  Copyright 2011 Valle del Bit. All rights reserved.
//

#import "BasquetbolService.h"

@implementation BasquetbolService

- (id)init
{
    self = [super init];
    if (self) {
        [self inicializeCoreData];
        estadisticas = [[NSArray alloc] initWithObjects:
                        [[NSArray alloc] initWithObjects:@"MIN", @"PTS", @"FTS", @"RBT", @"BLQ", @"AST", @"RBS", nil],
                        [[NSArray alloc] initWithObjects:@"Si", @"No", @"Si", @"No", @"Si", @"Si", @"Si", nil],
                        [[NSArray alloc] initWithObjects:@"Si", @"No", @"Si", @"No", @"No", @"No", @"No", nil],
                        [[NSArray alloc] initWithObjects:
                            [[NSArray alloc] initWithObjects:@"TITULAR", @"CANCHA", @"LESION", @"FALTAS", @"EXPULSADO", nil], 
                            [[NSArray alloc] initWithObjects:@"NORMAL", @"DE TRES", @"LINEA", nil],
                            [[NSArray alloc] initWithObjects:@"NORMAL", @"TECNICA", @"GRAVE", nil],
                            [[NSArray alloc] initWithObjects:@"DEFENSIVO", @"OFENSIVO", nil], 
                            [[NSArray alloc] initWithObjects:@"NORMAL", nil], 
                            [[NSArray alloc] initWithObjects:@"NORMAL", nil], 
                            [[NSArray alloc] initWithObjects:@"NORMAL", nil], 
                            nil],
                        nil];
        valorTipoEnceste = [[NSArray alloc] initWithObjects:
                                [[NSArray alloc] initWithObjects:@"NORMAL", @"DE TRES", @"LINEA", nil],
                                [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:1], nil],
                                nil];
    }
    
    return self;
}

- (NSArray *)estadisticasPorJugador:(Jugador *) jugador PorTipo:(NSString *) tipoEstadistica
{
    if ([tipoEstadistica isEqualToString:@"MIN"]) 
        return [[jugador ingresos]allObjects];
    if ([tipoEstadistica isEqualToString:@"PTS"]) 
        return [[jugador puntos]allObjects];
    if ([tipoEstadistica isEqualToString:@"FTS"]) 
        return [[jugador faltasRealizadas]allObjects];
    if ([tipoEstadistica isEqualToString:@"RBT"]) 
        return [[jugador rebotes]allObjects];
    if ([tipoEstadistica isEqualToString:@"BLQ"]) 
        return [[jugador bloqueosRealizados]allObjects];
    if ([tipoEstadistica isEqualToString:@"AST"]) 
        return [[jugador asistenciasRealizadas]allObjects];
    if ([tipoEstadistica isEqualToString:@"RBS"]) 
        return [[jugador robosRealizados]allObjects];
    
    return nil;
    
}

-(int)valorPorTipoEnceste:(NSString *) tipoEnceste
{
    int valor = 0;
    for (int tipo = 0; tipo < [[valorTipoEnceste objectAtIndex:0] count]; tipo++) {
        if([[[valorTipoEnceste objectAtIndex:0] objectAtIndex:tipo] isEqualToString:tipoEnceste])
        {  
            valor = [[[valorTipoEnceste objectAtIndex:1] objectAtIndex:tipo] intValue];
        }
    }
    return valor;
}

-(NSArray *) informacionDeEstadistica:(NSString *) estadistica paraJugador:(Jugador *) jugador
{
    
    NSMutableArray * minutos = [[NSMutableArray alloc] init];
    NSArray * tipos;
    NSMutableArray * jugadores = [[NSMutableArray alloc] init];
    int banderaQuitaJugador = 0;
    int banderaJugadorNULL = 0;
    
    Partido * partidoTmp = (Partido *)[[jugador equipo] partido];
    int totalMin = [[partidoTmp minPorPeriodo] intValue] * [[partidoTmp numeroPeriodos] intValue];
    
    
    for (int min = 1; min <= totalMin; min++) {
        [minutos addObject:[NSString stringWithFormat:@"%i",min]];
    }
    
    for (int tipo = 0; tipo < [[estadisticas objectAtIndex:0] count]; tipo++) {
        if([[[estadisticas objectAtIndex:0] objectAtIndex:tipo] isEqualToString:estadistica])
        {
            tipos = [[[estadisticas objectAtIndex:3] allObjects]  objectAtIndex:tipo];
            if ([[[[estadisticas objectAtIndex:1] allObjects] objectAtIndex:tipo] isEqualToString:@"Si"])
                banderaQuitaJugador = 1;
            if ([[[[estadisticas objectAtIndex:2] allObjects] objectAtIndex:tipo] isEqualToString:@"Si"])
                banderaJugadorNULL = 1;
        }
    }
    
    jugadores = [[[[jugador equipo] jugadores] allObjects] mutableCopy];
    [jugadores removeObject:jugador];
    if (banderaJugadorNULL==1)
        [jugadores addObject:@"NINGUNO"];
        
    NSArray * informacionDeEstadistica;
    
    if (banderaQuitaJugador==1)
    {
        informacionDeEstadistica = [[[NSArray alloc] initWithObjects:minutos, tipos, jugadores, nil] autorelease];
    }
    else
    {
        informacionDeEstadistica = [[[NSArray alloc] initWithObjects:minutos, tipos, nil] autorelease];
    }
    
    [partidoTmp release];
    [minutos release];
    [jugadores release];
    [tipos  release];
    
    return informacionDeEstadistica;
}

-(NSArray *)estadisticas
{
    return [estadisticas objectAtIndex:0];
}

-(NSMutableArray *) partidos
{
    NSMutableArray * partidos = [self getPartidosOfContext];
    if([partidos count]==0)
    {
        [self initializeDatosTest];
        partidos = [self getPartidosOfContext];
    }
    
    return partidos;
}

- (void)dealloc
{
    [estadisticas release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
    [managedObjectContext release];
    [super dealloc];
}

-(void)inicializeCoreData
{
    [self initializeManageObjectModel];
    [self initializePersistanceStoreCoordinator];
    [self initializeManagedObjectContext];    
}

-(void)initializeManageObjectModel
{
    if(!managedObjectModel)
    {
        NSURL * ulr = [[NSBundle mainBundle] URLForResource:@"Basquetbol" withExtension:@"momd"];
        managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:ulr];
    }
}

- (NSURL *)applicationDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains: NSUserDomainMask] lastObject];
}

-(void) initializePersistanceStoreCoordinator
{
    
    if(!persistentStoreCoordinator)
    {
        NSURL * storeURL = [[self applicationDirectory] URLByAppendingPathComponent:@"Basquetbol.sqlite"];
        
        NSError * error = nil;
        
        persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:managedObjectModel];
        if(![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
        {
            NSLog(@"Error");
            abort();
        }
        
    }
}

-(void)initializeManagedObjectContext
{
    
    if(!managedObjectContext)
    {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
        
    }
}

-(int) getEstadisticasByRow:(int) row byPeriodo:(int) periodo atJuego:(Jugador *) jugador
{
    int totalEstadisticas = 0;
    Partido * partido = (Partido *) [[jugador equipo] partido];
    int minIni = (periodo - 1) * [[partido minPorPeriodo] intValue] + 1;
    int minFin = periodo * [[partido minPorPeriodo] intValue];
    if (periodo == 0) {
        minIni = 0;
        minFin = [[partido numeroPeriodos] intValue] * [[partido minPorPeriodo] intValue];
    }
    if([[partido numeroPeriodos] intValue] >= periodo && periodo >= -1)
    {
        switch (row) {
            case 0:
                totalEstadisticas = [jugador minutosEntre:minIni Y:minFin];
                break;
            case 1:
                totalEstadisticas = [jugador puntosEntre:minIni Y:minFin];
                break;
            case 2:
                totalEstadisticas = [jugador faltasEntre:minIni Y:minFin];
                break;
            case 3:
                totalEstadisticas = [jugador rebotesEntre:minIni Y:minFin];
                break;
            case 4:
                totalEstadisticas = [jugador bloqueosEntre:minIni Y:minFin];
                break;
            case 5:
                totalEstadisticas = [jugador asistenciasEntre:minIni Y:minFin];
                break;
            case 6:
                totalEstadisticas = [jugador robosEntre:minIni Y:minFin];
                break;
            
            default:
                break;
        }
    }
    return totalEstadisticas;
}

-(UIImage *)getImageByRow:(int) row
{
    return [UIImage imageNamed:[[[estadisticas objectAtIndex:0] allObjects] objectAtIndex:row]];
}

-(NSString *)getNombreEstadisticaByRow:(int) row
{
    return [[[estadisticas objectAtIndex:0] allObjects] objectAtIndex:row];
}

-(UIImage *)getImageByPosicion:(NSString *)posicion
{
    if([posicion isEqualToString:@"Movedor"])
    {
        return [UIImage imageNamed:@"movedor.jpg"];
    }else if([posicion isEqualToString:@"Ala Derecha"])
    {
        return [UIImage imageNamed:@"aladerecha.jpg"];
    }else if([posicion isEqualToString:@"Ala Izquierda"])
    {
        return [UIImage imageNamed:@"alaizquierda.jpg"];
    }else if([posicion isEqualToString:@"Poste Derecho"])
    {
        return [UIImage imageNamed:@"postederecho.jpg"];
    }else if([posicion isEqualToString:@"Poste Izquierdo"])
    {
        return [UIImage imageNamed:@"posteizquierdo.jpg"];
    }else{
        return [UIImage imageNamed:@"base.png"];
    }
}


-(NSMutableArray *) getPartidosOfContext
{
    NSError * error;
    NSMutableArray * partidos;
    
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Partido" inManagedObjectContext:managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    NSSortDescriptor * sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"fecha" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject: sortDescriptor]];
    
    partidos = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    NSLog(@"%i", [partidos count]);
    
    [sortDescriptor release];
    [request release];
    
    // ¿Es corecto que solo libere estos objetos? son los únicos a los que les hice alloc
    
    return partidos;
}

- (void)registraEstadistica:(NSString *) estadistica paraJugador:(Jugador *) jugador enMinuto:(NSString *) min deTipo:(NSString *) tipoEsta involucradoAJugador:(Jugador *) involJugador
{
    if ([[involJugador description] isEqualToString:@"NINGUNO"]) {
        involJugador = nil;
    }
    NSNumber * minuto = [NSNumber numberWithInt:[min intValue]];
    if ([estadistica isEqualToString:@"MIN"])
    {
        Ingreso * ingreso = [[NSEntityDescription insertNewObjectForEntityForName:@"Ingreso" inManagedObjectContext:managedObjectContext]autorelease];
        [ingreso setMin:minuto];
        [ingreso setTipo:tipoEsta];
        [ingreso setSale:jugador];
        [ingreso setIngresa:involJugador];
        [jugador addIngresosObject:ingreso];
        [involJugador addSalidasObject:ingreso];
    }
    if ([estadistica isEqualToString:@"PTS"]) 
    {
        Enceste * enceste = [[NSEntityDescription insertNewObjectForEntityForName:@"Enceste" inManagedObjectContext:managedObjectContext]autorelease];
        [enceste setMin:minuto];
        [enceste setTipo:tipoEsta];
        [enceste setValor:[NSNumber numberWithInt:[self valorPorTipoEnceste:tipoEsta]]];
        [enceste setJugador:jugador];
        [jugador addPuntosObject:enceste];
    }
    if ([estadistica isEqualToString:@"FTS"]) 
    {
        Falta * falta = [[NSEntityDescription insertNewObjectForEntityForName:@"Falta" inManagedObjectContext:managedObjectContext]autorelease];
        [falta setMin:minuto];
        [falta setTipo:tipoEsta];
        [falta setAgresor:jugador];
        [falta setAgredido:involJugador];
        [jugador addFaltasRealizadasObject:falta];
        [involJugador addFaltasRecibidasObject:falta];
    }
    if ([estadistica isEqualToString:@"RBT"]) 
    {
        Rebote * rebote = [[NSEntityDescription insertNewObjectForEntityForName:@"Rebote" inManagedObjectContext:managedObjectContext]autorelease];
        [rebote setMin:minuto];
        [rebote setTipo:tipoEsta];
        [rebote setJugador:jugador];
        [jugador addRebotesObject:rebote];
    }
    if ([estadistica isEqualToString:@"BLQ"]) 
    {
        Bloqueo * bloqueo = [[NSEntityDescription insertNewObjectForEntityForName:@"Bloqueo" inManagedObjectContext:managedObjectContext]autorelease];
        [bloqueo setMin:minuto];
        [bloqueo setTipo:tipoEsta];
        [bloqueo setBloqueador:jugador];
        [bloqueo setBloqueado:involJugador];
        [jugador addBloqueosRealizadosObject:bloqueo];
        [involJugador addRobosRecibidosObject:bloqueo];
    }
    if ([estadistica isEqualToString:@"AST"]) 
    {
        Asistencia * asistencia = [[NSEntityDescription insertNewObjectForEntityForName:@"Asistencia" inManagedObjectContext:managedObjectContext]autorelease];
        [asistencia setMin:minuto];
        [asistencia setTipo:tipoEsta];
        [asistencia setAsistente:jugador];
        [asistencia setAsistido:involJugador];
        [jugador addAsistenciasRealizadasObject:asistencia];
        [involJugador addAsistenciasRecibidasObject:asistencia];
    }
    if ([estadistica isEqualToString:@"RBS"]) 
    {
        
        Robo * robo = [[NSEntityDescription insertNewObjectForEntityForName:@"Robo" inManagedObjectContext:managedObjectContext]autorelease];
        [robo setMin:minuto];
        [robo setTipo:tipoEsta];
        [robo setRobador:jugador];
        [robo setRobado:involJugador];
        [jugador addRobosRealizadosObject:robo];
        [involJugador addRobosRecibidosObject:robo];        
    }
    
   [self salvarContexto];
    
}

-(void) initializeDatosTest
{
    Equipo * local = [[NSEntityDescription insertNewObjectForEntityForName:@"Equipo" inManagedObjectContext:managedObjectContext] autorelease];
    
    [local setNombre:@"Fox"];
    [local setMascota:@"Zorros"];
    [local setLocal:@"Si"];
    [local setNumeroEquipo:[NSNumber numberWithInt:7]];
    
    Equipo * visita = [[NSEntityDescription insertNewObjectForEntityForName:@"Equipo" inManagedObjectContext:managedObjectContext]autorelease];
    
    [visita setNombre:@"Cavaliers"];
    [visita setMascota:@"Carro"];
    [visita setLocal:@"No"];
    [visita setNumeroEquipo:[NSNumber numberWithInt:6]];
    
    Jugador * jugador1 = [[NSEntityDescription insertNewObjectForEntityForName:@"Jugador" inManagedObjectContext:managedObjectContext]autorelease];
    
    [jugador1 setNombre:@"Betuzo"];
    [jugador1 setApellido:@"Olguin"];
    [jugador1 setPosicion:@"Poste Derecho"];
    [jugador1 setEstado:@"Titular"];
    [jugador1 setNumero:[NSNumber numberWithInt:1]];
    [jugador1 setNumeroJugador:[NSNumber numberWithInt:1001]];
    [jugador1 setEquipo:local];
    
    Jugador * jugador2 = [[NSEntityDescription insertNewObjectForEntityForName:@"Jugador" inManagedObjectContext:managedObjectContext]autorelease];
    
    [jugador2 setNombre:@"Ruben"];
    [jugador2 setApellido:@"Barcenas"];
    [jugador2 setPosicion:@"Ala Derecha"];
    [jugador2 setEstado:@"Titular"];
    [jugador2 setNumero:[NSNumber numberWithInt:2]];
    [jugador2 setNumeroJugador:[NSNumber numberWithInt:1002]];
    [jugador2 setEquipo:local];
    
    Jugador * jugador3 = [[NSEntityDescription insertNewObjectForEntityForName:@"Jugador" inManagedObjectContext:managedObjectContext]autorelease];
    
    [jugador3 setNombre:@"Eduardo"];
    [jugador3 setApellido:@"Cruz"];
    [jugador3 setPosicion:@"Ala Izquierda"];
    [jugador3 setEstado:@"Titular"];
    [jugador3 setNumero:[NSNumber numberWithInt:7]];
    [jugador3 setNumeroJugador:[NSNumber numberWithInt:1003]];
    [jugador3 setEquipo:local];
    
    Jugador * jugador4 = [[NSEntityDescription insertNewObjectForEntityForName:@"Jugador" inManagedObjectContext:managedObjectContext]autorelease];
    
    [jugador4 setNombre:@"Hasiel"];
    [jugador4 setApellido:@"Lopez"];
    [jugador4 setPosicion:@"Poste Izquierdo"];
    [jugador4 setEstado:@"Titular"];
    [jugador4 setNumero:[NSNumber numberWithInt:8]];
    [jugador4 setNumeroJugador:[NSNumber numberWithInt:1004]];
    [jugador4 setEquipo:local];
    
    Jugador * jugador5 = [[NSEntityDescription insertNewObjectForEntityForName:@"Jugador" inManagedObjectContext:managedObjectContext]autorelease];
    
    [jugador5 setNombre:@"Raul"];
    [jugador5 setApellido:@"Guerrero"];
    [jugador5 setPosicion:@"Movedor"];
    [jugador5 setEstado:@"Titular"];
    [jugador5 setNumero:[NSNumber numberWithInt:10]];
    [jugador5 setNumeroJugador:[NSNumber numberWithInt:1005]];
    [jugador5 setEquipo:local];
    
    Jugador * jugador6 = [[NSEntityDescription insertNewObjectForEntityForName:@"Jugador" inManagedObjectContext:managedObjectContext]autorelease];
    
    [jugador6 setNombre:@"Joel"];
    [jugador6 setApellido:@"Andrade"];
    [jugador6 setPosicion:@"Poste Derecho"];
    [jugador6 setEstado:@"Titular"];
    [jugador6 setNumero:[NSNumber numberWithInt:2]];
    [jugador6 setNumeroJugador:[NSNumber numberWithInt:2001]];
    [jugador6 setEquipo:visita];
    
    Jugador * jugador7 = [[NSEntityDescription insertNewObjectForEntityForName:@"Jugador" inManagedObjectContext:managedObjectContext]autorelease];
    
    [jugador7 setNombre:@"Gerardo"];
    [jugador7 setApellido:@"Flores"];
    [jugador7 setPosicion:@"Poste Izquierdo"];
    [jugador7 setEstado:@"Titular"];
    [jugador7 setNumero:[NSNumber numberWithInt:3]];
    [jugador7 setNumeroJugador:[NSNumber numberWithInt:2002]];
    [jugador7 setEquipo:visita];
    
    Jugador * jugador8 = [[NSEntityDescription insertNewObjectForEntityForName:@"Jugador" inManagedObjectContext:managedObjectContext]autorelease];
    
    [jugador8 setNombre:@"Isidro"];
    [jugador8 setApellido:@"Licona"];
    [jugador8 setPosicion:@"Ala Derecha"];
    [jugador8 setEstado:@"Titular"];
    [jugador8 setNumero:[NSNumber numberWithInt:4]];
    [jugador8 setNumeroJugador:[NSNumber numberWithInt:2003]];
    [jugador8 setEquipo:visita];
    
    Jugador * jugador9 = [[NSEntityDescription insertNewObjectForEntityForName:@"Jugador" inManagedObjectContext:managedObjectContext]autorelease];
    
    [jugador9 setNombre:@"Mario"];
    [jugador9 setApellido:@"Rivera"];
    [jugador9 setPosicion:@"Ala Izquierda"];
    [jugador9 setEstado:@"Titular"];
    [jugador9 setNumero:[NSNumber numberWithInt:5]];
    [jugador9 setNumeroJugador:[NSNumber numberWithInt:2004]];
    [jugador9 setEquipo:visita];
    
    Jugador * jugador10 = [[NSEntityDescription insertNewObjectForEntityForName:@"Jugador" inManagedObjectContext:managedObjectContext]autorelease];
    
    [jugador10 setNombre:@"Luis"];
    [jugador10 setApellido:@"Lezama"];
    [jugador10 setPosicion:@"Movedor"];
    [jugador10 setEstado:@"Titular"];
    [jugador10 setNumero:[NSNumber numberWithInt:6]];
    [jugador10 setNumeroJugador:[NSNumber numberWithInt:2005]];
    [jugador10 setEquipo:visita];
    
    Arbitro * arbitro1 = [[NSEntityDescription insertNewObjectForEntityForName:@"Arbitro" inManagedObjectContext:managedObjectContext] autorelease];
    
    [arbitro1 setNumeroArbitro:[NSNumber numberWithInt:705]];
    [arbitro1 setNombre:@"Joel"];
    [arbitro1 setApellido:@"Campos"];
    [arbitro1 setUbicacion:@"Centro"];
    
    Arbitro * arbitro2 = [[NSEntityDescription insertNewObjectForEntityForName:@"Arbitro" inManagedObjectContext:managedObjectContext]autorelease];
    
    [arbitro2 setNumeroArbitro:[NSNumber numberWithInt:706]];
    [arbitro2 setNombre:@"Jose"];
    [arbitro2 setApellido:@"Estrada"];
    [arbitro2 setUbicacion:@"Auxiliar"];
    
    Arbitro * arbitro3 = [[NSEntityDescription insertNewObjectForEntityForName:@"Arbitro" inManagedObjectContext:managedObjectContext]autorelease];
    
    [arbitro3 setNumeroArbitro:[NSNumber numberWithInt:707]];
    [arbitro3 setNombre:@"Marcos"];
    [arbitro3 setApellido:@"Jimenez"];
    [arbitro3 setUbicacion:@"Auxiliar"];
    
    Arbitro * arbitro4 = [[NSEntityDescription insertNewObjectForEntityForName:@"Arbitro" inManagedObjectContext:managedObjectContext]autorelease];
    
    [arbitro4 setNumeroArbitro:[NSNumber numberWithInt:708]];
    [arbitro4 setNombre:@"Carlos"];
    [arbitro4 setApellido:@"Servin"];
    [arbitro4 setUbicacion:@"Mesa"];
    
    Partido * partido = [[NSEntityDescription insertNewObjectForEntityForName:@"Partido" inManagedObjectContext:managedObjectContext]autorelease];
    
    [partido setFecha:[NSDate dateWithTimeIntervalSinceNow:NSTimeIntervalSince1970]];
    [partido setLugar:@"Cancha 1, El calvario, Mixquiahuala, Hidalgo"];
    [partido setEstado:@"Iniciado"];
    [partido setMinPorPeriodo:[NSNumber numberWithInt:10]];
    [partido setNumeroPeriodos:[NSNumber numberWithInt:4]];
    [partido setNumeroPartido:[NSNumber numberWithInt:3456]];
    [partido setEquipos:[NSSet setWithObjects:local, visita, nil]];
    [partido setArbitros:[NSSet setWithObjects:arbitro1, arbitro2, arbitro3, arbitro4, nil]];
    
    //[self salvarContexto];
    
}

- (void) salvarContexto
{
    NSError * error;
    
    if(![managedObjectContext save:&error])
    {
        NSLog(@"No se Logro Guardar los Jugadores");
    }
}

@end
