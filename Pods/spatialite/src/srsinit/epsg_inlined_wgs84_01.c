/*

 helper function for srs_init.c -- populating the SPATIAL_REF_SYS table

 this code was autogenerated by "auto_epsg" on Wed Aug  1 15:15:05 2012

 Author: Sandro Furieri a.furieri@lqt.it

 -----------------------------------------------------------------------------

 Version: MPL 1.1/GPL 2.0/LGPL 2.1

 The contents of this file are subject to the Mozilla Public License Version
 1.1 (the "License"); you may not use this file except in compliance with
 the License. You may obtain a copy of the License at
 http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
for the specific language governing rights and limitations under the
License.

The Original Code is the SpatiaLite library

The Initial Developer of the Original Code is Alessandro Furieri

Portions created by the Initial Developer are Copyright (C) 2008
the Initial Developer. All Rights Reserved.

Contributor(s):

Alternatively, the contents of this file may be used under the terms of
either the GNU General Public License Version 2 or later (the "GPL"), or
the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
in which case the provisions of the GPL or the LGPL are applicable instead
of those above. If you wish to allow use of your version of this file only
under the terms of either the GPL or the LGPL, and not to allow others to
use your version of this file under the terms of the MPL, indicate your
decision by deleting the provisions above and replace them with the notice
and other provisions required by the GPL or the LGPL. If you do not delete
the provisions above, a recipient may use your version of this file under
the terms of any one of the MPL, the GPL or the LGPL.

*/

#include <spatialite_private.h>

