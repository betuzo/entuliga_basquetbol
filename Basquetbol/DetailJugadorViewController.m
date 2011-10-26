//
//  DetailJugadorViewController.m
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 14/10/11.
//  Copyright 2011 Valle del Bit. All rights reserved.
//

#import "DetailJugadorViewController.h"

@implementation DetailJugadorViewController

@synthesize imagenJugador;
@synthesize numero;
@synthesize nombre;
@synthesize apellido;
@synthesize posicion;
@synthesize estado;
@synthesize tabla;

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
    [self setTitle:[[[BasquetbolService jugador] equipo] nombre]];
    [super viewDidLoad];
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
    [[self tabla] reloadData];

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
    
    UILongPressGestureRecognizer * longPress = [[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longHelpHappened:)] autorelease];
    longPress.minimumPressDuration = 1;
    [cell addGestureRecognizer:longPress];
    
    cell.estadistica.text = [BasquetbolService getNombreEstadisticaByRow:indexPath.row];
    cell.primer.text = [NSString stringWithFormat:@"%i", [BasquetbolService getEstadisticasByRow:indexPath.row byPeriodo:1 atJuego:[BasquetbolService jugador]]];
    cell.segundo.text = [NSString stringWithFormat:@"%i", [BasquetbolService getEstadisticasByRow:indexPath.row byPeriodo:2 atJuego:[BasquetbolService jugador]]];
    cell.tercer.text = [NSString stringWithFormat:@"%i", [BasquetbolService getEstadisticasByRow:indexPath.row byPeriodo:3 atJuego:[BasquetbolService jugador]]];
    cell.cuarto.text = [NSString stringWithFormat:@"%i", [BasquetbolService getEstadisticasByRow:indexPath.row byPeriodo:4 atJuego:[BasquetbolService jugador]]];
    cell.total.text = [NSString stringWithFormat:@"%i", [BasquetbolService getEstadisticasByRow:indexPath.row byPeriodo:0 atJuego:[BasquetbolService jugador]]];
    cell.tag = indexPath.row;
    // Configure the cell.
    return cell;

}

-(void) longHelpHappened:(UIGestureRecognizer *) recognizer
{
    if ([recognizer state] == UIGestureRecognizerStateBegan)
    {
        DetailEstadisticaViewController *detailViewController = [[DetailEstadisticaViewController alloc] initWithNibName:@"DetailEstadisticaViewController" bundle:nil];
        // ...
        [detailViewController setEstadistica:[BasquetbolService getNombreEstadisticaByRow:[[recognizer view] tag]]];
        [self.navigationController pushViewController:detailViewController animated:YES];
        [detailViewController release];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[BasquetbolService estadisticas] objectAtIndex:0] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Estadisticas";
}

- (void)showDetailJugador
{
    numero.text = [NSString stringWithFormat:@"%@",[[BasquetbolService jugador] numero]];
    nombre.text = [[BasquetbolService jugador] nombre];
    apellido.text = [[BasquetbolService jugador] apellido];
    posicion.text = [[BasquetbolService jugador] posicion];
    estado.text = [[BasquetbolService jugador] estado];
}

-(void) dealloc
{   
    [super dealloc];
}

@end
