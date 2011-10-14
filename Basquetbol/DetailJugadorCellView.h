//
//  DetailJugadorCellView.h
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 14/10/11.
//  Copyright 2011 Valle del Bit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasquetbolService.h"
#import "Jugador.h"

@interface DetailJugadorCellView : UITableViewCell
{

    UIImageView * imagenEstadistica; 
    UILabel * primer;
    UILabel * segundo;
    UILabel * tercer;
    UILabel * cuarto;
    UILabel * total;
}
@property(nonatomic, retain)IBOutlet UIImageView * imagenEstadistica;
@property(nonatomic, retain)IBOutlet UILabel * primer;
@property(nonatomic, retain)IBOutlet UILabel * segundo;
@property(nonatomic, retain)IBOutlet UILabel * tercer;
@property(nonatomic, retain)IBOutlet UILabel * cuarto;
@property(nonatomic, retain)IBOutlet UILabel * total;

@end
