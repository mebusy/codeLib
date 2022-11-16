

COMPILE_OUT_PATH=$1
if [ -z "$COMPILE_OUT_PATH" ]
then
        echo "need COMPILE_OUT_PATH "
	exit 1
	
else
        echo "*compile out path: $COMPILE_OUT_PATH"
fi


list_alldir(){ 
        for file in $1/* 
        do 
                if [ -d "$file" ] 
                then
                        list_alldir "$file" #在这里递归调用         
                else
                		lastfile="${file##*/}"
                		extension="${lastfile##*.}"

                		if [ "$extension" == "o"  ]
                		then
                			echo "$lastfile"
                			otool -arch armv7 -l "$file" | grep bitcode
                		fi

                                if [ "$extension" == "a"  ]
                                then
                                        echo "$lastfile"
                                        otool -arch armv7 -l "$file" | grep bitcode
                                fi
                        
                fi 
        done 
} 


list_alldir "$COMPILE_OUT_PATH"
