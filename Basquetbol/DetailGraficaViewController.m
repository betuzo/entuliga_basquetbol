//
//  DetailGraficaViewController.m
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 25/10/11.
//  Copyright (c) 2011 Valle del Bit. All rights reserved.
//

#import "DetailGraficaViewController.h"

@implementation DetailGraficaViewController

@synthesize estadistica;

- (IBAction) selEstadisticaChanged: (UISlider *) sender
{
    
    int valor = [sender value];
    
    [estadistica setText:[BasquetbolService getNombreEstadisticaByRow:valor]];
   
    [[self view] addSubview:[self graficaByRect:[self.view frame]]];
    /* esto yo creo que esta chafa porque estoy llenado de subviews el view :(*/
    /*
    for (UIView * view in [[self view] subviews]) {
        if (view != nil)
        {
            if ([view class]==[GraphView class])
            {
                ((GraphView *)view).estadistica = [estadistica text];
                [view drawRect:[view frame]];
            }
        }
    }*/
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


- (GraphView *) graficaByRect:(CGRect) frameGraphView
{
    frameGraphView.size.width = frameGraphView.size.width * .90;
    frameGraphView.size.height = frameGraphView.size.height * .70;
    if(frameGraphView.size.width < frameGraphView.size.height)
        frameGraphView.size.height = frameGraphView.size.width;
    else
        frameGraphView.size.width = frameGraphView.size.height;    
    frameGraphView.origin.x = ([self.view frame].size.width - frameGraphView.size.width) / 2;
    frameGraphView.origin.y = (([self.view frame].size.height - frameGraphView.size.height) - (frameGraphView.size.height * .05));
    
    
    GraphView * graphView = [[[GraphView alloc] initWithFrame:frameGraphView] autorelease];
    graphView.backgroundColor = [UIColor whiteColor];
    [graphView setEstadistica:[estadistica text]];
    return graphView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [estadistica setText:[BasquetbolService getNombreEstadisticaByRow:1]];
    [[self view] addSubview:[self graficaByRect:[self.view frame]]];    
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
