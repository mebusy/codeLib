
(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

(* Assume all strings have at least 1 character *)
fun only_capitals strList = 
    List.filter (fn str => Char.isUpper(String.sub(str , 0) )) strList 

fun longest_string1 strList = 
    List.foldl (fn (str_new, str_longest)=> if String.size str_new > String.size str_longest then str_new else str_longest ) "" strList 


fun longest_string2 strList = 
    List.foldl (fn (str_new, str_longest)=> if String.size str_new >= String.size str_longest then str_new else str_longest ) "" strList 

val longest_string_helper = fn f  => fn strList => List.foldl ( fn (str_new, str_longest) => if f(String.size(str_new), String.size(str_longest)) then str_new else str_longest )  "" strList

val longest_string3 = longest_string_helper (fn (size_new, size_longest) => size_new > size_longest )

val longest_string4 = longest_string_helper (fn (size_new, size_longest) => size_new >= size_longest )

val  longest_capitalized = longest_string1 o only_capitals 

val rev_string = String.implode o  List.rev o String.explode
    
fun first_answer f = fn l => 
    case l of 
        [] => raise NoAnswer 
        | x::xs => case f x of 
                NONE => first_answer f xs  
                | SOME v => v 

fun all_answers f l = 
    let fun aux (f,l, acc) = 
        case l of 
            [] => SOME acc 
            | x::xs => case f x of 
                        NONE => NONE 
                        | SOME y => aux(  f, xs , acc @ y )
    in aux(f,l, []) end 



fun count_wildcards p = 
    g ( fn () => 1  ) (fn _  => 0 ) p  

fun count_wild_and_variable_lengths p = 
    g ( fn _ => 1  ) (fn str  => String.size(str) ) p  

fun count_some_var (s, p ) = 
    g ( fn _ => 0 ) (fn str => if s= str then 1 else 0 ) p

fun check_pat p = 
    let
             
        fun r  p =
            case p of
               Variable x        => [x]
              | TupleP ps         => List.foldl (fn (p,i) => (r p) @ i) [] ps
              | ConstructorP(_,p) => r p
              | _                 => [] 
        fun check_repeat_string strList = 
            case strList of 
                [] => true 
                | x::xs => if List.exists (fn x' => x'=x) xs then false else check_repeat_string xs  
    in
        check_repeat_string ( r p ) 
    end



fun match ( v  , pattern ) = 
    case ( v  , pattern ) of 
          (_, Wildcard ) => SOME []
        | (Unit,UnitP)    => SOME []
        | (_, Variable s) => SOME [(s, v)]
        | (Const i , ConstP j) => if i=j then SOME[] else NONE 
        | (Tuple vs, TupleP ps ) => if length vs = length ps then all_answers match (ListPair.zip(vs,ps))  else NONE 
        | (Constructor(s1,cv), ConstructorP(s2,cp)) => if s1=s2
                                                     then match(cv,cp)
                                                     else NONE
        | _ => NONE 

fun first_match  valu  ps  = 
    SOME (first_answer  (fn p => match (valu , p)) ps)
    handle _ => NONE 


(*
val test1 = only_capitals ["A","B","C"] = ["A","B","C"]
val test1_1 = only_capitals([]) = []
val test1_2 = only_capitals(["a", "B"]) = ["B"]


val test2 = longest_string1 ["A","bc","C"] = "bc"

val test2_1 = longest_string1 [] = ""
val test2_2 = longest_string1 ["cd","bc","C"] = "cd"

val test3 = longest_string2 ["A","bc","C"] = "bc"
val test3_1 = longest_string2 [] = ""
val test3_2 = longest_string2 ["cd","bc","C"] = "bc"

val test4a = longest_string3 ["A","bc","C"] = "bc"
val test4a_1 = longest_string3 [] = ""
val test4a_2 = longest_string3 ["cd","bc","C"] = "cd"

val test4b = longest_string4 ["A","bc","C"] = "bc"
val test4b_1 = longest_string4 [] = ""
val test4b_2 = longest_string4 ["cd","bc","C"] = "bc"

val test5 = longest_capitalized ["A","bc","C"] = "A"
val test5_1 = longest_capitalized [] = ""
val test5_2 = longest_capitalized ["A","Bc","C"] = "Bc"
val test5_3 = longest_capitalized ["a","bc","c"] = ""

val test6 = rev_string "abc" = "cba"
val test6_1 = rev_string "" = "" 

val test7 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4

val test8 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE
val test8_1 = all_answers (fn x => if x > 4 then SOME [x] else NONE) [2,3,4,5,6,7]= NONE 
val test8_2 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [] = SOME [] 

val test9a = count_wildcards Wildcard = 1 
val test9a_1 = count_wildcards (Variable( "s")) = 0
val test9a_2 = count_wildcards (TupleP ( [Wildcard , Variable ("t"), Wildcard] )) = 2
val test9a_3 = count_wildcards (TupleP ( [Wildcard , Variable ("t"), Wildcard, ConstructorP ( "t", Wildcard )] )) = 3 

val test9b = count_wild_and_variable_lengths (Variable("a")) = 1
val test9b_1 = count_wild_and_variable_lengths Wildcard = 1
val test9b_2 = count_wild_and_variable_lengths  (TupleP ( [Wildcard , Variable ("ta"), Wildcard] ))= 4
val test9b_3  = count_wild_and_variable_lengths (TupleP ( [Wildcard , Variable ("t"), Wildcard, ConstructorP ( "t", Wildcard )] )) = 4 

val test9c = count_some_var ("x", Variable("x")) = 1 
val test9c_1 = count_some_var ("x", Wildcard ) = 0
val test9c_2 = count_some_var  ("t" , TupleP ( [Wildcard , Variable ("z"), Wildcard, ConstructorP ( "t", Wildcard )] ))= 0

val test10 = check_pat (Variable("x")) = true
val test10_1 = check_pat ( TupleP ( [ Variable ("z"), ConstructorP ( "t", Variable("t") )] )) = true
val test10_2 = check_pat ( TupleP ( [ Variable ("z"), ConstructorP ( "t", Variable("z") )] )) = false
val test10_3 = check_pat ( TupleP ( [] )) = true

val test11 = match (Const(1), UnitP) = NONE
val test12 = first_match Unit [UnitP] = SOME []
*)
