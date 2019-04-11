
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
    content = content.replace(codecs.BOM_UTF8 , "")
    
    # automatic fix the input bug 
    PATTERNS =  [re.compile(r",(\s*\})")  , re.compile(r",(\s*\])")  ]
    for PATTERN in PATTERNS:
        if re.search( PATTERN , content ) is not None:
            content = re.sub( PATTERN , r"\1"  ,content )

    try:
        dic = json.loads(content)
    except:
        print ' !!! conf.ini error, not a valid JSON data'
        sys.exit(1)

    return dic


if __name__ == '__main__':
    confs = load_config() 
    # print pd.read_excel.__doc__
    for conf in confs :
        xls_name = conf["xls_name"] 
        sheet_names = conf["sheet_name"] 
        main_key = conf["main_key"]
        define = conf["define"] 

        skiprows =  "skiprows" in conf and conf["skiprows"] or 0

        if not isinstance( sheet_names , list ) :
            sheet_names = [sheet_names]

        _path,_fname = os.path.split( xls_name  )

        for sheet_name in sheet_names :
            print 'parsing', _fname , sheet_name
            df = pd.read_excel( xls_name , usecols= [main_key] + define.keys() , sheet_name = sheet_name, skiprows=skiprows )
            # df = df.set_index( main_key )
            df[main_key] = df[main_key].fillna(method='ffill')
            # print df 

            # convert column data to same type
            # print f_unnan.dtypes  , f_unnan
            expected_types = {}
            for k in [main_key] + define.keys()  :
                f =  df[k].dropna()
                
                if f.dtypes == np.object :
                    for v in f :
                        # print v
                        # if isinstance( v, str ):
                        #     expected_types[ k ] = str 
                        if isinstance( v, unicode ):
                            expected_types[ k ] = unicode 
                            break

                if f.dtypes == np.float64 :
                    if tuple( (f.astype(int).astype(np.float64) ) ) == tuple( f ):
                        expected_types[ k ] = int
                    # df[k] = pd.to_numeric(  df[k], downcast="integer" )
                    # print df[k]
                    pass

            # convert main key to int , if necessary
            if expected_types[main_key] == int :
                df[main_key] = df[main_key].astype( int )

            data = {} 
            for group, frame in df.groupby(main_key):
                data[ group ] = {}
                d = data[group]
                # print group ,frame
                for k, datetype in define.iteritems():
                    f_unnan =  frame[k].dropna()
                    is_array = datetype == -1

                    vals = list( f_unnan ) 
                    if k in expected_types:
                        vals = map( expected_types[k] , vals  )

                    if is_array :
                        d[k] = vals
                    else:
                        d[k] = vals[0]


            # print data 
            jsonObj = json.dumps(data , ensure_ascii=False , separators=(',',':') , indent=4)
            with codecs.open( sheet_name + '.txt'  , "w", "utf-8") as fp:
                fp.write(jsonObj )
                fp.close()
    print 'done'
