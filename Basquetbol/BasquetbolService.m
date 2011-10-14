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
        partidos = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)setPartidos:(NSMutableArray *) losPartidos
{
    partidos = losPartidos;
}

-(NSMutableArray *) partidos
{
    if([partidos count]==0)
    {
        [self setPartidos:[self getPartidosOfContext]];
        if([partidos count]==0)
        {
            [self initializeDatosTest];
            [self setPartidos:[self getPartidosOfContext]];
        }
    }
    
    return partidos;
}

- (void)dealloc
{
    [partidos release];
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

-(void) initializeDatosTest
{
    NSError * error;
    
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
    [partido setNumeroPartido:[NSNumber numberWithInt:3456]];
    [partido setEquipos:[NSSet setWithObjects:local, visita, nil]];
    [partido setArbitros:[NSSet setWithObjects:arbitro1, arbitro2, arbitro3, arbitro4, nil]];
    
    if(![managedObjectContext save:&error])
    {
        NSLog(@"No se Logro Guardar los Jugadores");
    }
    
}

@end
