/****************************************************************************
Copyright (c) 2013-2014 Chukong Technologies Inc.

http://www.cocos2d-x.org

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
****************************************************************************/

package org.cocos2dx.lib;

import java.util.HashMap ; 
import android.util.Base64 ;
import java.nio.charset.Charset ;

public class Cocos2dxLuaJavaBridge
{
    public static native int callLuaFunctionWithString(int luaFunctionId, String value);
    public static native int callLuaGlobalFunctionWithString(String luaFunctionName, String value);
    public static native int retainLuaFunction(int luaFunctionId);
    public static native int releaseLuaFunction(int luaFunctionId);

    private static HashMap<String,Integer> lua_functions = new HashMap<String,Integer>();
    public static void registerLuaFunction( final String lua_func_name, final int lua_func_id ) {
        if ( lua_functions.containsKey( lua_func_name  ) ) {
            System.out.println( lua_func_name + " has already exists , will replace with new one" );
            // release old 1
            releaseLuaFunction( lua_functions.get( lua_func_name ) );
            // remove map entry
            lua_functions.remove( lua_func_name ) ;
        }

        lua_functions.put( lua_func_name , lua_func_id ) ;
        retainLuaFunction( lua_func_id ) ;
    }  

    public static int getLuaFunctionIDbyName( String  lua_func_name ) {
        System.out.println( lua_func_name + " exists ? " + ( lua_functions.containsKey( lua_func_name  ) ? "true" : "false" ) );
        if ( lua_functions.containsKey( lua_func_name  ) )
            return lua_functions.get( lua_func_name ) ; 
        else
            return -1 ;
    }

    public static String b64Encode( String str ) {
        // to protection        
        if (str == null )
            str = "" ;
        return  Base64.encodeToString(  str.getBytes( Charset.forName("UTF-8") ) , Base64.NO_WRAP);
    }
}
