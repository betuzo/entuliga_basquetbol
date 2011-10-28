//
//  GraphView.m
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 27/10/11.
//  Copyright (c) 2011 Valle del Bit. All rights reserved.
//

#import "GraphView.h"

@interface ValorEstadistico : NSObject 

@property(nonatomic, strong) NSNumber * min;
@property(nonatomic, strong) NSNumber * val;

@end

@implementation ValorEstadistico

@synthesize min;
@synthesize val;

-(id)init
{
	self = [super init];
	if(self != nil)
	{
	}
	return self;
}

-(void)dealloc
{
	[super dealloc];
}

-(NSString *) description
{
    return [NSString stringWithFormat:@"m:%@ v:%@",min, val];
}

@end


@implementation GraphView

@synthesize estadistica;
@synthesize totalY;
@synthesize totalX;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during aniçmation.

- (void)pintaBaseGraficaRect:(CGRect)rect Context:(CGContextRef) context
{
    CGLayerRef layerBase = CGLayerCreateWithContext(context, rect.size, NULL);
    CGContextRef layerContext = CGLayerGetContext(layerBase);
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPoint superior;
    
    superior.x = 0;
    superior.y = 0;
    
    CGPathMoveToPoint(path, NULL, superior.x, superior.y);
    
    superior.x = 0;
    superior.y = rect.size.height;
    
    CGPathAddLineToPoint(path, NULL, superior.x, superior.y);
    
    superior.x = rect.size.width;
    superior.y = rect.size.height;
    
    CGPathAddLineToPoint(path, NULL, superior.x, superior.y);
    CGContextSetRGBStrokeColor(layerContext, 0, 0, 0, 1);
    CGContextSetLineWidth(layerContext, 1);
    CGContextAddPath(layerContext, path);
    CGContextStrokePath(layerContext);
    CGContextDrawLayerInRect(context, rect, layerBase);
    CGPathRelease(path);
    CGLayerRelease(layerBase);
}

- (void)pintaLineaRect:(CGRect)rect Context:(CGContextRef) context Estadistica:(NSString *) estsd byEquipo:(Equipo *) equipo
{
    CGLayerRef layerGraph = CGLayerCreateWithContext(context, rect.size, NULL);
    CGContextRef layerContext = CGLayerGetContext(layerGraph);
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPoint superior;
    
    superior.x = 0;
    superior.y = rect.size.height;
    
    CGPathMoveToPoint(path, NULL, superior.x, superior.y);

    NSMutableArray * puntos = [[NSMutableArray alloc] init];
    for (id est in [BasquetbolService estadisticasPorEquipo:equipo PorTipo:estsd]) {
        ValorEstadistico * punto =[[ValorEstadistico alloc] init];
        punto.min = [est min];
        if([estsd isEqualToString:@"PTS"])
            punto.val = [est valor];
        else
            punto.val = [NSNumber numberWithInt:1];
        [puntos addObject:punto];
        [punto release];
    }; 
    
    NSSortDescriptor *descr = [ NSSortDescriptor sortDescriptorWithKey:@"min" ascending:YES                                                    selector:@selector(compare:) ];
    NSArray *descrArray = [ NSArray arrayWithObject:descr ];
    NSArray *puntosOrdenados = [puntos sortedArrayUsingDescriptors:descrArray];
    [puntos release];

    superior.x = 0;
    superior.y = rect.size.height;
    
    for (id puntoOrdenado in puntosOrdenados) {
        superior.x = ([[puntoOrdenado min] intValue] * rect.size.width) / totalX;
        superior.y = superior.y - (([[puntoOrdenado val] intValue] * rect.size.height) / totalY);
        
        CGPathAddLineToPoint(path, NULL, superior.x, superior.y);
    }
   
    if ([[equipo local] isEqualToString:@"Si"])
        CGContextSetRGBStrokeColor(layerContext, 0, .6, 1, 1);
    else
        CGContextSetRGBStrokeColor(layerContext, 1, 0, 0, 1);
    CGContextSetLineWidth(layerContext, 1);
    CGContextAddPath(layerContext, path);
    CGContextStrokePath(layerContext);
    CGContextDrawLayerInRect(context, rect, layerGraph);
    CGPathRelease(path);
    CGLayerRelease(layerGraph);
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self pintaBaseGraficaRect:rect Context:context];
    
    totalX = [[[BasquetbolService partido] numeroPeriodos] intValue] * [[[BasquetbolService partido] minPorPeriodo] intValue];
    totalY = [BasquetbolService totalMayorPorEstadistica:estadistica PorPartido:[BasquetbolService partido]];
      
    for (id equipo in [[BasquetbolService partido]equipos])
    {
        [self pintaLineaRect:rect Context:context Estadistica:[self estadistica] byEquipo:equipo];
    }
}

@end
