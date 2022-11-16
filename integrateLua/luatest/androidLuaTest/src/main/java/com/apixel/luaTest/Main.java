package com.apixel.luaTest;

import android.app.Activity;
import android.os.Bundle;

import org.cocos2dx.lib.Cocos2dxHelper ;
import org.cocos2dx.lib.Cocos2dxLuaJavaBridge ;

public class Main extends Activity
{
    static {
        System.loadLibrary("tolua");
        System.loadLibrary("hello-world");
    }

    public native String stringFromJNI();
    public native void nativeInit() ;

    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        String testString = stringFromJNI();
        System.out.println( testString );

        Cocos2dxHelper.init(this );
        nativeInit() ;
    }

    public static void javaLuaCallbackTest( final String lua_callback_func_name  , String param  ) {
        int lua_func_id = Cocos2dxLuaJavaBridge.getLuaFunctionIDbyName(lua_callback_func_name) ;
        if ( lua_func_id == -1 ) 
            System.out.println( "can not find lua method :" + lua_callback_func_name );
        else
            Cocos2dxLuaJavaBridge.callLuaFunctionWithString (lua_func_id ,  Cocos2dxLuaJavaBridge.b64Encode ("我收到了 " + param) ) ;
    }
}
