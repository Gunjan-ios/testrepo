//
//  ViewController.m
//  TestSpatialite
//
//  Created by Gaurav on 24/07/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

#import "ViewController.h"
#import "sqlite3.h"
#import "spatialite.h"
#import <FMDatabase.h>
#import <FMDB/FMDatabase.h>
#import <spatialite/gaiageo.h>
#import <geos_c.h>
#import <CoreLocation/CoreLocation.h>
#import "KVICAppDelegate.h"


@interface ViewController () {
    GEOSContextHandle_t handle;
}

@end

@implementation ViewController {
     void *spatialite_conn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *spatialiteVersion = [self spatialiteLibVersion];
    NSLog(@"spatialite version: %@", spatialiteVersion);
    
    KVICAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSString *dbPath2 = [[appDelegate GetDocumentDirectory] stringByAppendingPathComponent:@"GISdb.sqlite"];
    NSLog(@"%@",dbPath2);
    
    //NSString *dbPath2 = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"GISdb.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath2];
    
    if (![db open]) {
        // [db release];   // uncomment this line in manual referencing code; in ARC, this is not necessary/permitted
        db = nil;
    } else {
        NSLog(@"Database is open");
    }
    
    sqlite3* database2 = db.getDB;
    
    spatialite_init_geos();
    spatialite_conn = spatialite_alloc_connection();
    spatialite_init_ex(database2, spatialite_conn, 1);
    
    handle = initGEOS_r(notice, log_and_exit);
    
    
    FMResultSet *rs = [db executeQuery:@"select AsWKT(geom) from data_4"];
    while ([rs next])
    {
        id object = [rs resultDictionary];
        
        NSLog(@"%@", object);
    }
    
    NSString *sqlQuery = [NSString stringWithFormat:@"INSERT INTO data_4 (geometry, position, geom ,ggg) VALUES(%s, %s, %s, %s)", "'Point'", "'-135789.862744 6833532.539844'", "GeomFromText('Point(-135789.862772297 6833532.539886988)', 3857)", "'dfd'"];
    
    NSLog(@"%@",sqlQuery);
    
    BOOL success = [db executeUpdate:sqlQuery];
    if (!success) {
        NSLog(@"error = %@", [db lastErrorMessage]);
    }
    
    
    [db close];
    
    
    return;
 
    
 
    
    NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"GISdb.sqlite"];
    
    sqlite3* database;
    int dbOpen = sqlite3_open_v2 ([dbPath cStringUsingEncoding:NSUTF8StringEncoding], &database, SQLITE_OPEN_READONLY, NULL);
    if (dbOpen != SQLITE_OK)
        NSLog(@"Error");
    else
        NSLog(@"Database is open");
    
    spatialite_init_geos();
    spatialite_conn = spatialite_alloc_connection();
    spatialite_init_ex(database, spatialite_conn, 1);
    
    handle = initGEOS_r(notice, log_and_exit);
  
    
    NSString *query =[NSString stringWithFormat:@"select ASText(geom) from data_4"];
    
    const char *sql = [query cStringUsingEncoding:NSUTF8StringEncoding];
    sqlite3_stmt *statement;
    int returnValue = sqlite3_prepare_v2(database, sql, -1, &statement, NULL);
    
    
    
    const void *blob;
    int blob_size;
    gaiaGeomCollPtr geom;
    int clindex = 0;
    
    if (returnValue == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
           // geom =  sqlite3_column_text(statement, clindex);
            char* nameAsChar = (char*)sqlite3_column_text(statement, clindex);
            NSString* name  =@"-";
            if (nameAsChar!=NULL)
                name = [NSString stringWithUTF8String:nameAsChar];
            NSLog(@"The region name is:%@", name);
            
            /*
            //
            
            blob = sqlite3_column_blob (statement, clindex);
            blob_size = sqlite3_column_bytes (statement, clindex);
            
            /* checking if this BLOB actually is a GEOMETRY */
          /*  geom = gaiaFromSpatiaLiteBlobWkb (blob, blob_size);
            if (!geom)
            {   // not a geometry
                return;
            }
            else
            {
                
             
            
                    // [self geometryWithGEOSGeometry:gaiaToGeos(geom)];
                
                GEOSGeometry *geosGeom = (GEOSGeometry *)gaiaToGeos(geom);
                char *typeString = GEOSGeomType_r(handle, geosGeom);
                printf(typeString);
                
       
                
            }
            */
            //
        }
    }
    
  /*
    // NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"GISdb.sqlite"];
    NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"GISdb.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    
   
    
    
    if (![db open]) {
        // [db release];   // uncomment this line in manual referencing code; in ARC, this is not necessary/permitted
        db = nil;
    } else {
        NSLog(@"Database is open");
    }
    

    
    
    FMResultSet *rs = [db executeQuery:@"select GeomFromWKB(geom) from data_4"];
    while ([rs next])
    {
        id object = [rs resultDictionary];
        
        NSLog(@"%@", object);
    }
    
    [db close];
    */
    
}

