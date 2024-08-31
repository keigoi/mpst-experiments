open! Base

module type UntaggedName = sig
  type t [@@deriving show { with_path = false }, sexp_of]

  val of_string : string -> t
  val rename : t -> string -> t
  val update : t -> f:(string -> string) -> t
  val user : t -> string
  val create : string -> t
  val hash : t -> int

  include Comparable.S with type t := t
end

module type TaggedName = sig
  include UntaggedName

  val of_other_name : (module UntaggedName with type t = 'a) -> 'a -> t
end

module UntaggedName : UntaggedName = struct
  module M = struct
    type t = string [@@deriving show { with_path = false }, sexp_of]

    let of_string s = s
    let rename _n s = s
    let update n ~f = f n
    let user n = n
    let create value : t = value
    let compare n n' = String.compare n n'
    let hash n = String.hash n
  end

  include M
  include Comparable.Make (M)
end

module Make () : TaggedName = struct
  include UntaggedName

  let of_other_name (type a) (module Other : UntaggedName with type t = a)
      (name : a) : t =
    create (Other.user name)
end

module RoleName : TaggedName = Make ()
module LabelName : TaggedName = Make ()
module RecVarName : TaggedName = Make ()
