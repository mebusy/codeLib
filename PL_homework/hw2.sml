(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

(*You may assume the string is in the list at most once*)
(* NONE only in 2 case: empty list , and , last string unmatch  *)
fun all_except_option ( str , strList ) = 
    case strList of  
          [] => NONE
        | x::xs => if same_string(x,str) then
                      SOME xs
                   else
                        let 
                            val result = all_except_option(str, xs)
                        in
                            case result of 
                                NONE => NONE
                                | SOME a => SOME( x::a)
                        end

(* Assume each list in substitutions has no repeats. *)
fun get_substitutions1 ( strListList , str ) = 
    case strListList of
          [] => []
        | x::xs => let
                       val result = all_except_option(str, x )
                   in
                       case result of
                          NONE => get_substitutions1(xs,str)
                          | SOME a => a @ get_substitutions1(xs,str)
                   end
                   
fun get_substitutions2 (strListList , str ) = 
    let 
        fun aux(strListList2 , str2 , acc ) = 
            case strListList2 of 
                [] => acc 
                | x::xs => 
                   let
                       val result = all_except_option(str2, x )
                   in
                       case result of
                          NONE     => aux(xs , str2 , acc ) 
                          | SOME a => aux(xs , str2 , acc@a ) 
                   end
    in
        aux(strListList , str , [])
    end
    
fun similar_names (strListList , {first,middle,last}) = 
    let 
        fun aux( subs , middle , last , acc ) =
            case subs of 
                [] => acc 
                | x::xs => aux( xs , middle, last ,acc @ [{first=x , middle=middle, last=last}] )

    in
        aux( first::get_substitutions2(strListList , first ) ,middle , last ,  [])
    end 

fun card_color ( c , _ ) = 
    case c of
        Spades => Black 
        | Clubs => Black 
        | _ => Red

fun card_value ( _ , num ) = 
    case num of 
        Num a => a 
        | Ace => 11
        | _ => 10

fun remove_card ( cs , c  , e ) = 
    case cs of 
        x::xs => if x=c  then
                    xs
                else (
                    case remove_card(xs , c  , e) of 
                        cs' => x::cs'               
                )
        | _ => raise e 
        

fun all_same_color( cs ) = 
    case cs of 
        [] => true
        | _::[] => true 
        | c :: c'::cs' => card_color(c)=card_color(c') andalso all_same_color(c'::cs') 

fun sum_cards cs = 
    let 
        fun aux(cs', acc) = 
           case cs' of 
                [] => acc
               | c::xs => aux(xs , acc + card_value(c)) 
    in
        aux(cs , 0 )
    end

fun score (cs, goal)  = 
    let
        val  sum = sum_cards(cs) 
        val  bSameColor = all_same_color(cs)
        val preliminary_score = if sum > goal then 3*(sum-goal) else goal-sum
    in
        if bSameColor then preliminary_score div 2 else preliminary_score  
    end

fun officiate (cs , ms , goal ) = 
    let
        fun play(cs, ms , goal , hs ) = 
           case ms of 
                [] => score(hs, goal ) 
              |  m'::ms' => case m' of 
                               Discard c => play(cs , ms' , goal ,  remove_card(hs , c, IllegalMove  ))
                            |  Draw => case cs of 
                                        [] => score(hs, goal )
                                      | c'::cs' =>if sum_cards(c'::hs) > goal then score(c'::hs,goal ) else play(cs', ms' , goal , c'::hs )
    in
        play(cs,ms,goal , [] )
    end


