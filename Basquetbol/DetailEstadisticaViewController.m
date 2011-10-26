//
//  DetailEstadisticaViewController.m
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 20/10/11.
//  Copyright (c) 2011 Valle del Bit. All rights reserved.
//

#import "DetailEstadisticaViewController.h"

@implementation DetailEstadisticaViewController


@synthesize estadisticaPickerView;
@synthesize estadistica;
@synthesize tableEstadisticaView;

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return [infoEstadistica count];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [[infoEstadistica objectAtIndex:component] count];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{    
    switch (component) {
        case 0:
            return 50;
            break;
        case 1:
            return 100;
            break;
        case 2:
            return 150;
            break;
        default:
            return 100;
            break;
    }
}

- (NSString *)pickerView:
(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component
{
	return [[[infoEstadistica objectAtIndex:component] objectAtIndex:row] description];
}
    


- (void)handleTap:(UITapGestureRecognizer *)sender 
{     
    if ([sender state] == UIGestureRecognizerStateBegan)
    {
        primeraPos = [self view].frame;
        primeraPos.origin.y = [sender locationInView:[self view]].y;
        estadisticaPickerView.hidden = NO;
    }
    else if([sender state] == UIGestureRecognizerStateChanged)
    {
        CGFloat diferencia = ([sender locationInView:[self view]].y - primeraPos.origin.y);
        primeraPos = [self view].frame;
        primeraPos.origin.y = [sender locationInView:[self view]].y;
        
        CGRect ultimaPosTable = tableEstadisticaView.frame;
        ultimaPosTable.origin.y = ultimaPosTable.origin.y + diferencia;
        CGRect ultimaPosView = estadisticaPickerView.frame;
        ultimaPosView.origin.y = ultimaPosView.origin.y + diferencia;
        [UIView animateWithDuration:.03 animations:^{
            [tableEstadisticaView setFrame:ultimaPosTable];
            [estadisticaPickerView setFrame:ultimaPosView];
        }];
        
    }
    else if([sender state] == UIGestureRecognizerStateEnded)
    {
        if([tableEstadisticaView frame].origin.y > ([estadisticaPickerView frame].size.height * .5))
            [self presentaVistaInicial:YES];
        else
            [self presentaVistaInicial:NO];
    }
}   

- (void) presentaVistaInicial:(BOOL) si
{
    if (si == YES) 
    {
        [UIView animateWithDuration:.1 animations:^{
            CGRect frameFin = [tableEstadisticaView frame];
            frameFin.origin.y = [estadisticaPickerView frame].size.height;
            [tableEstadisticaView setFrame:frameFin];
            frameFin = [estadisticaPickerView frame];
            frameFin.origin.y = 0;
            [estadisticaPickerView setFrame:frameFin];
            estadisticaPickerView.hidden = !si;
        }];   
    }else{  
        CGRect frameFin = [estadisticaPickerView frame];
        frameFin.origin.y = -[estadisticaPickerView frame].size.height;
        [estadisticaPickerView setFrame:frameFin];
            estadisticaPickerView.hidden = !si;
        frameFin = [tableEstadisticaView frame];
        frameFin.origin.y = 0;
        [tableEstadisticaView setFrame:frameFin];
    }
}

- (void) addParticipante:(id) sender
{
    if(!estadisticaPickerView.hidden)
    {
        [BasquetbolService registraEstadistica:estadistica paraJugador:[BasquetbolService jugador] enMinuto:minuto deTipo:tipo involucradoAJugador:jugadorEstadistica];
        [[self  tableEstadisticaView] reloadData];

    }
    [self presentaVistaInicial:estadisticaPickerView.hidden];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            minuto = [[infoEstadistica objectAtIndex:component] objectAtIndex:row];
            break;
        case 1:
            tipo = [[infoEstadistica objectAtIndex:component] objectAtIndex:row];
            break;
        case 2:
            jugadorEstadistica = [[infoEstadistica objectAtIndex:component] objectAtIndex:row];
            break;
        default:
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{    
    return estadistica;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[BasquetbolService estadisticasPorJugador:[BasquetbolService jugador] PorTipo:estadistica] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [[[BasquetbolService estadisticasPorJugador:[BasquetbolService jugador] PorTipo:estadistica] objectAtIndex:indexPath.row] description];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

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
    [super viewDidLoad];
    infoEstadistica = [[BasquetbolService informacionDeEstadistica:estadistica paraJugador:[BasquetbolService jugador]] retain];  
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Agregar" style:UIBarButtonItemStyleBordered target:self action:@selector(addParticipante:)] autorelease];
    estadisticaPickerView.frame = CGRectMake(0, -estadisticaPickerView.frame.size.height, estadisticaPickerView.frame.size.width, estadisticaPickerView.frame.size.height);
    estadisticaPickerView.hidden = YES;
    [self setTitle:[[BasquetbolService jugador] description]];
    UIPanGestureRecognizer * prueba = [[[UIPanGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(handleTap:)] autorelease];  
    [tableEstadisticaView addGestureRecognizer:prueba];
    
    jugadorEstadistica = nil;
    if([infoEstadistica count] >= 2)
    {   
        if ([[infoEstadistica objectAtIndex:0] count] > 0) 
            minuto = [[infoEstadistica objectAtIndex:0] objectAtIndex:0];
        if ([[infoEstadistica objectAtIndex:1] count] > 0) 
            tipo = [[infoEstadistica objectAtIndex:1] objectAtIndex:0];
    }
    if([infoEstadistica count] == 3)
        if ([[infoEstadistica objectAtIndex:2] count] > 0)
            jugadorEstadistica = [[infoEstadistica objectAtIndex:2] objectAtIndex:0];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
