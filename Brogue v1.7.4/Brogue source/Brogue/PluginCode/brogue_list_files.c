//
//  brogue_list_files.c
//  Brogue
//
//  Created by qibinyi on 12/5/16.
//
//

#include "Rogue.h"
#include "IncludeGlobals.h"

// ============= implemented ========================
#define ADD_FAKE_PADDING_FILES 0

// Returns a malloc'ed fileEntry array, and puts the file count into *fileCount.
// Also returns a pointer to the memory that holds the file names, so that it can also
// be freed afterward.
#include <sys/types.h>
#include <dirent.h>
#include <sys/stat.h>
#include <time.h>

int isDirectory(const char *path) {
    struct stat statbuf;
    if (stat(path, &statbuf) != 0)
        return 0;
    return S_ISDIR(statbuf.st_mode);
}

char dest_combined_path1[1024] ;
static char dest_combined_path2[1024] ;
const char* combinePath( char* destination , const char* path1, const char* path2)
{
    if(path1 == NULL && path2 == NULL) {
        strcpy(destination, "");;
    }
    else if(path2 == NULL || strlen(path2) == 0) {
        strcpy(destination, path1);
    }
    else if(path1 == NULL || strlen(path1) == 0) {
        strcpy(destination, path2);
    }
    else {
        char directory_separator[] = "/";
#ifdef WIN32
        directory_separator[0] = '\\';
#endif
        const char *last_char = path1;
        while(*last_char != '\0')
            last_char++;
        int append_directory_separator = 0;
        if(strcmp(last_char, directory_separator) != 0) {
            append_directory_separator = 1;
        }
        strcpy(destination, path1);
        if(append_directory_separator)
            strcat(destination, directory_separator);
        strcat(destination, path2);
    }
    
    return destination;
}

const char * getFileModifyDate(char *filePath , long * time )
{
    struct stat attrib;
    stat(filePath, &attrib);
    static char date[20];
    memset( date , 0 , sizeof(date) ) ;
    
    strftime(date, 18, "%d/%m/%y-%H:%M:%S", localtime(&(attrib.st_mtime))); //
    
    if(time!=NULL)
        *time = attrib.st_mtime ;
    
    //printf( " %s - %lu \n"  , date , attrib.st_mtime );

    return date ;
}


void fileEntrySwap( fileEntry * s , int i, int j  ) {
    fileEntry tmp;		/* placeholder */
    
    tmp = s[i];
    s[i] = s[j];
    s[j] = tmp;
}

void sortFileByModifyTime ( fileEntry * lists ,  int lo , int hi ) {
    
    // [ lo , hi ]
    if ( hi - lo < 1 )
        return ;
    
    int iMid = (hi + lo) / 2 ;
    fileEntrySwap( lists , lo , iMid );
    
    long p = lists[lo].modifyTime ;
    
    // partition
    int i = lo +1 ;   // i will seperate the elements those <p and >p
    for (int j = i; j< hi+1  ; j++ ) {// go through unpartitioned array
        if ( lists[j].modifyTime  >  p  ) {  //  find a element should move 2 left
            fileEntrySwap( lists , i , j );
            i += 1 ;
        }
    }
        
    fileEntrySwap( lists , lo , i-1 );
    
    //# recursive
    sortFileByModifyTime( lists , i , hi  ) ; // 大于 等于P的element
    sortFileByModifyTime( lists , lo , i-2  ) ; // 小于p的element, i-1是p,不再进行排序
        
    
}

