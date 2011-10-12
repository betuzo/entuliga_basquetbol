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
        jugadores = [[NSMutableArray alloc] init];
        equipos = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)setEquipos:(NSMutableArray *) losEquipos
{
    equipos = losEquipos;
}

-(NSMutableArray *) equipos
{
    if([equipos count]==0)
    {
        [self setEquipos:[self getEquiposOfContext]];
        if([equipos count]==0)
        {
            [self initializeDatosTest];
            [self setEquipos:[self getEquiposOfContext]];
        }
        
    }
    
    return equipos;
}

-(void)setJugadores:(NSMutableArray *) losJugadores
{
    jugadores = losJugadores;
}

-(NSMutableArray *) jugadores
{
    if([jugadores count]==0)
    {
        [self setJugadores:[self getJugadoresOfContext]];
        if([jugadores count]==0)
        {
            [self initializeDatosTest];
            [self setJugadores:[self getJugadoresOfContext]];
        }
            
    }
    
    return jugadores;
}

- (void)dealloc
{
    [jugadores release];
    [equipos release];
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

-(NSMutableArray *) getEquiposOfContext
{
    NSError * error;
    
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Equipo" inManagedObjectContext:managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    equipos = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    NSLog(@"%i", [equipos count]);
    
    [request release];
    
    // ¿Es corecto que solo libere estos objetos? son los únicos a los que les hice alloc
    
    
    return equipos;
}

-(NSMutableArray *) getJugadoresOfContext
{
    NSError * error;
    
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Jugador" inManagedObjectContext:managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    NSSortDescriptor * sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"numero" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject: sortDescriptor]];
    
    jugadores = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    NSLog(@"%i", [jugadores count]);
    
    [sortDescriptor release];
    [request release];
    
    // ¿Es corecto que solo libere estos objetos? son los únicos a los que les hice alloc
    
    return jugadores;
}

-(void) initializeDatosTest
{
    NSError * error;
    
    Equipo * local = [NSEntityDescription insertNewObjectForEntityForName:@"Equipo" inManagedObjectContext:managedObjectContext];
    
    [local setNombre:@"Fox"];
    [local setMascota:@"Zorros"];
    [local setLocal:@"Si"];
    
    Equipo * visita = [NSEntityDescription insertNewObjectForEntityForName:@"Equipo" inManagedObjectContext:managedObjectContext];
    
    [visita setNombre:@"Cavaliers"];
    [visita setMascota:@"Carro"];
    [visita setLocal:@"No"];
    
    if(![managedObjectContext save:&error])
    {
        NSLog(@"No se Logro Guardar los Equipos");
    }
    
    Jugador * jugador1 = [NSEntityDescription insertNewObjectForEntityForName:@"Jugador" inManagedObjectContext:managedObjectContext];
    
    [jugador1 setNombre:@"Betuzo"];
    [jugador1 setApellido:@"Olguin"];
    [jugador1 setPosicion:@"Poste Derecho"];
    [jugador1 setEstado:@"Titular"];
    [jugador1 setNumero:[NSNumber numberWithInt:1]];
    [jugador1 setEquipo:local];
    
    Jugador * jugador2 = [NSEntityDescription insertNewObjectForEntityForName:@"Jugador" inManagedObjectContext:managedObjectContext];
    
    [jugador2 setNombre:@"Ruben"];
    [jugador2 setApellido:@"Barcenas"];
    [jugador2 setPosicion:@"Ala Derecha"];
    [jugador2 setEstado:@"Titular"];
    [jugador2 setNumero:[NSNumber numberWithInt:2]];
    [jugador2 setEquipo:local];
    
    Jugador * jugador3 = [NSEntityDescription insertNewObjectForEntityForName:@"Jugador" inManagedObjectContext:managedObjectContext];
    
    [jugador3 setNombre:@"Eduardo"];
    [jugador3 setApellido:@"Cruz"];
    [jugador3 setPosicion:@"Ala Izquierda"];
    [jugador3 setEstado:@"Titular"];
    [jugador3 setNumero:[NSNumber numberWithInt:7]];
    [jugador3 setEquipo:local];
    
    Jugador * jugador4 = [NSEntityDescription insertNewObjectForEntityForName:@"Jugador" inManagedObjectContext:managedObjectContext];
    
    [jugador4 setNombre:@"Hasiel"];
    [jugador4 setApellido:@"Lopez"];
    [jugador4 setPosicion:@"Poste Izquierdo"];
    [jugador4 setEstado:@"Titular"];
    [jugador4 setNumero:[NSNumber numberWithInt:8]];
    [jugador4 setEquipo:local];
    
    Jugador * jugador5 = [NSEntityDescription insertNewObjectForEntityForName:@"Jugador" inManagedObjectContext:managedObjectContext];
    
    [jugador5 setNombre:@"Raul"];
    [jugador5 setApellido:@"Guerrero"];
    [jugador5 setPosicion:@"Movedor"];
    [jugador5 setEstado:@"Titular"];
    [jugador5 setNumero:[NSNumber numberWithInt:10]];
    [jugador5 setEquipo:local];
    
    Jugador * jugador6 = [NSEntityDescription insertNewObjectForEntityForName:@"Jugador" inManagedObjectContext:managedObjectContext];
    
    [jugador6 setNombre:@"Joel"];
    [jugador6 setApellido:@"Andrade"];
    [jugador6 setPosicion:@"Poste Derecho"];
    [jugador6 setEstado:@"Titular"];
    [jugador6 setNumero:[NSNumber numberWithInt:2]];
    [jugador6 setEquipo:visita];
    
    Jugador * jugador7 = [NSEntityDescription insertNewObjectForEntityForName:@"Jugador" inManagedObjectContext:managedObjectContext];
    
    [jugador7 setNombre:@"Gerardo"];
    [jugador7 setApellido:@"Flores"];
    [jugador7 setPosicion:@"Poste Izquierdo"];
    [jugador7 setEstado:@"Titular"];
    [jugador7 setNumero:[NSNumber numberWithInt:3]];
    [jugador7 setEquipo:visita];
    
    Jugador * jugador8 = [NSEntityDescription insertNewObjectForEntityForName:@"Jugador" inManagedObjectContext:managedObjectContext];
    
    [jugador8 setNombre:@"Isidro"];
    [jugador8 setApellido:@"Licona"];
    [jugador8 setPosicion:@"Ala Derecha"];
    [jugador8 setEstado:@"Titular"];
    [jugador8 setNumero:[NSNumber numberWithInt:4]];
    [jugador8 setEquipo:visita];
    
    Jugador * jugador9 = [NSEntityDescription insertNewObjectForEntityForName:@"Jugador" inManagedObjectContext:managedObjectContext];
    
    [jugador9 setNombre:@"Mario"];
    [jugador9 setApellido:@"Rivera"];
    [jugador9 setPosicion:@"Ala Izquierda"];
    [jugador9 setEstado:@"Titular"];
    [jugador9 setNumero:[NSNumber numberWithInt:5]];
    [jugador9 setEquipo:visita];
    
    Jugador * jugador10 = [NSEntityDescription insertNewObjectForEntityForName:@"Jugador" inManagedObjectContext:managedObjectContext];
    
    [jugador10 setNombre:@"Luis"];
    [jugador10 setApellido:@"Lezama"];
    [jugador10 setPosicion:@"Movedor"];
    [jugador10 setEstado:@"Titular"];
    [jugador10 setNumero:[NSNumber numberWithInt:6]];
    [jugador10 setEquipo:visita];
    
    if(![managedObjectContext save:&error])
    {
        NSLog(@"No se Logro Guardar los Jugadores");
    }
    
    [local release];
    [visita release];
    [jugador1 release];
    [jugador2 release];
    [jugador3 release];
    [jugador4 release];
    [jugador5 release];
    [jugador6 release];
    [jugador7 release];
    [jugador8 release];
    [jugador9 release];
    [jugador10 release];
}

@end
