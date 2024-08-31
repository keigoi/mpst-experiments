open! Base

type role = string [@@deriving show { with_path = false }]
type label = string [@@deriving show { with_path = false }]
type mode = Input | Output [@@deriving show { with_path = false }]
type recvar = string [@@deriving show { with_path = false }]

type ltype_ =
  | Comm of (role * mode * (label * ltype) list) list
  | LEnd
  | LVar of recvar
[@@deriving show { with_path = false }]

and ltype = (recvar * ltype_)


let role_a : role = "a"
and role_b : role = "b"
and role_c : role = "c"

let label_l1 : label = "l1"
and label_l2 : label = "l2"
and label_l3 : label = "l3"

type gtype = (role, ltype, String.comparator_witness) Map.t

(* let (-->) r1 r2 l =  *)