//
//  DetailJugadorCellView.m
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 14/10/11.
//  Copyright 2011 Valle del Bit. All rights reserved.
//

#import "DetailJugadorCellView.h"

@implementation DetailJugadorCellView

@synthesize imagenEstadistica;
@synthesize primer;
@synthesize segundo;
@synthesize tercer;
@synthesize cuarto;
@synthesize total;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
