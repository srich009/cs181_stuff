(* Program B - 2 3 Tree *)


(* ----- Question 1 ----- *)

(* 2-3 Tree data type *)

datatype 'a baltree = EmptyTree
                    | Node2 of 'a * 'a baltree * 'a baltree
                    | Node3 of 'a * 'a * 'a baltree * 'a baltree * 'a baltree;


(* ----- Question 2 ----- *)

(* Helper comparison function for find23 *)
(* first argument = value for the search , second argument = value from the tree *)

fun compare23 x y =
    if x < y then ~1
    else if x > y then 1
    else 0 ;


(* 2 3 Tree find function *)

(*  Type:  (’a * ’b -> int) -> ’b baltree -> ’a -> ’b option  *)

fun find23 _ EmptyTree _ =  NONE

|   find23 cmp (Node2(midval,ltree,rtree)) item =
        if (cmp item midval) = 0 then
            SOME midval
        else if (cmp item midval) = ~1 then
            find23 cmp ltree item
        else
            find23 cmp rtree item

|   find23 cmp (Node3(loval,hival,ltree,mtree,rtree)) item =
        if (cmp item loval) = 0 then
            SOME loval
        else if (cmp item hival) = 0 then
            SOME hival
        else if (cmp item loval) = ~1 then
            find23 cmp ltree item
        else if (cmp item loval) = 1 andalso (cmp item hival) = ~1 then
            find23 cmp mtree item
        else
            find23 cmp rtree item ;


(* ----- Question 3 ----- *)

(* 2 3 Tree insert function *)

(*  Type:  ('a * 'a -> int) -> 'a baltree -> 'a -> 'a baltree  *)

fun insert23 c t v =
let
    datatype 'a my_problem = problem of 'a * 'a baltree * 'a baltree | ok of 'a baltree;

    fun my_insert23 _ EmptyTree item = Node2(item, EmptyTree, EmptyTree)    (* emptytree *)

    |   my_insert23 cmp (Node2(midval, EmptyTree, EmptyTree)) item =        (* 2node with no children *)
            if (cmp item midval) = ~1 then
                Node3(item, midval, EmptyTree, EmptyTree, EmptyTree)
            else
                Node3(midval, item, EmptyTree, EmptyTree, EmptyTree)

    |   my_insert23 cmp (Node3(loval, hival, EmptyTree, EmptyTree, EmptyTree)) item =    (* 3node with no children *) (* return problem *)
            if (cmp item loval) = ~1 then
                problem(loval, Node2(item, EmptyTree, EmptyTree), Node2(hival, EmptyTree, EmptyTree))
            else if (cmp item loval) = 1 andalso (cmp item hival) = ~1 then
                problem(item, Node2(loval, EmptyTree, EmptyTree), Node2(hival, EmptyTree, EmptyTree))
            else
                problem(hival, Node2(loval, EmptyTree, EmptyTree), Node2(item, EmptyTree, EmptyTree))

    |   my_insert23 cmp (Node2(midval, ltree, rtree)) item =    (* recurse on a 2 node *)
        let
            val ret =
                if (cmp item midval) = ~1 then
                      (my_insert23 cmp ltree item)
                else
                      (my_insert23 cmp rtree item)
        in
            case ret of
                 problem(v, Node2(v1,l1,r1), Node2(v2,l2,r2)) =>
                    if (cmp item midval) = ~1 then
                        Node3(v, midval, Node2(v1,l1,r1), Node2(v2,l2,r2), rtree)
                    else
                        Node3(midval, v, ltree, Node2(v1,l1,r1), Node2(v2,l2,r2))
                | Node3(v1, v2, l, m, r) =>
                    if (cmp item midval) = ~1 then
                        Node2(midval, Node3(v1, v2, l, m, r), rtree)
                    else
                        Node2(midval, ltree, Node3(v1, v2, l, m, r))
        end


                (*
    |   my_insert23 cmp (Node3(loval, hival, ltree, mtree, rtree)) item =    (* recurse on 3 node *)
            if (cmp item loval) = ~1 then
                my_insert23 cmp ltree item
                Node3(loval, hival, ltree, mtree, rtree)
            else if (cmp item loval) = 1 andalso (cmp item hival) = ~1 then
                my_insert23 cmp mtree item
                Node3(loval, hival, ltree, mtree, rtree)
            else
                my_insert23 cmp rtree item
                Node3(loval, hival, ltree, mtree, rtree)
                *)

in
    my_insert23 c t v
end;






