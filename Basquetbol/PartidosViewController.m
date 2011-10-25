//
//  PartidosViewController.m
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 12/10/11.
//  Copyright 2011 Valle del Bit. All rights reserved.
//

#import "PartidosViewController.h"

@implementation PartidosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setTitle:@"equipos"];
    [super viewWillAppear:animated];
    [self reloadInputViews];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[BasquetbolService partido] equipos] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[[[[BasquetbolService partido] equipos]allObjects] objectAtIndex:section] jugadores] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Equipo * tempEquipo = [[[[BasquetbolService partido] equipos]allObjects] objectAtIndex:section];
    return [[[NSString alloc] initWithFormat:@"%@ - %@", [tempEquipo nombre], [tempEquipo tipoEquipo]] autorelease]; // ¿Esta bien el autorelease?
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"JugadorCell";
    
    JugadorCellView * cell = (JugadorCellView *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray * nibObjects = [[NSBundle mainBundle] loadNibNamed:@"JugadorCell" owner:self options:nil];
    
    if (cell == nil) {
        for (id objetoActual in nibObjects) {
            if ([objetoActual isKindOfClass:[UITableViewCell class]] && 
                [[objetoActual reuseIdentifier] isEqualToString:CellIdentifier]) {
                cell = objetoActual;
            }
        }
    }
    
    Jugador * tempJugador = (Jugador *)[[[[[[[BasquetbolService partido] equipos]allObjects] objectAtIndex:indexPath.section] jugadores] allObjects] objectAtIndex:indexPath.row];
    
    cell.labelNombre.text = [[[NSString alloc] initWithFormat:@"%@ - %@", tempJugador.numero, tempJugador.nombre] autorelease]; // ¿Esta bien el autorelease?
    cell.labelEstado.text = tempJugador.estado;
    cell.labelPuntos.text = [NSString stringWithFormat:@"%i PTS", [BasquetbolService getEstadisticasByRow:1 byPeriodo:0 atJuego:tempJugador]];
    cell.labelFaltas.text = [NSString stringWithFormat:@"%i FTS", [BasquetbolService getEstadisticasByRow:2 byPeriodo:0 atJuego:tempJugador]];
    cell.labelMinutos.text = [NSString stringWithFormat:@"%i MIN", [BasquetbolService getEstadisticasByRow:0 byPeriodo:0 atJuego:tempJugador]];
    cell.imageView.image = [BasquetbolService getImageByPosicion:tempJugador.posicion];
    // Configure the cell.
    return cell;
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 static NSString *CellIdentifier = @"Cell";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 if (cell == nil) {
 cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
 }
 
 Jugador * tempJugador = (Jugador *)[[[[equipos objectAtIndex:indexPath.section] jugadores] allObjects] objectAtIndex:indexPath.row];
 
 cell.textLabel.text = tempJugador.nombre;
 cell.detailTextLabel.text = tempJugador.posicion;
 // Configure the cell.
 return cell;
 }
 */
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete)
 {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert)
 {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     DetailJugadorViewController *detailViewController = [[[DetailJugadorViewController alloc] initWithNibName:@"DetailJugadorViewController" bundle:nil] autorelease];
     [BasquetbolService setJugador:[[[[[[[BasquetbolService partido] equipos]allObjects] objectAtIndex:indexPath.section] jugadores] allObjects] objectAtIndex:indexPath.row]];
     [self.navigationController pushViewController:detailViewController animated:YES];     
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
}

@end