- (void) geometryWithGEOSGeometry: (void *)geometry
{
    GEOSGeometry *geosGeom = (GEOSGeometry *)geometry;
    
    BOOL isValid =  (GEOSisValid_r(handle, geosGeom) == 1);
    
    // Not a valid geometry object
    if (!isValid || geosGeom == NULL) return;
    
    char *typeString = GEOSGeomType_r(handle, geosGeom);
    printf(typeString);
    
    Class geomClass = [self classForGeometry: geosGeom];
    if (!geomClass)
    {
        NSLog(@"Shapekit error: geometry type '%@' not supported.", [NSString stringWithUTF8String: GEOSGeomType_r(handle, geosGeom)]);
        return;
    }
    
    
   // return [[geomClass alloc] initWithGeosGeometry: geosGeom];
}


- (Class )classForGeometry: (GEOSGeometry *)geosGeom
{
    int geomTypeID = GEOSGeomTypeId_r(handle, geosGeom);
    Class geomClass = nil;
    switch (geomTypeID)
    {
        case GEOS_POINT:
           // geomClass = [ShapeKitPoint class];
            printf("Point");
            break;
        case GEOS_LINESTRING:
           // geomClass = [ShapeKitPolyline class];
            printf("ShapeKitPolyline");
            break;
        case GEOS_LINEARRING:
            break;
        case GEOS_POLYGON:
           // geomClass = [ShapeKitPolygon class];
            printf("ShapeKitPolygon");
            break;
        case GEOS_MULTIPOINT:
           // geomClass = [ShapeKitMultiPoint class];
            printf("ShapeKitMultiPoint");
            break;
        case GEOS_MULTILINESTRING:
            //geomClass = [ShapeKitMultiPolyline class];
            printf("ShapeKitMultiPolyline");
            break;
        case GEOS_MULTIPOLYGON:
           // geomClass = [ShapeKitMultiPolygon class];
            printf("ShapeKitMultiPolygon");
            break;
        case GEOS_GEOMETRYCOLLECTION:
           // geomClass = [ShapeKitGeometryCollection class];
            printf("ShapeKitGeometryCollection");
            break;
    }
    
    return geomClass;
}

#pragma mark GEOS init functions
void notice(const char *fmt,...) {
    va_list ap;
    
    fprintf( stdout, "NOTICE: ");
    
    va_start (ap, fmt);
    vfprintf( stdout, fmt, ap);
    va_end(ap);
    fprintf( stdout, "\n" );
}

void log_and_exit(const char *fmt,...) {
    va_list ap;
    
    fprintf( stdout, "ERROR: ");
    
    va_start (ap, fmt);
    vfprintf( stdout, fmt, ap);
    va_end(ap);
    fprintf( stdout, "\n" );
    //    exit(1);
}

- (NSString*)spatialiteLibVersion
{
    return [NSString stringWithFormat:@"%s", spatialite_version()];
}



@end
