//
//  main.c
//  pluginTest
//
//  Created by qibinyi on 11/29/16.
//
//

#include <stdio.h>
#include <setjmp.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "Rogue.h"
#include "IncludeGlobals.h"

#define MAXTHREAD 4

/*
static jmp_buf thread[MAXTHREAD];
static int count = 0;

static void comain(void *arg) {
    int *p = arg, i = *p;
    for (;;) {
        printf("coroutine %d at %p arg %p\n", i, (void*)&i, arg);
        int n = arc4random() % count;
        printf("jumping to %d\n", n);
        arg = coto(thread[i], thread[n], (char*)arg + 1);
    }
}
//*/

typedef struct {
    double r;       // percent
    double g;       // percent
    double b;       // percent
} rgb;

typedef struct {
    double h;       // angle in degrees
    double s;       // percent
    double v;       // percent
} hsv;

static hsv   rgb2hsv(rgb in);
static rgb   hsv2rgb(hsv in);

hsv rgb2hsv(rgb in)
{
    hsv         out;
    double      min, max, delta;
    
    min = in.r < in.g ? in.r : in.g;
    min = min  < in.b ? min  : in.b;
    
    max = in.r > in.g ? in.r : in.g;
    max = max  > in.b ? max  : in.b;
    
    out.v = max;                                // v
    delta = max - min;
    if (delta < 0.00001)
    {
        out.s = 0;
        out.h = 0; // undefined, maybe nan?
        return out;
    }
    if( max > 0.0 ) { // NOTE: if Max is == 0, this divide would cause a crash
        out.s = (delta / max);                  // s
    } else {
        // if max is 0, then r = g = b = 0
        // s = 0, v is undefined
        out.s = 0.0;
        out.h = 0;                            // its now undefined
        return out;
    }
    if( in.r >= max )                           // > is bogus, just keeps compilor happy
        out.h = ( in.g - in.b ) / delta;        // between yellow & magenta
    else
        if( in.g >= max )
            out.h = 2.0 + ( in.b - in.r ) / delta;  // between cyan & yellow
        else
            out.h = 4.0 + ( in.r - in.g ) / delta;  // between magenta & cyan
    
    out.h *= 60.0;                              // degrees
    
    if( out.h < 0.0 )
        out.h += 360.0;
    
    return out;
}


rgb hsv2rgb(hsv in)
{
    double      hh, p, q, t, ff;
    long        i;
    rgb         out;
    
    if(in.s <= 0.0) {       // < is bogus, just shuts up warnings
        out.r = in.v;
        out.g = in.v;
        out.b = in.v;
        return out;
    }
    hh = in.h;
    if(hh >= 360.0) hh = 0.0;
    hh /= 60.0;
    i = (long)hh;
    ff = hh - i;
    p = in.v * (1.0 - in.s);
    q = in.v * (1.0 - (in.s * ff));
    t = in.v * (1.0 - (in.s * (1.0 - ff)));
    
    switch(i) {
        case 0:
            out.r = in.v;
            out.g = t;
            out.b = p;
            break;
        case 1:
            out.r = q;
            out.g = in.v;
            out.b = p;
            break;
        case 2:
            out.r = p;
            out.g = in.v;
            out.b = t;
            break;
            
        case 3:
            out.r = p;
            out.g = q;
            out.b = in.v;
            break;
        case 4:
            out.r = t;
            out.g = p;
            out.b = in.v;
            break;
        case 5:
        default:
            out.r = in.v;
            out.g = p;
            out.b = q;
            break;
    }
    return out;     
}

extern void rogueMain( ) ;
extern void printDungeonFeatureCatalog ()  ;

extern void carveDungeon(short **grid) ;

#if GEN_LEVEL_ONLY
const short nbDirs[8][2] = {{0,-1}, {0,1}, {-1,0}, {1,0}, {-1,-1}, {-1,1}, {1,-1}, {1,1}};
#endif

int main(int argc, const char * argv[]) {
    
    //printf( "%d\n" , '\177' ) ;
    /*
    while (++count < MAXTHREAD) {
        printf("spawning %d\n", count);
        cogo(thread[0], comain, &count);
    }
     //*/
    
    //
    
    /*
    rogueHighScoresEntry list[HIGH_SCORES_COUNT] = {{0}};
    getHighScoresList(list);
    
    rogueHighScoresEntry theEntry;
    theEntry.score= 100 ;
    strcpy(  theEntry.description , "test" ) ;
    strcpy(  theEntry.date , "1/1/16" ) ;
    
    saveHighScore(theEntry);
    //*/
    //rogueMain();
    
    
    //printDungeonFeatureCatalog();
    
    short ** grid = allocGrid();
    //carveDungeon(grid);
    
    return 0;
}

#if 0
void printDungeonFeatureCatalog () {
    //dungeonFeature dungeonFeatureCatalog[NUMBER_DUNGEON_FEATURES]
    /*
     enum tileType tile;
     enum dungeonLayers layer;
     
     // spawning pattern:
     short startProbability;
     short probabilityDecrement;
     unsigned long flags;
     char description[DCOLS];
     enum lightType lightFlare;
     const color *flashColor;
     short effectRadius;
     enum tileType propagationTerrain;
     enum dungeonFeatureTypes subsequentDF;
     boolean messageDisplayed;
     //*/
    printf( "int i= 0 ;\n" ) ;
    printf( "dungeonFeature df ;\n" ) ;
    for( int i=0 ; i< NUMBER_DUNGEON_FEATURES ; i++ ) {
        dungeonFeature df =dungeonFeatureCatalog[i] ;

        printf( "// %d\n" , i  );
        printf( "df = new dungeonFeature ();\n" );
        
        
        if (df.tile != NOTHING) {
            printf( "df.tile = (tileType)%d; " , (int)df.tile );
        }
        printf( "\ndungeonFeatureCatalog[i++] = df;\n" );
        
        
        printf( "\n" );
    }
}

void printMonsterColors() {
    creatureType ct ;
    int r,g,b;
    for (int i=0 ; i< NUMBER_MONSTER_KINDS ; i++ ) {
        ct = monsterCatalog[i] ;
        
        r = ct.foreColor->red*255.0/100 ;
        g = ct.foreColor->green*255.0/100 ;
        b = ct.foreColor->blue*255.0/100 ;
        
        rgb _rgb ;
        _rgb.r = r ;
        _rgb.g = g ;
        _rgb.b = b ;
        
        hsv _hsv = rgb2hsv( _rgb ) ;
        
        
        printf( "%02d %16s: %d,%d,%d , %.3f,%.3f,%.3f \n" , i, ct.monsterName  , r,g,b , _hsv.h/360. ,_hsv.s , _hsv.v/255.  ) ;
    }
    
    printf( "%s"  ,  "{" ) ;
    for (int i=0 ; i< NUMBER_MONSTER_KINDS ; i++ ) {
        ct = monsterCatalog[i] ;
        
        r = ct.foreColor->red*255.0/100 ;
        g = ct.foreColor->green*255.0/100 ;
        b = ct.foreColor->blue*255.0/100 ;
        
        rgb _rgb ;
        _rgb.r = r ;
        _rgb.g = g ;
        _rgb.b = b ;
        
        hsv _hsv = rgb2hsv( _rgb ) ;
        
        if ( i % 10 ==0 )
            printf("\n") ;
        
        
        printf( "%.3ff,"  ,  _hsv.v/255.  ) ;
    }
    printf( "%s"  ,  "\n} ;\n" ) ;
}
#endif
