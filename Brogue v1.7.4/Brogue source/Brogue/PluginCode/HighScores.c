//
//  HighScores.c
//  Brogue
//
//  Created by qibinyi on 12/6/16.
//
//
#include "Rogue.h"
#include "cJSON.h"
#include "IncludeGlobals.h"

extern double current_DateNow()  ;
extern const char* FormatDateBySecs( int _seconds );

int scoresArray[HIGH_SCORES_COUNT] ;
char textArray[HIGH_SCORES_COUNT][1024] ;
double datesArray[HIGH_SCORES_COUNT] ;



#define filename_scoresArray "bin1"
#define filename_textArray "bin2"
#define filename_datesArray "bin3"

void readJsonToIntArray( const char* filename , int array[HIGH_SCORES_COUNT] ) {
    FILE *f;long len;char *data;
    
    f=_FOPEN(filename,"rb");
    if(f==NULL)
        return ;
    fseek(f,0,SEEK_END);len=ftell(f);fseek(f,0,SEEK_SET);
    data=(char*)malloc(len+1);fread(data,1,len,f);fclose(f);
    
    //======================
    cJSON *json;
    
    json=cJSON_Parse(data);
    if (!json) {printf("Error before: [%s]\n",cJSON_GetErrorPtr());}
    else
    {
        int size = min( HIGH_SCORES_COUNT , cJSON_GetArraySize(json) ) ;
        for (int i=0 ; i < size ; i++) {
            array[i] =  cJSON_GetArrayItem( json, i )->valueint ;
            
        }
        cJSON_Delete(json);
    }
    
    //======================
    
    free(data);
}

void readJsonToCharArray( const char* filename ,  char array[HIGH_SCORES_COUNT][1024]  ) {
    
    FILE *f;long len;char *data;
    
    f=_FOPEN(filename,"rb");
    if(f==NULL)
        return ;
    fseek(f,0,SEEK_END);len=ftell(f);fseek(f,0,SEEK_SET);
    data=(char*)malloc(len+1);fread(data,1,len,f);fclose(f);
    
    //======================
    cJSON *json;
    
    json=cJSON_Parse(data);
    if (!json) {printf("Error before: [%s]\n",cJSON_GetErrorPtr());}
    else
    {
        int size = min( HIGH_SCORES_COUNT , cJSON_GetArraySize(json) ) ;
        for (int i=0 ; i < size ; i++) {
            strcpy(array[i], cJSON_GetArrayItem( json, i)->valuestring) ;
            
        }
        cJSON_Delete(json);
    }
    
    //======================
    
    free(data);
    
}

void readJsonToDoubleArray( const char* filename , double array[HIGH_SCORES_COUNT] ) {
    FILE *f;long len;char *data;
    
    f=_FOPEN(filename,"rb");
    if(f==NULL)
        return ;
    fseek(f,0,SEEK_END);len=ftell(f);fseek(f,0,SEEK_SET);
    data=(char*)malloc(len+1);fread(data,1,len,f);fclose(f);
    
    //======================
    cJSON *json;
    
    json=cJSON_Parse(data);
    if (!json) {printf("Error before: [%s]\n",cJSON_GetErrorPtr());}
    else
    {
        int size = min( HIGH_SCORES_COUNT , cJSON_GetArraySize(json) ) ;
        for (int i=0 ; i < size ; i++) {
            array[i] =  cJSON_GetArrayItem( json, i )->valuedouble ;
            
        }
        cJSON_Delete(json);
    }
    
    //======================
    
    free(data);
}

void initHighScores() {
    memset( scoresArray, 0, sizeof(scoresArray) );
    memset( textArray, 0, sizeof(textArray) );
    memset( datesArray, 0, sizeof(datesArray) );
    
    readJsonToIntArray( filename_scoresArray  , scoresArray );

    readJsonToCharArray( filename_textArray , textArray );
    
    readJsonToDoubleArray( filename_datesArray , datesArray );
}


