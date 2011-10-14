//
//  DetailJugadorViewController.m
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 14/10/11.
//  Copyright 2011 Valle del Bit. All rights reserved.
//

#import "DetailJugadorViewController.h"

@implementation DetailJugadorViewController

@synthesize service;
@synthesize imagenJugador;
@synthesize numero;
@synthesize nombre;
@synthesize apellido;
@synthesize posicion;
@synthesize estado;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self setTitle:[[jugador equipo] nombre]];
    [super viewDidLoad];
    estadisticas = [[NSArray alloc] initWithObjects:@"Minutos", @"Puntos", @"Faltas", @"Rebotes", @"Bloqueos", @"Asistencias", @"Robos", nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showDetailJugador];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DetailJugadorCellView";
    
    DetailJugadorCellView * cell = (DetailJugadorCellView *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray * nibObjects = [[NSBundle mainBundle] loadNibNamed:@"DetailJugadorCellView" owner:self options:nil];
    
    if (cell == nil) {
        for (id objetoActual in nibObjects) {
            if ([objetoActual isKindOfClass:[UITableViewCell class]] && 
                [[objetoActual reuseIdentifier] isEqualToString:CellIdentifier]) {
                cell = objetoActual;
            }
        }
    }
    
    cell.imagenEstadistica.image = nil;    
    cell.primer.text = @"4";
    cell.segundo.text = @"4";
    cell.tercer.text = @"2";
    cell.cuarto.text = @"16";
    cell.total.text = @"16";
    // Configure the cell.
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [estadisticas count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Estadisticas";
}

- (void)showDetailJugador
{
    numero.text = [NSString stringWithFormat:@"%@",[jugador numero]];
    nombre.text = [jugador nombre];
    apellido.text = [jugador apellido];
    posicion.text = [jugador posicion];
    estado.text = [jugador estado];
}

-(void) dealloc
{   
    [estadisticas dealloc];
    [super dealloc];
}

- (void) setJugador:(Jugador *) elJugador
{
    jugador = elJugador;
}

- (Jugador *) jugador
{
    return jugador;
}

@end
