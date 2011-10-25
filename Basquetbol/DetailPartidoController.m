//
//  DetailPartidoController.m
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 13/10/11.
//  Copyright 2011 Valle del Bit. All rights reserved.
//

#import "DetailPartidoController.h"

@implementation DetailPartidoController

@synthesize imagenLocal;
@synthesize local;
@synthesize localScore;
@synthesize imagenVisita;
@synthesize visita;
@synthesize visitaScore;
@synthesize horario;
@synthesize lugar;
@synthesize estado;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    [super viewDidLoad];
    [self setTitle:@"partido"];
    self.navigationItem.rightBarButtonItem = 
    [[[UIBarButtonItem alloc] initWithTitle:@"equipos" style:UIBarButtonItemStyleBordered target:self action:@selector(showDetailEquipos:)] autorelease];
    [self showDetailPartido:[BasquetbolService partido]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) showDetailEquipos:(id) sender
{
    PartidosViewController * partidosViewController = [[PartidosViewController alloc]initWithNibName:@"PartidosViewController" bundle:nil];
    
    [[self navigationController] pushViewController:partidosViewController animated:YES];
    
    [partidosViewController release];
}

- (void)showDetailPartido: (Partido *) partido
{
    local.text = [[partido getEquipoLocal:YES] nombre];
    localScore.text = [NSString stringWithFormat:@"%i",[[partido getEquipoLocal:YES] puntosTotal]];
    visita.text = [[partido getEquipoLocal:NO] nombre];
    visitaScore.text = [NSString stringWithFormat:@"%i",[[partido getEquipoLocal:NO] puntosTotal]];
    horario.text = [[BasquetbolService partido] detailLongFecha];
    lugar.text = [partido lugar];
    if ([[partido estado] isEqualToString:@"Iniciado"]) 
        estado.on = YES;
    else
       estado.on = NO; 
     
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = [[[[[BasquetbolService partido] arbitros] allObjects] objectAtIndex:indexPath.row] description];
    cell.detailTextLabel.text = [[[[[BasquetbolService partido] arbitros] allObjects] objectAtIndex:indexPath.row] detailArbitro];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[BasquetbolService partido] arbitros] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Arbitros";
}

@end
