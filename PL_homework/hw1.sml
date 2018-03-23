
fun is_older( date1: int*int*int , date2: int*int*int) =
	(#1 date1 ) * 512 + (#2 date1 )*32+ (#3 date1 ) <	(#1 date2 ) * 512 + (#2 date2 )*32+ (#3 date2 )   
    

fun isDateMatchMonth( date : int*int*int , month: int) = 
	(#2 date) = month

fun number_in_month( dates: (int*int*int) list , month: int ) =
	if null dates 
	then 0
	else 
        (if isDateMatchMonth(hd dates , month  )  then 1 else 0) + number_in_month( tl dates , month) 
 
fun number_in_months( dates: (int*int*int) list , months: int list ) =
	if null dates orelse null months  
	then 0
	else number_in_month( dates , hd months  ) + number_in_months(dates , tl months )
 
fun dates_in_month( dates: (int*int*int) list , month: int ) =
	if null dates 
	then []
	else 
		if isDateMatchMonth(hd dates , month)    
		then (hd dates):: dates_in_month( tl dates , month  ) 
		else dates_in_month( tl dates , month  ) 
		
fun dates_in_months( dates: (int*int*int) list , months: int list ) =
	if null dates orelse null months  
	then []
	else dates_in_month( dates , hd months  ) @  dates_in_months(dates , tl months )

fun get_nth( words : string list , index : int ) = 
	if null words orelse index <= 0
	then ""
	else
		if index = 1
		then hd words
		else get_nth( tl words , index -1  )

val month_names = [  "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ] ;

fun date_to_string(date : int*int*int ) = 
	get_nth( month_names ,  #2 date ) ^ " " ^ Int.toString( #3 date ) ^ ", " ^ Int.toString( #1 date )

fun number_before_reaching_sum(sum: int  , datas : int list ) = 
	let 
		val remains = sum - (hd datas)
	in 
        if remains > 0
        then 1 + number_before_reaching_sum(remains ,  tl datas  )	
        else 0  
	end 

fun what_month( nday : int ) =
    number_before_reaching_sum( nday , [ 31,28,31,30,31,30,31,31,30,31,30,31 ] )+1 

fun month_range( day1 : int  , day2: int  ) = 
    if day1 > day2 
    then []
    else
        what_month( day1 ) :: month_range( day1 +1 , day2 )     


fun oldest( dates: (int*int*int) list ) =
    if null dates 
    then NONE
    else 
        let
            fun oldest_noneempty(   dates: (int*int*int) list ) = 
                if null (tl dates)
                then hd dates 
                else
                    let
                        val oldest_tl = oldest_noneempty( tl dates ) 
                    in
                        if is_older( hd dates , oldest_tl  )
                        then hd dates
                        else oldest_tl 
                    end
        in
            SOME( oldest_noneempty( dates ) )
        end 


