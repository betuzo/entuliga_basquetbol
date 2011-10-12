//
//  JugadorCellView.h
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 11/10/11.
//  Copyright 2011 Valle del Bit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JugadorCellView : UITableViewCell
{
    UILabel * labelNombre;
    UILabel * labelEstado;
    UILabel * labelPuntos;
    UILabel * labelFaltas;
    UILabel * labelMinutos;
    UIImageView * imageView;
}
@property (nonatomic, retain) IBOutlet UILabel * labelNombre;
@property (nonatomic, retain) IBOutlet UILabel * labelEstado;
@property (nonatomic, retain) IBOutlet UILabel * labelPuntos;
@property (nonatomic, retain) IBOutlet UILabel * labelFaltas;
@property (nonatomic, retain) IBOutlet UILabel * labelMinutos;
@property (nonatomic, retain) IBOutlet UIImageView * imageView;
@end