fileEntry *listFiles(short *fileCount, char **dynamicMemoryBuffer) {
    fileEntry *fileList;
    short i, count, thisFileNameLength;
    unsigned long bufferPosition, bufferSize;
    unsigned long *offsets;
    
    const char *thisFileName;
    
    char tempString[500];
    
    bufferPosition = bufferSize = 0;
    *dynamicMemoryBuffer = NULL;
    
    count = 0 ;
    
    DIR *dp;
    struct dirent *ep;
    
    dp = opendir (path_prefix);
    if (dp != NULL)
    {
        while (ep = readdir (dp)) {
            //puts (ep->d_name);
            //if(ep->d_name[0] == '.') continue ;
            count ++ ;
        }
        (void) closedir (dp);
    }
    else
        perror ("Couldn't open the directory");
    
    
    fileList = malloc((count + ADD_FAKE_PADDING_FILES) * sizeof(fileEntry));
    offsets = malloc((count + ADD_FAKE_PADDING_FILES) * sizeof(unsigned long));
    
    dp = opendir (path_prefix);
    if (dp != NULL)
    {
        i = count -1  ;
        while (ep = readdir (dp)) {
            //if(ep->d_name[0] == '.') continue ;
            
            //if (i < count) {
            if (i >= 0 ) {
                thisFileName = ep->d_name ;
                
                memset( dest_combined_path1 , 0 , sizeof(dest_combined_path1));
                combinePath( dest_combined_path1 , path_prefix,thisFileName ) ;
                
                strcpy(fileList[i].date,  getFileModifyDate( dest_combined_path1 , &fileList[i].modifyTime ) );
            } else {
                // Debug feature.
                sprintf(tempString, "Fake padding file %i.broguerec", i - count + 1);
                thisFileName = &(tempString[0]);
                strcpy(fileList[i].date, "12/12/12");
            }
            
            thisFileNameLength = strlen(thisFileName);
            
            if (thisFileNameLength + bufferPosition > bufferSize) {
                bufferSize += sizeof(char) * 1024;
                *dynamicMemoryBuffer = (char *) realloc(*dynamicMemoryBuffer, bufferSize);
            }
            
            offsets[i] = bufferPosition; // Have to store these as offsets instead of pointers, as realloc could invalidate pointers.
            
            strcpy(&((*dynamicMemoryBuffer)[bufferPosition]), thisFileName);
            bufferPosition += thisFileNameLength + 1;
            //printf( "offset: %d - %lu \n" , i , offsets[i] );
            
            i-- ;
        }
        (void) closedir (dp);
    }
    else
        perror ("Couldn't open the directory");
    
    
    
    // Convert the offsets to pointers.
    for (i = 0; i < count + ADD_FAKE_PADDING_FILES; i++) {
        fileList[i].path = &((*dynamicMemoryBuffer)[offsets[i]]);
    }
    
    free(offsets);
    
    *fileCount = count + ADD_FAKE_PADDING_FILES;
    
    // qibinyi, sort in modify time
    sortFileByModifyTime ( fileList ,  0 , (*fileCount)-1 ) ;
    
    return fileList;
}







FILE * _FOPEN(const char * path, const char * mode) {
#ifdef WORKING_FOLDER_SETTED
    return fopen( path , mode) ;
#else
    memset( dest_combined_path1 , 0 , sizeof(dest_combined_path1));
    combinePath( dest_combined_path1 , path_prefix, path) ;
    if(isDirectory(dest_combined_path1))
        return NULL ;
    //printf( "fopen: %s\n" , fullPath  ) ;
    return fopen( dest_combined_path1 , mode) ;
#endif
}

int _RENAME(const char *old_filename, const char *new_filename) {
#ifdef WORKING_FOLDER_SETTED
    return rename( old_filename , new_filename );
#else
    memset( dest_combined_path1 , 0 , sizeof(dest_combined_path1));
    memset( dest_combined_path2 , 0 , sizeof(dest_combined_path2));
    combinePath( dest_combined_path1 , path_prefix, old_filename) ;
    combinePath( dest_combined_path2 , path_prefix, new_filename) ;
    int ret= rename( dest_combined_path1 , dest_combined_path2 );
    /*
    if(ret == 0)
    {
        printf("File renamed successfully");
    }
    else
    {
        printf("Error: unable to rename the file");
    }
    //*/
    return ret ;
#endif
}

int _REMOVE(const char *filename) {
#ifdef WORKING_FOLDER_SETTED
    return remove(  filename  );
#else
    memset( dest_combined_path1 , 0 , sizeof(dest_combined_path1));
    return remove( combinePath( dest_combined_path1 , path_prefix, filename) );
#endif
}








