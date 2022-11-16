/****************************************************************************
Copyright (c) 2010-2012 cocos2d-x.org
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

import java.io.UnsupportedEncodingException;
import java.util.Locale;
import java.util.LinkedHashSet;
import java.util.Set;
import java.lang.Runnable;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.ActivityInfo;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.res.AssetManager;
import android.os.Build;
import android.preference.PreferenceManager.OnActivityResultListener;
import android.util.DisplayMetrics;
import android.view.Display;
import android.view.WindowManager;

import java.io.IOException;
import java.io.InputStream;

import android.content.Intent ;
import android.net.Uri ;

import android.provider.Settings.Secure;


public class Cocos2dxHelper {
    // ===========================================================
    // Constants
    // ===========================================================
    private static final String PREFS_NAME = "Cocos2dxPrefsFile";
    private static final int RUNNABLES_PER_FRAME = 5;

    // ===========================================================
    // Fields
    // ===========================================================

    private static AssetManager sAssetManager;
    private static boolean sActivityVisible;
    private static String sPackageName;
    private static String sFileDirectory;
    private static Activity sActivity = null;
    private static Set<OnActivityResultListener> onActivityResultListeners = new LinkedHashSet<OnActivityResultListener>();


    // ===========================================================
    // Constructors
    // ===========================================================
    /*
    public static void runOnGLThread(final Runnable r) {
        ((Cocos2dxActivity)sActivity).runOnGLThread(r);
    }
    //*/

    private static boolean sInited = false;
    public static void init(final Activity activity) {
        if (!sInited) {
            final ApplicationInfo applicationInfo = activity.getApplicationInfo();
            
                    
            Cocos2dxHelper.sPackageName = applicationInfo.packageName;
            Cocos2dxHelper.sFileDirectory = activity.getFilesDir().getAbsolutePath();
            Cocos2dxHelper.nativeSetApkPath(applicationInfo.sourceDir);
    
            Cocos2dxHelper.sAssetManager = activity.getAssets();
            Cocos2dxHelper.nativeSetContext((Context)activity, Cocos2dxHelper.sAssetManager);
    
            sActivity = activity;

            sInited = true;

        }
    }
    
    public static Activity getActivity() {
        return sActivity;
    }
    
    public static void addOnActivityResultListener(OnActivityResultListener listener) {
        onActivityResultListeners.add(listener);
    }
    
    public static Set<OnActivityResultListener> getOnActivityResultListeners() {
        return onActivityResultListeners;
    }
    
    public static boolean isActivityVisible(){
        return sActivityVisible;
    }

    // ===========================================================
    // Getter & Setter
    // ===========================================================

    // ===========================================================
    // Methods for/from SuperClass/Interfaces
    // ===========================================================

    // ===========================================================
    // Methods
    // ===========================================================

    private static native void nativeSetApkPath(final String pApkPath);

    private static native void nativeSetEditTextDialogResult(final byte[] pBytes);

    private static native void nativeSetContext(final Context pContext, final AssetManager pAssetManager);

    public static String getCocos2dxPackageName() {
        return Cocos2dxHelper.sPackageName;
    }

    public static String getCocos2dxWritablePath() {
        return Cocos2dxHelper.sFileDirectory;
    }

    public static String getCurrentLanguage() {
        return Locale.getDefault().getLanguage();
    }
    
    public static String getDeviceModel(){
        return Build.MODEL;
    }

    public static AssetManager getAssetManager() {
        return Cocos2dxHelper.sAssetManager;
    }


    public static void end() {
        //Cocos2dxHelper.sCocos2dMusic.end();
        //Cocos2dxHelper.sCocos2dSound.end();
    }

    public static void onResume() {
        sActivityVisible = true;
        // TODO
    }

    public static void onPause() {
        sActivityVisible = false;
        // TODO
    }

    public static void onEnterBackground() {
        // TODO
    }
    
    public static void onEnterForeground() {
        // TODO
    }
    
    public static void terminateProcess() {
        android.os.Process.killProcess(android.os.Process.myPid());
    }

    /*
    private static void showDialog(final String pTitle, final String pMessage) {
        Cocos2dxHelper.sCocos2dxHelperListener.showDialog(pTitle, pMessage);
    }

    private static void showEditTextDialog(final String pTitle, final String pMessage, final int pInputMode, final int pInputFlag, final int pReturnType, final int pMaxLength) {
        Cocos2dxHelper.sCocos2dxHelperListener.showEditTextDialog(pTitle, pMessage, pInputMode, pInputFlag, pReturnType, pMaxLength);
    }

    public static void setEditTextDialogResult(final String pResult) {
        try {
            final byte[] bytesUTF8 = pResult.getBytes("UTF8");

            Cocos2dxHelper.sCocos2dxHelperListener.runOnGLThread(new Runnable() {
                @Override
                public void run() {
                    Cocos2dxHelper.nativeSetEditTextDialogResult(bytesUTF8);
                }
            });
        } catch (UnsupportedEncodingException pUnsupportedEncodingException) {
           
        }
    }
    //*/

    public static int getDPI()
    {
        if (sActivity != null)
        {
            DisplayMetrics metrics = new DisplayMetrics();
            WindowManager wm = sActivity.getWindowManager();
            if (wm != null)
            {
                Display d = wm.getDefaultDisplay();
                if (d != null)
                {
                    d.getMetrics(metrics);
                    return (int)(metrics.density*160.0f);
                }
            }
        }
        return -1;
    }
    
    // ===========================================================
    // Functions for CCUserDefault
    // ===========================================================
    
    public static boolean getBoolForKey(String key, boolean defaultValue) {
        SharedPreferences settings = sActivity.getSharedPreferences(Cocos2dxHelper.PREFS_NAME, 0);
        return settings.getBoolean(key, defaultValue);
    }
    
    public static int getIntegerForKey(String key, int defaultValue) {
        SharedPreferences settings = sActivity.getSharedPreferences(Cocos2dxHelper.PREFS_NAME, 0);
        return settings.getInt(key, defaultValue);
    }
    
    public static float getFloatForKey(String key, float defaultValue) {
        SharedPreferences settings = sActivity.getSharedPreferences(Cocos2dxHelper.PREFS_NAME, 0);
        return settings.getFloat(key, defaultValue);
    }
    
    public static double getDoubleForKey(String key, double defaultValue) {
        // SharedPreferences doesn't support saving double value
        SharedPreferences settings = sActivity.getSharedPreferences(Cocos2dxHelper.PREFS_NAME, 0);
        return settings.getFloat(key, (float)defaultValue);
    }
    
    public static String getStringForKey(String key, String defaultValue) {
        SharedPreferences settings = sActivity.getSharedPreferences(Cocos2dxHelper.PREFS_NAME, 0);
        return settings.getString(key, defaultValue);
    }
    
    public static void setBoolForKey(String key, boolean value) {
        SharedPreferences settings = sActivity.getSharedPreferences(Cocos2dxHelper.PREFS_NAME, 0);
        SharedPreferences.Editor editor = settings.edit();
        editor.putBoolean(key, value);
        editor.commit();
    }
    
    public static void setIntegerForKey(String key, int value) {
        SharedPreferences settings = sActivity.getSharedPreferences(Cocos2dxHelper.PREFS_NAME, 0);
        SharedPreferences.Editor editor = settings.edit();
        editor.putInt(key, value);
        editor.commit();
    }
    
    public static void setFloatForKey(String key, float value) {
        SharedPreferences settings = sActivity.getSharedPreferences(Cocos2dxHelper.PREFS_NAME, 0);
        SharedPreferences.Editor editor = settings.edit();
        editor.putFloat(key, value);
        editor.commit();
    }
    
    public static void setDoubleForKey(String key, double value) {
        // SharedPreferences doesn't support recording double value
        SharedPreferences settings = sActivity.getSharedPreferences(Cocos2dxHelper.PREFS_NAME, 0);
        SharedPreferences.Editor editor = settings.edit();
        editor.putFloat(key, (float)value);
        editor.commit();
    }
    
    public static void setStringForKey(String key, String value) {
        SharedPreferences settings = sActivity.getSharedPreferences(Cocos2dxHelper.PREFS_NAME, 0);
        SharedPreferences.Editor editor = settings.edit();
        editor.putString(key, value);
        editor.commit();
    }
    
    // ===========================================================
    // Inner and Anonymous Classes
    // ===========================================================
    /*
    public static interface Cocos2dxHelperListener {
        public void showDialog(final String pTitle, final String pMessage);
        public void showEditTextDialog(final String pTitle, final String pMessage, final int pInputMode, final int pInputFlag, final int pReturnType, final int pMaxLength);

        public void runOnGLThread(final Runnable pRunnable);
    }
    //*/

    // qibinyi
    // not used any more , use NDK assetmanager instead.
    public static boolean isFileExists( String file ) {
        
        boolean bExists = true  ;
        
        AssetManager asset = Cocos2dxHelper.sAssetManager ;
        try {
            InputStream inputStream = asset.open( file );
            inputStream.close() ;
            inputStream = null ;
        } catch (IOException e) {
            //e.printStackTrace();
            bExists = false ;
        }

        //System.out.println( "isFileExists? " + file  + " -> " +  ( bExists ? "1" : "0" )  )  ;

        return bExists ;
    }
    
    public static byte[] loadAssetsFile( String file ) {

        AssetManager asset = Cocos2dxHelper.sAssetManager ;
        try {
            InputStream _is = asset.open( file );
            byte[] buf = new byte[ _is.available() ];
            for ( int len=0, sum=0 ; (len= _is.read(buf , sum , buf.length - sum ))>0 ; sum+= len ) ;
            _is.close() ;
            _is = null ;
            return buf ;
        } catch (IOException e) {
            e.printStackTrace();
        }       
        return null ;
    }

    
    public static boolean isDirectoryExists( String dir ) {
        
        boolean bExists = true  ;
        
        AssetManager asset = Cocos2dxHelper.sAssetManager;
        try {
            asset.list(dir) ;
        } catch (IOException e) {
            //e.printStackTrace();
            bExists = false ;
        }

        return bExists ;
    }


    public  static void openWebPage(  final String url ) {
        Intent viewIntent = new  Intent(Intent.ACTION_VIEW,Uri.parse( url ));  // "android.intent.action.VIEW"
        sActivity.startActivity(viewIntent);
    }

    public static String deviceInfo() {

        String osVer = android.os.Build.VERSION.RELEASE ;
        String model = android.os.Build.MODEL      ;      // Model 
        String androidId = Secure.getString( sActivity.getContentResolver(), Secure.ANDROID_ID);

        //System.out.println( "deviceInfo osVer: " + osVer  );
        //System.out.println( "deviceInfo model: " + model  );
        //System.out.println( "deviceInfo androidId: " + androidId  );

        String jsonString = "{" + 
                        "\"osVer\":\"" + osVer + "\", "   + 
                        "\"model\":\"" + model + "\", "   + 
                        "\"androidId\":\"" + androidId + "\" "   + 
                         "}" ;
        return jsonString ;

    } 

}