// returns the index number of the most recent score
short getHighScoresList(rogueHighScoresEntry returnList[HIGH_SCORES_COUNT]) {
    
    short i, j, maxIndex=0, mostRecentIndex = -1;
    long maxScore;
    boolean scoreTaken[HIGH_SCORES_COUNT];
    
    // no scores have been taken
    for (i=0; i<HIGH_SCORES_COUNT; i++) {
        scoreTaken[i] = false;
    }
    
    initHighScores();
    
    
    
    
    double mostRecentDate = 0 ;
    // dateFormatter = [[NSDateFormatter alloc] initWithDateFormat:@"%1m/%1d/%y" allowNaturalLanguage:YES];
    
    // store each value in order into returnList
    for (i=0; i<HIGH_SCORES_COUNT; i++) {
        // find the highest value that hasn't already been taken
        maxScore = 0; // excludes scores of zero
        for (j=0; j<HIGH_SCORES_COUNT; j++) {
            if (scoreTaken[j] == false && scoresArray[j] >= maxScore) {
                maxScore = scoresArray[j] ;
                maxIndex = j;
            }
        }
        // maxIndex identifies the highest non-taken score
        scoreTaken[maxIndex] = true;
        returnList[i].score = scoresArray[maxIndex] ;
        strcpy(returnList[i].description, textArray[maxIndex] );
        strcpy(returnList[i].date, FormatDateBySecs(datesArray[maxIndex]) );
        
        // if this is the most recent score we've seen so far
        if ( mostRecentDate < datesArray[maxIndex]  ) {
            mostRecentDate = datesArray[maxIndex];
            mostRecentIndex = i;
        }
    }
    return mostRecentIndex;
}


void saveJson2File( const char * text ,  const char* filename ) {
    
    FILE *f = _FOPEN( filename , "w");
    if (f == NULL)
    {
        printf( "saveJson2File failed." );
        return ;
    }
    
    fprintf(f, "%s", text);
    fclose(f);
}

// saves the high scores entry over the lowest-score entry if it qualifies.
// returns whether the score qualified for the list.
// This function ignores the date passed to it in theEntry and substitutes the current
// date instead.
boolean saveHighScore(rogueHighScoresEntry theEntry) {
    
    short j, minIndex = -1;
    long minScore = theEntry.score;
    
    // generate high scores if prefs don't exist or contain no high scores data
    initHighScores();
    
    
    // find the lowest value
    for (j=0; j<HIGH_SCORES_COUNT; j++) {
        if ( scoresArray[j]  < minScore) {
            minScore = scoresArray[j] ;
            minIndex = j;
        }
    }
    
    if (minIndex == -1) { // didn't qualify
        return false;
    }
    
    // minIndex identifies the score entry to be replaced
    signed long newScore = theEntry.score;
    const char* newText = theEntry.description;
    
    scoresArray[minIndex] = (int)newScore;
    strcpy(textArray[minIndex] , newText);
    datesArray[minIndex] =  current_DateNow() ;
    
    cJSON * root=cJSON_CreateIntArray(scoresArray, HIGH_SCORES_COUNT );
    char* _out = cJSON_Print(root);
    saveJson2File( _out , filename_scoresArray  ) ;
    cJSON_Delete(root);
    free(_out);
    
    root=cJSON_CreateArray();
    for(int i=0;i<HIGH_SCORES_COUNT ; i++) {
        cJSON_AddItemToArray(root, cJSON_CreateString(textArray[i]));
    }
    _out = cJSON_Print(root);
    saveJson2File( _out , filename_textArray  ) ;
    cJSON_Delete(root);
    free(_out);
    

    root=cJSON_CreateDoubleArray( datesArray, HIGH_SCORES_COUNT );
    _out = cJSON_Print(root);
    saveJson2File( _out , filename_datesArray  ) ;
    cJSON_Delete(root);
    free(_out);
    
    return true;
}

// caution: same fromFilePath / toFilePath will cause unexcepted behavior

void cp(char *fromFilePath, char *toFilePath ) {
    long len;
    unsigned long m, n;
    unsigned char fileBuffer[INPUT_RECORD_BUFFER];
    FILE *fromFile, *toFile;
    
    _REMOVE(toFilePath);
    
    fromFile	= _FOPEN(fromFilePath, "rb");
    if( fromFile == NULL ) return ;
    fseek(fromFile,0,SEEK_END);len=ftell(fromFile);fseek(fromFile,0,SEEK_SET);
    
    toFile		= _FOPEN(toFilePath, "wb");
    
    for (n = 0; n < len; n += m) {
        m = min(INPUT_RECORD_BUFFER, len - n);
        fread((void *) fileBuffer, 1, m, fromFile);
        fwrite((void *) fileBuffer, 1, m, toFile);
    }
    
    fclose(fromFile);
    fclose(toFile);
}