SPATIALITE_PRIVATE void
initialize_epsg_wgs84_01 (int filter, struct epsg_defs **first, struct epsg_defs **last)
{
/* initializing the EPSG defs list [WGS84] */
    struct epsg_defs *p;
    p = add_epsg_def (filter, first, last, 32735, "epsg", 32735,
        "WGS 84 / UTM zone 35S");
    add_proj4text (p, 0,
        "+proj=utm +zone=35 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 35S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",27],PARAMETER[\"scale_fact");
    add_srs_wkt (p, 8,
        "or\",0.9996],PARAMETER[\"false_easting\",500000],PARAMET");
    add_srs_wkt (p, 9,
        "ER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHORI");
    add_srs_wkt (p, 10,
        "TY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"Nor");
    add_srs_wkt (p, 11,
        "thing\",NORTH],AUTHORITY[\"EPSG\",\"32735\"]]");
    p = add_epsg_def (filter, first, last, 32736, "epsg", 32736,
        "WGS 84 / UTM zone 36S");
    add_proj4text (p, 0,
        "+proj=utm +zone=36 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 36S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",33],PARAMETER[\"scale_fact");
    add_srs_wkt (p, 8,
        "or\",0.9996],PARAMETER[\"false_easting\",500000],PARAMET");
    add_srs_wkt (p, 9,
        "ER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHORI");
    add_srs_wkt (p, 10,
        "TY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"Nor");
    add_srs_wkt (p, 11,
        "thing\",NORTH],AUTHORITY[\"EPSG\",\"32736\"]]");
    p = add_epsg_def (filter, first, last, 32737, "epsg", 32737,
        "WGS 84 / UTM zone 37S");
    add_proj4text (p, 0,
        "+proj=utm +zone=37 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 37S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",39],PARAMETER[\"scale_fact");
    add_srs_wkt (p, 8,
        "or\",0.9996],PARAMETER[\"false_easting\",500000],PARAMET");
    add_srs_wkt (p, 9,
        "ER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHORI");
    add_srs_wkt (p, 10,
        "TY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"Nor");
    add_srs_wkt (p, 11,
        "thing\",NORTH],AUTHORITY[\"EPSG\",\"32737\"]]");
    p = add_epsg_def (filter, first, last, 32738, "epsg", 32738,
        "WGS 84 / UTM zone 38S");
    add_proj4text (p, 0,
        "+proj=utm +zone=38 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 38S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",45],PARAMETER[\"scale_fact");
    add_srs_wkt (p, 8,
        "or\",0.9996],PARAMETER[\"false_easting\",500000],PARAMET");
    add_srs_wkt (p, 9,
        "ER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHORI");
    add_srs_wkt (p, 10,
        "TY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"Nor");
    add_srs_wkt (p, 11,
        "thing\",NORTH],AUTHORITY[\"EPSG\",\"32738\"]]");
    p = add_epsg_def (filter, first, last, 32739, "epsg", 32739,
        "WGS 84 / UTM zone 39S");
    add_proj4text (p, 0,
        "+proj=utm +zone=39 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 39S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",51],PARAMETER[\"scale_fact");
    add_srs_wkt (p, 8,
        "or\",0.9996],PARAMETER[\"false_easting\",500000],PARAMET");
    add_srs_wkt (p, 9,
        "ER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHORI");
    add_srs_wkt (p, 10,
        "TY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"Nor");
    add_srs_wkt (p, 11,
        "thing\",NORTH],AUTHORITY[\"EPSG\",\"32739\"]]");
    p = add_epsg_def (filter, first, last, 32740, "epsg", 32740,
        "WGS 84 / UTM zone 40S");
    add_proj4text (p, 0,
        "+proj=utm +zone=40 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 40S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",57],PARAMETER[\"scale_fact");
    add_srs_wkt (p, 8,
        "or\",0.9996],PARAMETER[\"false_easting\",500000],PARAMET");
    add_srs_wkt (p, 9,
        "ER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHORI");
    add_srs_wkt (p, 10,
        "TY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"Nor");
    add_srs_wkt (p, 11,
        "thing\",NORTH],AUTHORITY[\"EPSG\",\"32740\"]]");
    p = add_epsg_def (filter, first, last, 32741, "epsg", 32741,
        "WGS 84 / UTM zone 41S");
    add_proj4text (p, 0,
        "+proj=utm +zone=41 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 41S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",63],PARAMETER[\"scale_fact");
    add_srs_wkt (p, 8,
        "or\",0.9996],PARAMETER[\"false_easting\",500000],PARAMET");
    add_srs_wkt (p, 9,
        "ER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHORI");
    add_srs_wkt (p, 10,
        "TY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"Nor");
    add_srs_wkt (p, 11,
        "thing\",NORTH],AUTHORITY[\"EPSG\",\"32741\"]]");
    p = add_epsg_def (filter, first, last, 32742, "epsg", 32742,
        "WGS 84 / UTM zone 42S");
    add_proj4text (p, 0,
        "+proj=utm +zone=42 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 42S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",69],PARAMETER[\"scale_fact");
    add_srs_wkt (p, 8,
        "or\",0.9996],PARAMETER[\"false_easting\",500000],PARAMET");
    add_srs_wkt (p, 9,
        "ER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHORI");
    add_srs_wkt (p, 10,
        "TY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"Nor");
    add_srs_wkt (p, 11,
        "thing\",NORTH],AUTHORITY[\"EPSG\",\"32742\"]]");
    p = add_epsg_def (filter, first, last, 32743, "epsg", 32743,
        "WGS 84 / UTM zone 43S");
    add_proj4text (p, 0,
        "+proj=utm +zone=43 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 43S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",75],PARAMETER[\"scale_fact");
    add_srs_wkt (p, 8,
        "or\",0.9996],PARAMETER[\"false_easting\",500000],PARAMET");
    add_srs_wkt (p, 9,
        "ER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHORI");
    add_srs_wkt (p, 10,
        "TY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"Nor");
    add_srs_wkt (p, 11,
        "thing\",NORTH],AUTHORITY[\"EPSG\",\"32743\"]]");
    p = add_epsg_def (filter, first, last, 32744, "epsg", 32744,
        "WGS 84 / UTM zone 44S");
    add_proj4text (p, 0,
        "+proj=utm +zone=44 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 44S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",81],PARAMETER[\"scale_fact");
    add_srs_wkt (p, 8,
        "or\",0.9996],PARAMETER[\"false_easting\",500000],PARAMET");
    add_srs_wkt (p, 9,
        "ER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHORI");
    add_srs_wkt (p, 10,
        "TY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"Nor");
    add_srs_wkt (p, 11,
        "thing\",NORTH],AUTHORITY[\"EPSG\",\"32744\"]]");
    p = add_epsg_def (filter, first, last, 32745, "epsg", 32745,
        "WGS 84 / UTM zone 45S");
    add_proj4text (p, 0,
        "+proj=utm +zone=45 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 45S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",87],PARAMETER[\"scale_fact");
    add_srs_wkt (p, 8,
        "or\",0.9996],PARAMETER[\"false_easting\",500000],PARAMET");
    add_srs_wkt (p, 9,
        "ER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHORI");
    add_srs_wkt (p, 10,
        "TY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"Nor");
    add_srs_wkt (p, 11,
        "thing\",NORTH],AUTHORITY[\"EPSG\",\"32745\"]]");
    p = add_epsg_def (filter, first, last, 32746, "epsg", 32746,
        "WGS 84 / UTM zone 46S");
    add_proj4text (p, 0,
        "+proj=utm +zone=46 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 46S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",93],PARAMETER[\"scale_fact");
    add_srs_wkt (p, 8,
        "or\",0.9996],PARAMETER[\"false_easting\",500000],PARAMET");
    add_srs_wkt (p, 9,
        "ER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHORI");
    add_srs_wkt (p, 10,
        "TY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"Nor");
    add_srs_wkt (p, 11,
        "thing\",NORTH],AUTHORITY[\"EPSG\",\"32746\"]]");
    p = add_epsg_def (filter, first, last, 32747, "epsg", 32747,
        "WGS 84 / UTM zone 47S");
    add_proj4text (p, 0,
        "+proj=utm +zone=47 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 47S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",99],PARAMETER[\"scale_fact");
    add_srs_wkt (p, 8,
        "or\",0.9996],PARAMETER[\"false_easting\",500000],PARAMET");
    add_srs_wkt (p, 9,
        "ER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHORI");
    add_srs_wkt (p, 10,
        "TY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"Nor");
    add_srs_wkt (p, 11,
        "thing\",NORTH],AUTHORITY[\"EPSG\",\"32747\"]]");
    p = add_epsg_def (filter, first, last, 32748, "epsg", 32748,
        "WGS 84 / UTM zone 48S");
    add_proj4text (p, 0,
        "+proj=utm +zone=48 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 48S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",105],PARAMETER[\"scale_fac");
    add_srs_wkt (p, 8,
        "tor\",0.9996],PARAMETER[\"false_easting\",500000],PARAME");
    add_srs_wkt (p, 9,
        "TER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHOR");
    add_srs_wkt (p, 10,
        "ITY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"No");
    add_srs_wkt (p, 11,
        "rthing\",NORTH],AUTHORITY[\"EPSG\",\"32748\"]]");
    p = add_epsg_def (filter, first, last, 32749, "epsg", 32749,
        "WGS 84 / UTM zone 49S");
    add_proj4text (p, 0,
        "+proj=utm +zone=49 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 49S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",111],PARAMETER[\"scale_fac");
    add_srs_wkt (p, 8,
        "tor\",0.9996],PARAMETER[\"false_easting\",500000],PARAME");
    add_srs_wkt (p, 9,
        "TER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHOR");
    add_srs_wkt (p, 10,
        "ITY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"No");
    add_srs_wkt (p, 11,
        "rthing\",NORTH],AUTHORITY[\"EPSG\",\"32749\"]]");
    p = add_epsg_def (filter, first, last, 32750, "epsg", 32750,
        "WGS 84 / UTM zone 50S");
    add_proj4text (p, 0,
        "+proj=utm +zone=50 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 50S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",117],PARAMETER[\"scale_fac");
    add_srs_wkt (p, 8,
        "tor\",0.9996],PARAMETER[\"false_easting\",500000],PARAME");
    add_srs_wkt (p, 9,
        "TER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHOR");
    add_srs_wkt (p, 10,
        "ITY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"No");
    add_srs_wkt (p, 11,
        "rthing\",NORTH],AUTHORITY[\"EPSG\",\"32750\"]]");
    p = add_epsg_def (filter, first, last, 32751, "epsg", 32751,
        "WGS 84 / UTM zone 51S");
    add_proj4text (p, 0,
        "+proj=utm +zone=51 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 51S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",123],PARAMETER[\"scale_fac");
    add_srs_wkt (p, 8,
        "tor\",0.9996],PARAMETER[\"false_easting\",500000],PARAME");
    add_srs_wkt (p, 9,
        "TER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHOR");
    add_srs_wkt (p, 10,
        "ITY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"No");
    add_srs_wkt (p, 11,
        "rthing\",NORTH],AUTHORITY[\"EPSG\",\"32751\"]]");
    p = add_epsg_def (filter, first, last, 32752, "epsg", 32752,
        "WGS 84 / UTM zone 52S");
    add_proj4text (p, 0,
        "+proj=utm +zone=52 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 52S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",129],PARAMETER[\"scale_fac");
    add_srs_wkt (p, 8,
        "tor\",0.9996],PARAMETER[\"false_easting\",500000],PARAME");
    add_srs_wkt (p, 9,
        "TER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHOR");
    add_srs_wkt (p, 10,
        "ITY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"No");
    add_srs_wkt (p, 11,
        "rthing\",NORTH],AUTHORITY[\"EPSG\",\"32752\"]]");
    p = add_epsg_def (filter, first, last, 32753, "epsg", 32753,
        "WGS 84 / UTM zone 53S");
    add_proj4text (p, 0,
        "+proj=utm +zone=53 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 53S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",135],PARAMETER[\"scale_fac");
    add_srs_wkt (p, 8,
        "tor\",0.9996],PARAMETER[\"false_easting\",500000],PARAME");
    add_srs_wkt (p, 9,
        "TER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHOR");
    add_srs_wkt (p, 10,
        "ITY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"No");
    add_srs_wkt (p, 11,
        "rthing\",NORTH],AUTHORITY[\"EPSG\",\"32753\"]]");
    p = add_epsg_def (filter, first, last, 32754, "epsg", 32754,
        "WGS 84 / UTM zone 54S");
    add_proj4text (p, 0,
        "+proj=utm +zone=54 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 54S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",141],PARAMETER[\"scale_fac");
    add_srs_wkt (p, 8,
        "tor\",0.9996],PARAMETER[\"false_easting\",500000],PARAME");
    add_srs_wkt (p, 9,
        "TER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHOR");
    add_srs_wkt (p, 10,
        "ITY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"No");
    add_srs_wkt (p, 11,
        "rthing\",NORTH],AUTHORITY[\"EPSG\",\"32754\"]]");
    p = add_epsg_def (filter, first, last, 32755, "epsg", 32755,
        "WGS 84 / UTM zone 55S");
    add_proj4text (p, 0,
        "+proj=utm +zone=55 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 55S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",147],PARAMETER[\"scale_fac");
    add_srs_wkt (p, 8,
        "tor\",0.9996],PARAMETER[\"false_easting\",500000],PARAME");
    add_srs_wkt (p, 9,
        "TER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHOR");
    add_srs_wkt (p, 10,
        "ITY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"No");
    add_srs_wkt (p, 11,
        "rthing\",NORTH],AUTHORITY[\"EPSG\",\"32755\"]]");
    p = add_epsg_def (filter, first, last, 32756, "epsg", 32756,
        "WGS 84 / UTM zone 56S");
    add_proj4text (p, 0,
        "+proj=utm +zone=56 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 56S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",153],PARAMETER[\"scale_fac");
    add_srs_wkt (p, 8,
        "tor\",0.9996],PARAMETER[\"false_easting\",500000],PARAME");
    add_srs_wkt (p, 9,
        "TER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHOR");
    add_srs_wkt (p, 10,
        "ITY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"No");
    add_srs_wkt (p, 11,
        "rthing\",NORTH],AUTHORITY[\"EPSG\",\"32756\"]]");
    p = add_epsg_def (filter, first, last, 32757, "epsg", 32757,
        "WGS 84 / UTM zone 57S");
    add_proj4text (p, 0,
        "+proj=utm +zone=57 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 57S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",159],PARAMETER[\"scale_fac");
    add_srs_wkt (p, 8,
        "tor\",0.9996],PARAMETER[\"false_easting\",500000],PARAME");
    add_srs_wkt (p, 9,
        "TER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHOR");
    add_srs_wkt (p, 10,
        "ITY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"No");
    add_srs_wkt (p, 11,
        "rthing\",NORTH],AUTHORITY[\"EPSG\",\"32757\"]]");
    p = add_epsg_def (filter, first, last, 32758, "epsg", 32758,
        "WGS 84 / UTM zone 58S");
    add_proj4text (p, 0,
        "+proj=utm +zone=58 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 58S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",165],PARAMETER[\"scale_fac");
    add_srs_wkt (p, 8,
        "tor\",0.9996],PARAMETER[\"false_easting\",500000],PARAME");
    add_srs_wkt (p, 9,
        "TER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHOR");
    add_srs_wkt (p, 10,
        "ITY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"No");
    add_srs_wkt (p, 11,
        "rthing\",NORTH],AUTHORITY[\"EPSG\",\"32758\"]]");
    p = add_epsg_def (filter, first, last, 32759, "epsg", 32759,
        "WGS 84 / UTM zone 59S");
    add_proj4text (p, 0,
        "+proj=utm +zone=59 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 59S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",171],PARAMETER[\"scale_fac");
    add_srs_wkt (p, 8,
        "tor\",0.9996],PARAMETER[\"false_easting\",500000],PARAME");
    add_srs_wkt (p, 9,
        "TER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHOR");
    add_srs_wkt (p, 10,
        "ITY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"No");
    add_srs_wkt (p, 11,
        "rthing\",NORTH],AUTHORITY[\"EPSG\",\"32759\"]]");
    p = add_epsg_def (filter, first, last, 32760, "epsg", 32760,
        "WGS 84 / UTM zone 60S");
    add_proj4text (p, 0,
        "+proj=utm +zone=60 +south +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UTM zone 60S\",GEOGCS[\"WGS 84\",DATUM");
    add_srs_wkt (p, 1,
        "[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,");
    add_srs_wkt (p, 2,
        "AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"");
    add_srs_wkt (p, 3,
        "]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],");
    add_srs_wkt (p, 4,
        "UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"");
    add_srs_wkt (p, 5,
        "9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Tran");
    add_srs_wkt (p, 6,
        "sverse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],P");
    add_srs_wkt (p, 7,
        "ARAMETER[\"central_meridian\",177],PARAMETER[\"scale_fac");
    add_srs_wkt (p, 8,
        "tor\",0.9996],PARAMETER[\"false_easting\",500000],PARAME");
    add_srs_wkt (p, 9,
        "TER[\"false_northing\",10000000],UNIT[\"metre\",1,AUTHOR");
    add_srs_wkt (p, 10,
        "ITY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"No");
    add_srs_wkt (p, 11,
        "rthing\",NORTH],AUTHORITY[\"EPSG\",\"32760\"]]");
    p = add_epsg_def (filter, first, last, 32761, "epsg", 32761,
        "WGS 84 / UPS South (N,E)");
    add_proj4text (p, 0,
        "+proj=stere +lat_0=-90 +lat_ts=-90 +lon_0=0 +k=0.994 +x_");
    add_proj4text (p, 1,
        "0=2000000 +y_0=2000000 +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / UPS South (N,E)\",GEOGCS[\"WGS 84\",DA");
    add_srs_wkt (p, 1,
        "TUM[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.2572235");
    add_srs_wkt (p, 2,
        "63,AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"63");
    add_srs_wkt (p, 3,
        "26\"]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"");
    add_srs_wkt (p, 4,
        "]],UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\"");
    add_srs_wkt (p, 5,
        ",\"9122\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"P");
    add_srs_wkt (p, 6,
        "olar_Stereographic\"],PARAMETER[\"latitude_of_origin\",-");
    add_srs_wkt (p, 7,
        "90],PARAMETER[\"central_meridian\",0],PARAMETER[\"scale_");
    add_srs_wkt (p, 8,
        "factor\",0.994],PARAMETER[\"false_easting\",2000000],PAR");
    add_srs_wkt (p, 9,
        "AMETER[\"false_northing\",2000000],UNIT[\"metre\",1,AUTH");
    add_srs_wkt (p, 10,
        "ORITY[\"EPSG\",\"9001\"]],AXIS[\"Northing\",NORTH],AXIS[");
    add_srs_wkt (p, 11,
        "\"Easting\",EAST],AUTHORITY[\"EPSG\",\"32761\"]]");
    p = add_epsg_def (filter, first, last, 32766, "epsg", 32766,
        "WGS 84 / TM 36 SE");
    add_proj4text (p, 0,
        "+proj=tmerc +lat_0=0 +lon_0=36 +k=0.9996 +x_0=500000 +y_");
    add_proj4text (p, 1,
        "0=10000000 +datum=WGS84 +units=m +no_defs");
    add_srs_wkt (p, 0,
        "PROJCS[\"WGS 84 / TM 36 SE\",GEOGCS[\"WGS 84\",DATUM[\"W");
    add_srs_wkt (p, 1,
        "GS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,AUTH");
    add_srs_wkt (p, 2,
        "ORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"]],");
    add_srs_wkt (p, 3,
        "PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],UNI");
    add_srs_wkt (p, 4,
        "T[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"912");
    add_srs_wkt (p, 5,
        "2\"]],AUTHORITY[\"EPSG\",\"4326\"]],PROJECTION[\"Transve");
    add_srs_wkt (p, 6,
        "rse_Mercator\"],PARAMETER[\"latitude_of_origin\",0],PARA");
    add_srs_wkt (p, 7,
        "METER[\"central_meridian\",36],PARAMETER[\"scale_factor\"");
    add_srs_wkt (p, 8,
        ",0.9996],PARAMETER[\"false_easting\",500000],PARAMETER[\"");
    add_srs_wkt (p, 9,
        "false_northing\",10000000],UNIT[\"metre\",1,AUTHORITY[\"");
    add_srs_wkt (p, 10,
        "EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"Northing");
    add_srs_wkt (p, 11,
        "\",NORTH],AUTHORITY[\"EPSG\",\"32766\"]]");
}

