//
//  Arbitro.h
//  Basquetbol
//
//  Created by Roberto Olguín Lozano on 12/10/11.
//  Copyright (c) 2011 Valle del Bit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Arbitro : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * apellido;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSNumber * numeroArbitro;
@property (nonatomic, retain) NSString * ubicacion;
@property (nonatomic, retain) NSManagedObject *partido;

- (NSString *)detailArbitro;

@end
