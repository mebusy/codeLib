#!python3

import pandas as pd 
import numpy as np
import os
import json
import codecs
import re 
import sys

def load_config():
    
    with open( "conf.ini" ) as fp:
        content = fp.read()
        fp.close()
    
    #remove BOM
    content = content.replace(str(codecs.BOM_UTF8) , "")
    
    # automatic fix the input bug 
    PATTERNS =  [re.compile(r",(\s*\})")  , re.compile(r",(\s*\])")  ]
    for PATTERN in PATTERNS:
        if re.search( PATTERN , content ) is not None:
            content = re.sub( PATTERN , r"\1"  ,content )

    try:
        dic = json.loads(content)
    except:
        print ( ' !!! conf.ini error, not a valid JSON data' )
        print ( content )
        sys.exit(1)

    return dic


if __name__ == '__main__':
    confs = load_config() 
    # print pd.read_excel.__doc__
    for conf in confs :
        xls_name = conf["xls_name"]   # xls file name
        sheet_names = conf["sheet_name"]  # list , or string
        main_key = conf["main_key"]    # main json key for exporting
        define = conf["define"]    # data to export to json

        skiprows =  "skiprows" in conf and conf["skiprows"] or 0  # rows to skp
        out_dir =  "out_dir" in conf and conf["out_dir"] or "."   # output dir

        if not isinstance( sheet_names , list ) :
            sheet_names = [sheet_names]

        _path,_fname = os.path.split( xls_name  )

        for sheet_name in sheet_names :
            print ( 'parsing', _fname , sheet_name )
            df = pd.read_excel( xls_name , usecols= [main_key] + list( define.keys() ) , sheet_name = sheet_name, skiprows=skiprows )
            # df = df.set_index( main_key )
            df[main_key] = df[main_key].fillna(method='ffill')
            # print df 

            # convert column data to same type
            # print f_unnan.dtypes  , f_unnan
            expected_types = {}
            for k in [main_key] + list(define.keys())  :
                f =  df[k].dropna()
                
                if f.dtypes == object: # np.object :
                    for v in f :
                        # print ( v, type(v) )
                        if isinstance( v, str ):
                            expected_types[ k ] = str 
                        # if isinstance( v, unicode ):
                        #     expected_types[ k ] = unicode
                        #     break


                if f.dtypes == np.float64 :
                    if tuple( (f.astype(int).astype(np.float64) ) ) == tuple( f ):
                        expected_types[ k ] = int
                    # df[k] = pd.to_numeric(  df[k], downcast="integer" )
                    # print df[k]
                    pass

            # convert main key to int , if necessary
            if main_key not in expected_types or expected_types[main_key] == int :
                df[main_key] = df[main_key].astype( int )

            data = {} 
            for group, frame in df.groupby(main_key):
                data[ group ] = {}
                d = data[group]
                # print group ,frame
                for k, datetype in define.items():
                    f_unnan =  frame[k].dropna()
                    is_array = datetype == -1

                    vals = list( f_unnan ) 
                    if k in expected_types:
                        # in 2.0. map return a list, but in 3.0, map return a map() object
                        # explictly convert to a list , for json serialize
                        vals = list( map( expected_types[k] , vals  ) )

                    if is_array :
                        d[k] = vals
                    else:
                        # print k , vals
                        d[k] =  vals[0] if vals else expected_types[k]()


            # print ( type(data) ) 
            jsonObj = json.dumps(data , ensure_ascii=False , separators=(',',':') , indent=4, sort_keys = True )
            with codecs.open( os.path.join( out_dir, sheet_name + '.txt' )  , "w", "utf-8") as fp:
                fp.write(jsonObj )
                fp.close()
    print ( 'done' )

