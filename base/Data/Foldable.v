(* Default settings (from HsToCoq.Coq.Preamble) *)

Generalizable All Variables.

Unset Implicit Arguments.
Set Maximal Implicit Insertion.
Unset Strict Implicit.
Unset Printing Implicit Defensive.

Require Coq.Program.Tactics.
Require Coq.Program.Wf.

(* Preamble *)

Require Import Data.Monoid.
(* Converted imports: *)

Require Coq.Program.Basics.
Require Data.Either.
Require Data.Monoid.
Require Data.Proxy.
Require GHC.Base.
Require GHC.List.
Require GHC.Num.
Require GHC.Prim.
Require GHC.Tuple.
Import GHC.Base.Notations.
Import GHC.Num.Notations.

(* Converted type declarations: *)

Inductive Min a : Type := Mk_Min : option a -> Min a.

Inductive Max a : Type := Mk_Max : option a -> Max a.

Record Foldable__Dict t := Foldable__Dict_Build {
  elem__ : forall {a}, forall `{GHC.Base.Eq_ a}, a -> t a -> bool ;
  fold__ : forall {m}, forall `{GHC.Base.Monoid m}, t m -> m ;
  foldMap__ : forall {m} {a}, forall `{GHC.Base.Monoid m}, (a -> m) -> t a -> m ;
  foldl__ : forall {b} {a}, (b -> a -> b) -> b -> t a -> b ;
  foldl'__ : forall {b} {a}, (b -> a -> b) -> b -> t a -> b ;
  foldr__ : forall {a} {b}, (a -> b -> b) -> b -> t a -> b ;
  foldr'__ : forall {a} {b}, (a -> b -> b) -> b -> t a -> b ;
  length__ : forall {a}, t a -> GHC.Num.Int ;
  null__ : forall {a}, t a -> bool ;
  product__ : forall {a}, forall `{GHC.Num.Num a}, t a -> a ;
  sum__ : forall {a}, forall `{GHC.Num.Num a}, t a -> a ;
  toList__ : forall {a}, t a -> list a }.

Definition Foldable t :=
  forall r, (Foldable__Dict t -> r) -> r.

Existing Class Foldable.

Definition elem `{g : Foldable t} : forall {a},
                                      forall `{GHC.Base.Eq_ a}, a -> t a -> bool :=
  g _ (elem__ t).

Definition fold `{g : Foldable t} : forall {m},
                                      forall `{GHC.Base.Monoid m}, t m -> m :=
  g _ (fold__ t).

Definition foldMap `{g : Foldable t} : forall {m} {a},
                                         forall `{GHC.Base.Monoid m}, (a -> m) -> t a -> m :=
  g _ (foldMap__ t).

Definition foldl `{g : Foldable t} : forall {b} {a},
                                       (b -> a -> b) -> b -> t a -> b :=
  g _ (foldl__ t).

Definition foldl' `{g : Foldable t} : forall {b} {a},
                                        (b -> a -> b) -> b -> t a -> b :=
  g _ (foldl'__ t).

Definition foldr `{g : Foldable t} : forall {a} {b},
                                       (a -> b -> b) -> b -> t a -> b :=
  g _ (foldr__ t).

Definition foldr' `{g : Foldable t} : forall {a} {b},
                                        (a -> b -> b) -> b -> t a -> b :=
  g _ (foldr'__ t).

Definition length `{g : Foldable t} : forall {a}, t a -> GHC.Num.Int :=
  g _ (length__ t).

Definition null `{g : Foldable t} : forall {a}, t a -> bool :=
  g _ (null__ t).

Definition product `{g : Foldable t} : forall {a},
                                         forall `{GHC.Num.Num a}, t a -> a :=
  g _ (product__ t).

Definition sum `{g : Foldable t} : forall {a},
                                     forall `{GHC.Num.Num a}, t a -> a :=
  g _ (sum__ t).

Definition toList `{g : Foldable t} : forall {a}, t a -> list a :=
  g _ (toList__ t).

Arguments Mk_Min {_} _.

Arguments Mk_Max {_} _.

Definition getMin {a} (arg_31__ : Min a) :=
  match arg_31__ with
    | Mk_Min getMin => getMin
  end.

Definition getMax {a} (arg_32__ : Max a) :=
  match arg_32__ with
    | Mk_Max getMax => getMax
  end.
(* Midamble *)

Definition default_elem {t : Type -> Type} {a} `{GHC.Base.Eq_ a} (foldMap : (a -> Any) -> t a -> Any) :
  a -> t a -> bool :=
   fun x xs => getAny (foldMap (fun y => Mk_Any (GHC.Base.op_zeze__ x y)) xs).


Definition default_foldable {f:Type -> Type}
  (foldMap : forall {m} {a}, forall `{GHC.Base.Monoid m}, (a -> m) -> f a -> m)
  (foldr : forall {a} {b}, (a -> b -> b) -> b -> f a -> b):=
  let foldl : forall {b} {a}, (b -> a -> b) -> b -> f a -> b :=
      (fun {b} {a} =>
         fun f  z t => Data.Monoid.appEndo
                    (Data.Monoid.getDual
                       (foldMap (Coq.Program.Basics.compose
                                   Data.Monoid.Mk_Dual
                                   (Coq.Program.Basics.compose
                                      Data.Monoid.Mk_Endo
                                      (GHC.Base.flip f))) t)) z)
  in
  let foldl' : forall {b} {a}, (b -> a -> b) -> b -> f a -> b :=
      (fun {b} {a} =>
         fun f  z0  xs =>
           let f' :=  fun  x  k  z => GHC.Base.op_zdzn__ k (f z x)
           in foldr f' GHC.Base.id xs z0)
  in
  Foldable__Dict_Build
    f
    (fun {a} `{GHC.Base.Eq_ a} =>
       Coq.Program.Basics.compose
         (fun p => Coq.Program.Basics.compose
                  Data.Monoid.getAny
                  (foldMap (fun x => Data.Monoid.Mk_Any (p x))))
         GHC.Base.op_zeze__ )
    (* fold *)
    (fun {m} `{GHC.Base.Monoid m} => foldMap GHC.Base.id)
    (* foldMap *)
    (fun {m}{a} `{GHC.Base.Monoid m} => foldMap)
    (* foldl *)
    foldl
    (* foldl' *)
    foldl'
    (* foldr  *)
    (fun {a}{b} => foldr)
    (* foldr' *)
    (fun {a} {b} f z0 xs =>
       let f' := fun k  x  z => GHC.Base.op_zdzn__ k (f x z)
       in
       foldl _ _ f' GHC.Base.id xs z0)
    (* length *)
    (fun {a} => foldl' _ _ (fun c  _ => GHC.Num.op_zp__ c (GHC.Num.fromInteger 1))
                    (GHC.Num.fromInteger 0))
    (* null *)
    (fun {a} => foldr (fun arg_61__ arg_62__ => false) true)
    (* product *)
    (fun {a} `{GHC.Num.Num a} =>
       Coq.Program.Basics.compose Data.Monoid.getProduct
                                  (foldMap Data.Monoid.Mk_Product))
    (* sum *)
    (fun  {a} `{GHC.Num.Num a} =>
       Coq.Program.Basics.compose Data.Monoid.getSum
                                  (foldMap Data.Monoid.Mk_Sum))
    (* toList *)
    (fun {a} => fun t => GHC.Base.build (fun c n => foldr c n t)).

Definition default_foldable_foldMap {f : Type -> Type}
  (foldMap : forall {m} {a}, forall `{GHC.Base.Monoid m}, (a -> m) -> f a -> m)
 :=
  let foldr : forall {a} {b}, (a -> b -> b) -> b -> f a -> b :=
  fun {a} {b} f z t =>
    Data.Monoid.appEndo
      (foldMap
         (Coq.Program.Basics.compose Data.Monoid.Mk_Endo f) t) z
  in
  default_foldable (fun {m}{a}`{GHC.Base.Monoid m} => foldMap) foldr.

Definition default_foldable_foldr (f : Type -> Type)
  (foldr : forall {a} {b}, (a -> b -> b) -> b -> f a -> b) :=
  let foldMap :  forall {m} {a} `{GHC.Base.Monoid m}, (a -> m) -> f a -> m :=
  fun {m} {a} `{GHC.Base.Monoid m} =>
    fun f => foldr
            (Coq.Program.Basics.compose GHC.Base.mappend
                                        f) GHC.Base.mempty
  in
  default_foldable foldMap (fun {a} {b} => foldr).

(* Converted value declarations: *)

Local Definition instance_Data_Foldable_Foldable_option_foldl : forall {b} {a},
                                                                  (b -> a -> b) -> b -> option a -> b :=
  fun {b} {a} =>
    fun arg_324__ arg_325__ arg_326__ =>
      match arg_324__ , arg_325__ , arg_326__ with
        | _ , z , None => z
        | f , z , Some x => f z x
      end.

Local Definition instance_Data_Foldable_Foldable_option_foldr' : forall {a} {b},
                                                                   (a -> b -> b) -> b -> option a -> b :=
  fun {a} {b} =>
    fun f z0 xs =>
      let f' := fun k x z => k GHC.Base.$! f x z in
      instance_Data_Foldable_Foldable_option_foldl f' GHC.Base.id xs z0.

Local Definition instance_Data_Foldable_Foldable_option_foldr : forall {a} {b},
                                                                  (a -> b -> b) -> b -> option a -> b :=
  fun {a} {b} =>
    fun arg_319__ arg_320__ arg_321__ =>
      match arg_319__ , arg_320__ , arg_321__ with
        | _ , z , None => z
        | f , z , Some x => f x z
      end.

Local Definition instance_Data_Foldable_Foldable_option_null : forall {a},
                                                                 option a -> bool :=
  fun {a} =>
    instance_Data_Foldable_Foldable_option_foldr (fun arg_18__ arg_19__ => false)
    true.

Local Definition instance_Data_Foldable_Foldable_option_toList : forall {a},
                                                                   option a -> list a :=
  fun {a} =>
    fun t =>
      GHC.Base.build (fun c n => instance_Data_Foldable_Foldable_option_foldr c n t).

Local Definition instance_Data_Foldable_Foldable_option_foldl' : forall {b} {a},
                                                                   (b -> a -> b) -> b -> option a -> b :=
  fun {b} {a} =>
    fun f z0 xs =>
      let f' := fun x k z => k GHC.Base.$! f z x in
      instance_Data_Foldable_Foldable_option_foldr f' GHC.Base.id xs z0.

Local Definition instance_Data_Foldable_Foldable_option_length : forall {a},
                                                                   option a -> GHC.Num.Int :=
  fun {a} =>
    instance_Data_Foldable_Foldable_option_foldl' (fun arg_21__ arg_22__ =>
                                                    match arg_21__ , arg_22__ with
                                                      | c , _ => c GHC.Num.+ GHC.Num.fromInteger 1
                                                    end) (GHC.Num.fromInteger 0).

Local Definition instance_Data_Foldable_Foldable_option_foldMap : forall {m}
                                                                         {a},
                                                                    forall `{GHC.Base.Monoid m},
                                                                      (a -> m) -> option a -> m :=
  fun {m} {a} `{GHC.Base.Monoid m} =>
    fun f =>
      instance_Data_Foldable_Foldable_option_foldr (GHC.Base.mappend GHC.Base.∘ f)
      GHC.Base.mempty.

Local Definition instance_Data_Foldable_Foldable_option_fold : forall {m},
                                                                 forall `{GHC.Base.Monoid m}, option m -> m :=
  fun {m} `{GHC.Base.Monoid m} =>
    instance_Data_Foldable_Foldable_option_foldMap GHC.Base.id.

Local Definition instance_Data_Foldable_Foldable_option_elem {a} {H
                                                               : GHC.Base.Eq_ a} : a -> option a -> bool :=
  default_elem instance_Data_Foldable_Foldable_option_foldMap.

Local Definition instance_Data_Foldable_Foldable_list_elem : forall {a},
                                                               forall `{GHC.Base.Eq_ a}, a -> list a -> bool :=
  fun {a} `{GHC.Base.Eq_ a} => GHC.List.elem.

Local Definition instance_Data_Foldable_Foldable_list_foldl : forall {b} {a},
                                                                (b -> a -> b) -> b -> list a -> b :=
  fun {b} {a} => GHC.Base.foldl.

Local Definition instance_Data_Foldable_Foldable_list_foldr' : forall {a} {b},
                                                                 (a -> b -> b) -> b -> list a -> b :=
  fun {a} {b} =>
    fun f z0 xs =>
      let f' := fun k x z => k GHC.Base.$! f x z in
      instance_Data_Foldable_Foldable_list_foldl f' GHC.Base.id xs z0.

Local Definition instance_Data_Foldable_Foldable_list_foldl' : forall {b} {a},
                                                                 (b -> a -> b) -> b -> list a -> b :=
  fun {b} {a} => GHC.Base.foldl'.

Local Definition instance_Data_Foldable_Foldable_list_foldr : forall {a} {b},
                                                                (a -> b -> b) -> b -> list a -> b :=
  fun {a} {b} => GHC.Base.foldr.

Local Definition instance_Data_Foldable_Foldable_list_foldMap : forall {m} {a},
                                                                  forall `{GHC.Base.Monoid m},
                                                                    (a -> m) -> list a -> m :=
  fun {m} {a} `{GHC.Base.Monoid m} =>
    fun f =>
      instance_Data_Foldable_Foldable_list_foldr (GHC.Base.mappend GHC.Base.∘ f)
      GHC.Base.mempty.

Local Definition instance_Data_Foldable_Foldable_list_fold : forall {m},
                                                               forall `{GHC.Base.Monoid m}, list m -> m :=
  fun {m} `{GHC.Base.Monoid m} =>
    instance_Data_Foldable_Foldable_list_foldMap GHC.Base.id.

Local Definition instance_Data_Foldable_Foldable_list_length : forall {a},
                                                                 list a -> GHC.Num.Int :=
  fun {a} => GHC.List.length.

Local Definition instance_Data_Foldable_Foldable_list_null : forall {a},
                                                               list a -> bool :=
  fun {a} => GHC.List.null.

Local Definition instance_Data_Foldable_Foldable_list_product : forall {a},
                                                                  forall `{GHC.Num.Num a}, list a -> a :=
  fun {a} `{GHC.Num.Num a} => GHC.List.product.

Local Definition instance_Data_Foldable_Foldable_list_sum : forall {a},
                                                              forall `{GHC.Num.Num a}, list a -> a :=
  fun {a} `{GHC.Num.Num a} => GHC.List.sum.

Local Definition instance_Data_Foldable_Foldable_list_toList : forall {a},
                                                                 list a -> list a :=
  fun {a} => GHC.Base.id.

Program Instance instance_Data_Foldable_Foldable_list : Foldable list := fun _
                                                                             k =>
    k {|elem__ := fun {a} `{GHC.Base.Eq_ a} =>
        instance_Data_Foldable_Foldable_list_elem ;
      fold__ := fun {m} `{GHC.Base.Monoid m} =>
        instance_Data_Foldable_Foldable_list_fold ;
      foldMap__ := fun {m} {a} `{GHC.Base.Monoid m} =>
        instance_Data_Foldable_Foldable_list_foldMap ;
      foldl__ := fun {b} {a} => instance_Data_Foldable_Foldable_list_foldl ;
      foldl'__ := fun {b} {a} => instance_Data_Foldable_Foldable_list_foldl' ;
      foldr__ := fun {a} {b} => instance_Data_Foldable_Foldable_list_foldr ;
      foldr'__ := fun {a} {b} => instance_Data_Foldable_Foldable_list_foldr' ;
      length__ := fun {a} => instance_Data_Foldable_Foldable_list_length ;
      null__ := fun {a} => instance_Data_Foldable_Foldable_list_null ;
      product__ := fun {a} `{GHC.Num.Num a} =>
        instance_Data_Foldable_Foldable_list_product ;
      sum__ := fun {a} `{GHC.Num.Num a} => instance_Data_Foldable_Foldable_list_sum ;
      toList__ := fun {a} => instance_Data_Foldable_Foldable_list_toList |}.

Local Definition instance_Data_Foldable_Foldable__Data_Either_Either_a__foldMap {inst_a}
    : forall {m} {a},
        forall `{GHC.Base.Monoid m}, (a -> m) -> (Data.Either.Either inst_a) a -> m :=
  fun {m} {a} `{GHC.Base.Monoid m} =>
    fun arg_306__ arg_307__ =>
      match arg_306__ , arg_307__ with
        | _ , Data.Either.Mk_Left _ => GHC.Base.mempty
        | f , Data.Either.Mk_Right y => f y
      end.

Local Definition instance_Data_Foldable_Foldable__Data_Either_Either_a__foldl {inst_a}
    : forall {b} {a}, (b -> a -> b) -> b -> (Data.Either.Either inst_a) a -> b :=
  fun {b} {a} =>
    fun f z t =>
      appEndo (getDual (instance_Data_Foldable_Foldable__Data_Either_Either_a__foldMap
                       (Data.Monoid.Mk_Dual GHC.Base.∘ (Data.Monoid.Mk_Endo GHC.Base.∘ GHC.Base.flip
                       f)) t)) z.

Local Definition instance_Data_Foldable_Foldable__Data_Either_Either_a__foldr' {inst_a}
    : forall {a} {b}, (a -> b -> b) -> b -> (Data.Either.Either inst_a) a -> b :=
  fun {a} {b} =>
    fun f z0 xs =>
      let f' := fun k x z => k GHC.Base.$! f x z in
      instance_Data_Foldable_Foldable__Data_Either_Either_a__foldl f' GHC.Base.id xs
      z0.

Local Definition instance_Data_Foldable_Foldable__Data_Either_Either_a__fold {inst_a}
    : forall {m}, forall `{GHC.Base.Monoid m}, (Data.Either.Either inst_a) m -> m :=
  fun {m} `{GHC.Base.Monoid m} =>
    instance_Data_Foldable_Foldable__Data_Either_Either_a__foldMap GHC.Base.id.

Local Definition instance_Data_Foldable_Foldable__Data_Either_Either_a__elem {inst_a}
                                                                             {a} {H : GHC.Base.Eq_ a}
    : a -> Data.Either.Either inst_a a -> bool :=
  default_elem instance_Data_Foldable_Foldable__Data_Either_Either_a__foldMap.

Local Definition instance_Data_Foldable_Foldable__Data_Either_Either_a__foldr {inst_a}
    : forall {a} {b}, (a -> b -> b) -> b -> (Data.Either.Either inst_a) a -> b :=
  fun {a} {b} =>
    fun arg_310__ arg_311__ arg_312__ =>
      match arg_310__ , arg_311__ , arg_312__ with
        | _ , z , Data.Either.Mk_Left _ => z
        | f , z , Data.Either.Mk_Right y => f y z
      end.

Local Definition instance_Data_Foldable_Foldable__Data_Either_Either_a__toList {inst_a}
    : forall {a}, (Data.Either.Either inst_a) a -> list a :=
  fun {a} =>
    fun t =>
      GHC.Base.build (fun c n =>
                       instance_Data_Foldable_Foldable__Data_Either_Either_a__foldr c n t).

Local Definition instance_Data_Foldable_Foldable__Data_Either_Either_a__foldl' {inst_a}
    : forall {b} {a}, (b -> a -> b) -> b -> (Data.Either.Either inst_a) a -> b :=
  fun {b} {a} =>
    fun f z0 xs =>
      let f' := fun x k z => k GHC.Base.$! f z x in
      instance_Data_Foldable_Foldable__Data_Either_Either_a__foldr f' GHC.Base.id xs
      z0.

Local Definition instance_Data_Foldable_Foldable__Data_Either_Either_a__length {inst_a}
    : forall {a}, (Data.Either.Either inst_a) a -> GHC.Num.Int :=
  fun {a} =>
    fun arg_315__ =>
      match arg_315__ with
        | Data.Either.Mk_Left _ => GHC.Num.fromInteger 0
        | Data.Either.Mk_Right _ => GHC.Num.fromInteger 1
      end.

Local Definition instance_Data_Foldable_Foldable__Data_Either_Either_a__null {inst_a}
    : forall {a}, (Data.Either.Either inst_a) a -> bool :=
  fun {a} => Data.Either.isLeft.

Local Definition instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__foldMap {inst_a}
    : forall {m} {a},
        forall `{GHC.Base.Monoid m}, (a -> m) -> (GHC.Tuple.pair_type inst_a) a -> m :=
  fun {m} {a} `{GHC.Base.Monoid m} =>
    fun arg_297__ arg_298__ =>
      match arg_297__ , arg_298__ with
        | f , pair _ y => f y
      end.

Local Definition instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__foldl {inst_a}
    : forall {b} {a}, (b -> a -> b) -> b -> (GHC.Tuple.pair_type inst_a) a -> b :=
  fun {b} {a} =>
    fun f z t =>
      appEndo (getDual
              (instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__foldMap
              (Data.Monoid.Mk_Dual GHC.Base.∘ (Data.Monoid.Mk_Endo GHC.Base.∘ GHC.Base.flip
              f)) t)) z.

Local Definition instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__foldr' {inst_a}
    : forall {a} {b}, (a -> b -> b) -> b -> (GHC.Tuple.pair_type inst_a) a -> b :=
  fun {a} {b} =>
    fun f z0 xs =>
      let f' := fun k x z => k GHC.Base.$! f x z in
      instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__foldl f' GHC.Base.id xs
      z0.

Local Definition instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__fold {inst_a}
    : forall {m},
        forall `{GHC.Base.Monoid m}, (GHC.Tuple.pair_type inst_a) m -> m :=
  fun {m} `{GHC.Base.Monoid m} =>
    instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__foldMap GHC.Base.id.

Local Definition instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__elem {inst_a}
                                                                              {a} {H : GHC.Base.Eq_ a}
    : a -> GHC.Tuple.pair_type inst_a a -> bool :=
  default_elem instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__foldMap.

Local Definition instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__foldr {inst_a}
    : forall {a} {b}, (a -> b -> b) -> b -> (GHC.Tuple.pair_type inst_a) a -> b :=
  fun {a} {b} =>
    fun arg_301__ arg_302__ arg_303__ =>
      match arg_301__ , arg_302__ , arg_303__ with
        | f , z , pair _ y => f y z
      end.

Local Definition instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__null {inst_a}
    : forall {a}, (GHC.Tuple.pair_type inst_a) a -> bool :=
  fun {a} =>
    instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__foldr (fun arg_18__
                                                                       arg_19__ =>
                                                                    false) true.

Local Definition instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__toList {inst_a}
    : forall {a}, (GHC.Tuple.pair_type inst_a) a -> list a :=
  fun {a} =>
    fun t =>
      GHC.Base.build (fun c n =>
                       instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__foldr c n t).

Local Definition instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__foldl' {inst_a}
    : forall {b} {a}, (b -> a -> b) -> b -> (GHC.Tuple.pair_type inst_a) a -> b :=
  fun {b} {a} =>
    fun f z0 xs =>
      let f' := fun x k z => k GHC.Base.$! f z x in
      instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__foldr f' GHC.Base.id xs
      z0.

Local Definition instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__length {inst_a}
    : forall {a}, (GHC.Tuple.pair_type inst_a) a -> GHC.Num.Int :=
  fun {a} =>
    instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__foldl' (fun arg_21__
                                                                        arg_22__ =>
                                                                     match arg_21__ , arg_22__ with
                                                                       | c , _ => c GHC.Num.+ GHC.Num.fromInteger 1
                                                                     end) (GHC.Num.fromInteger 0).

(* Skipping instance instance_Data_Foldable_Foldable__GHC_Arr_Array_i_ *)

Local Definition instance_Data_Foldable_Foldable_Data_Proxy_Proxy_elem
    : forall {a}, forall `{GHC.Base.Eq_ a}, a -> Data.Proxy.Proxy a -> bool :=
  fun {a} `{GHC.Base.Eq_ a} => fun arg_288__ arg_289__ => false.

Local Definition instance_Data_Foldable_Foldable_Data_Proxy_Proxy_fold
    : forall {m}, forall `{GHC.Base.Monoid m}, Data.Proxy.Proxy m -> m :=
  fun {m} `{GHC.Base.Monoid m} => fun arg_267__ => GHC.Base.mempty.

Local Definition instance_Data_Foldable_Foldable_Data_Proxy_Proxy_foldMap
    : forall {m} {a},
        forall `{GHC.Base.Monoid m}, (a -> m) -> Data.Proxy.Proxy a -> m :=
  fun {m} {a} `{GHC.Base.Monoid m} => fun arg_265__ arg_266__ => GHC.Base.mempty.

Local Definition instance_Data_Foldable_Foldable_Data_Proxy_Proxy_foldl
    : forall {b} {a}, (b -> a -> b) -> b -> Data.Proxy.Proxy a -> b :=
  fun {b} {a} =>
    fun arg_272__ arg_273__ arg_274__ =>
      match arg_272__ , arg_273__ , arg_274__ with
        | _ , z , _ => z
      end.

Local Definition instance_Data_Foldable_Foldable_Data_Proxy_Proxy_foldr'
    : forall {a} {b}, (a -> b -> b) -> b -> Data.Proxy.Proxy a -> b :=
  fun {a} {b} =>
    fun f z0 xs =>
      let f' := fun k x z => k GHC.Base.$! f x z in
      instance_Data_Foldable_Foldable_Data_Proxy_Proxy_foldl f' GHC.Base.id xs z0.

Local Definition instance_Data_Foldable_Foldable_Data_Proxy_Proxy_foldr
    : forall {a} {b}, (a -> b -> b) -> b -> Data.Proxy.Proxy a -> b :=
  fun {a} {b} =>
    fun arg_268__ arg_269__ arg_270__ =>
      match arg_268__ , arg_269__ , arg_270__ with
        | _ , z , _ => z
      end.

Local Definition instance_Data_Foldable_Foldable_Data_Proxy_Proxy_toList
    : forall {a}, Data.Proxy.Proxy a -> list a :=
  fun {a} =>
    fun t =>
      GHC.Base.build (fun c n =>
                       instance_Data_Foldable_Foldable_Data_Proxy_Proxy_foldr c n t).

Local Definition instance_Data_Foldable_Foldable_Data_Proxy_Proxy_foldl'
    : forall {b} {a}, (b -> a -> b) -> b -> Data.Proxy.Proxy a -> b :=
  fun {b} {a} =>
    fun f z0 xs =>
      let f' := fun x k z => k GHC.Base.$! f z x in
      instance_Data_Foldable_Foldable_Data_Proxy_Proxy_foldr f' GHC.Base.id xs z0.

Local Definition instance_Data_Foldable_Foldable_Data_Proxy_Proxy_length
    : forall {a}, Data.Proxy.Proxy a -> GHC.Num.Int :=
  fun {a} => fun arg_284__ => GHC.Num.fromInteger 0.

Local Definition instance_Data_Foldable_Foldable_Data_Proxy_Proxy_null
    : forall {a}, Data.Proxy.Proxy a -> bool :=
  fun {a} => fun arg_287__ => true.

Local Definition instance_Data_Foldable_Foldable_Data_Proxy_Proxy_product
    : forall {a}, forall `{GHC.Num.Num a}, Data.Proxy.Proxy a -> a :=
  fun {a} `{GHC.Num.Num a} => fun arg_293__ => GHC.Num.fromInteger 1.

Local Definition instance_Data_Foldable_Foldable_Data_Proxy_Proxy_sum
    : forall {a}, forall `{GHC.Num.Num a}, Data.Proxy.Proxy a -> a :=
  fun {a} `{GHC.Num.Num a} => fun arg_290__ => GHC.Num.fromInteger 0.

Program Instance instance_Data_Foldable_Foldable_Data_Proxy_Proxy : Foldable
                                                                    Data.Proxy.Proxy := fun _ k =>
    k {|elem__ := fun {a} `{GHC.Base.Eq_ a} =>
        instance_Data_Foldable_Foldable_Data_Proxy_Proxy_elem ;
      fold__ := fun {m} `{GHC.Base.Monoid m} =>
        instance_Data_Foldable_Foldable_Data_Proxy_Proxy_fold ;
      foldMap__ := fun {m} {a} `{GHC.Base.Monoid m} =>
        instance_Data_Foldable_Foldable_Data_Proxy_Proxy_foldMap ;
      foldl__ := fun {b} {a} =>
        instance_Data_Foldable_Foldable_Data_Proxy_Proxy_foldl ;
      foldl'__ := fun {b} {a} =>
        instance_Data_Foldable_Foldable_Data_Proxy_Proxy_foldl' ;
      foldr__ := fun {a} {b} =>
        instance_Data_Foldable_Foldable_Data_Proxy_Proxy_foldr ;
      foldr'__ := fun {a} {b} =>
        instance_Data_Foldable_Foldable_Data_Proxy_Proxy_foldr' ;
      length__ := fun {a} => instance_Data_Foldable_Foldable_Data_Proxy_Proxy_length ;
      null__ := fun {a} => instance_Data_Foldable_Foldable_Data_Proxy_Proxy_null ;
      product__ := fun {a} `{GHC.Num.Num a} =>
        instance_Data_Foldable_Foldable_Data_Proxy_Proxy_product ;
      sum__ := fun {a} `{GHC.Num.Num a} =>
        instance_Data_Foldable_Foldable_Data_Proxy_Proxy_sum ;
      toList__ := fun {a} =>
        instance_Data_Foldable_Foldable_Data_Proxy_Proxy_toList |}.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Dual_foldMap
    : forall {m} {a},
        forall `{GHC.Base.Monoid m}, (a -> m) -> Data.Monoid.Dual a -> m :=
  fun {m} {a} `{GHC.Base.Monoid m} => GHC.Prim.coerce.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Dual_fold
    : forall {m}, forall `{GHC.Base.Monoid m}, Data.Monoid.Dual m -> m :=
  fun {m} `{GHC.Base.Monoid m} =>
    instance_Data_Foldable_Foldable_Data_Monoid_Dual_foldMap GHC.Base.id.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Dual_foldl
    : forall {b} {a}, (b -> a -> b) -> b -> Data.Monoid.Dual a -> b :=
  fun {b} {a} => GHC.Prim.coerce.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Dual_foldl'
    : forall {b} {a}, (b -> a -> b) -> b -> Data.Monoid.Dual a -> b :=
  fun {b} {a} => GHC.Prim.coerce.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Dual_foldr
    : forall {a} {b}, (a -> b -> b) -> b -> Data.Monoid.Dual a -> b :=
  fun {a} {b} =>
    fun arg_252__ arg_253__ arg_254__ =>
      match arg_252__ , arg_253__ , arg_254__ with
        | f , z , Data.Monoid.Mk_Dual x => f x z
      end.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Dual_foldr'
    : forall {a} {b}, (a -> b -> b) -> b -> Data.Monoid.Dual a -> b :=
  fun {a} {b} => instance_Data_Foldable_Foldable_Data_Monoid_Dual_foldr.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Dual_length
    : forall {a}, Data.Monoid.Dual a -> GHC.Num.Int :=
  fun {a} => fun arg_258__ => GHC.Num.fromInteger 1.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Dual_null
    : forall {a}, Data.Monoid.Dual a -> bool :=
  fun {a} => fun arg_261__ => false.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Dual_product
    : forall {a}, forall `{GHC.Num.Num a}, Data.Monoid.Dual a -> a :=
  fun {a} `{GHC.Num.Num a} => getDual.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Dual_sum
    : forall {a}, forall `{GHC.Num.Num a}, Data.Monoid.Dual a -> a :=
  fun {a} `{GHC.Num.Num a} => getDual.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Dual_toList
    : forall {a}, Data.Monoid.Dual a -> list a :=
  fun {a} =>
    fun arg_262__ => match arg_262__ with | Data.Monoid.Mk_Dual x => cons x nil end.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Sum_foldMap
    : forall {m} {a},
        forall `{GHC.Base.Monoid m}, (a -> m) -> Data.Monoid.Sum a -> m :=
  fun {m} {a} `{GHC.Base.Monoid m} => GHC.Prim.coerce.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Sum_fold
    : forall {m}, forall `{GHC.Base.Monoid m}, Data.Monoid.Sum m -> m :=
  fun {m} `{GHC.Base.Monoid m} =>
    instance_Data_Foldable_Foldable_Data_Monoid_Sum_foldMap GHC.Base.id.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Sum_foldl
    : forall {b} {a}, (b -> a -> b) -> b -> Data.Monoid.Sum a -> b :=
  fun {b} {a} => GHC.Prim.coerce.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Sum_foldl'
    : forall {b} {a}, (b -> a -> b) -> b -> Data.Monoid.Sum a -> b :=
  fun {b} {a} => GHC.Prim.coerce.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Sum_foldr
    : forall {a} {b}, (a -> b -> b) -> b -> Data.Monoid.Sum a -> b :=
  fun {a} {b} =>
    fun arg_236__ arg_237__ arg_238__ =>
      match arg_236__ , arg_237__ , arg_238__ with
        | f , z , Data.Monoid.Mk_Sum x => f x z
      end.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Sum_foldr'
    : forall {a} {b}, (a -> b -> b) -> b -> Data.Monoid.Sum a -> b :=
  fun {a} {b} => instance_Data_Foldable_Foldable_Data_Monoid_Sum_foldr.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Sum_length
    : forall {a}, Data.Monoid.Sum a -> GHC.Num.Int :=
  fun {a} => fun arg_242__ => GHC.Num.fromInteger 1.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Sum_null
    : forall {a}, Data.Monoid.Sum a -> bool :=
  fun {a} => fun arg_245__ => false.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Sum_product
    : forall {a}, forall `{GHC.Num.Num a}, Data.Monoid.Sum a -> a :=
  fun {a} `{GHC.Num.Num a} => getSum.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Sum_sum
    : forall {a}, forall `{GHC.Num.Num a}, Data.Monoid.Sum a -> a :=
  fun {a} `{GHC.Num.Num a} => getSum.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Sum_toList
    : forall {a}, Data.Monoid.Sum a -> list a :=
  fun {a} =>
    fun arg_246__ => match arg_246__ with | Data.Monoid.Mk_Sum x => cons x nil end.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Product_foldMap
    : forall {m} {a},
        forall `{GHC.Base.Monoid m}, (a -> m) -> Data.Monoid.Product a -> m :=
  fun {m} {a} `{GHC.Base.Monoid m} => GHC.Prim.coerce.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Product_fold
    : forall {m}, forall `{GHC.Base.Monoid m}, Data.Monoid.Product m -> m :=
  fun {m} `{GHC.Base.Monoid m} =>
    instance_Data_Foldable_Foldable_Data_Monoid_Product_foldMap GHC.Base.id.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Product_foldl
    : forall {b} {a}, (b -> a -> b) -> b -> Data.Monoid.Product a -> b :=
  fun {b} {a} => GHC.Prim.coerce.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Product_foldl'
    : forall {b} {a}, (b -> a -> b) -> b -> Data.Monoid.Product a -> b :=
  fun {b} {a} => GHC.Prim.coerce.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Product_foldr
    : forall {a} {b}, (a -> b -> b) -> b -> Data.Monoid.Product a -> b :=
  fun {a} {b} =>
    fun arg_220__ arg_221__ arg_222__ =>
      match arg_220__ , arg_221__ , arg_222__ with
        | f , z , Data.Monoid.Mk_Product x => f x z
      end.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Product_foldr'
    : forall {a} {b}, (a -> b -> b) -> b -> Data.Monoid.Product a -> b :=
  fun {a} {b} => instance_Data_Foldable_Foldable_Data_Monoid_Product_foldr.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Product_length
    : forall {a}, Data.Monoid.Product a -> GHC.Num.Int :=
  fun {a} => fun arg_226__ => GHC.Num.fromInteger 1.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Product_null
    : forall {a}, Data.Monoid.Product a -> bool :=
  fun {a} => fun arg_229__ => false.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Product_product
    : forall {a}, forall `{GHC.Num.Num a}, Data.Monoid.Product a -> a :=
  fun {a} `{GHC.Num.Num a} => getProduct.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Product_sum
    : forall {a}, forall `{GHC.Num.Num a}, Data.Monoid.Product a -> a :=
  fun {a} `{GHC.Num.Num a} => getProduct.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Product_toList
    : forall {a}, Data.Monoid.Product a -> list a :=
  fun {a} =>
    fun arg_230__ =>
      match arg_230__ with
        | Data.Monoid.Mk_Product x => cons x nil
      end.

(* Skipping instance instance_Data_Foldable_Foldable_Data_Monoid_First *)

(* Skipping instance instance_Data_Foldable_Foldable_Data_Monoid_Last *)

Local Definition instance_forall___GHC_Base_Ord_a___GHC_Base_Monoid__Data_Foldable_Max_a__mappend {inst_a}
                                                                                                  `{GHC.Base.Ord inst_a}
    : (Max inst_a) -> (Max inst_a) -> (Max inst_a) :=
  fun arg_210__ arg_211__ =>
    match arg_210__ , arg_211__ with
      | m , Mk_Max None => m
      | Mk_Max None , n => n
      | Mk_Max (Some x as m) , Mk_Max (Some y as n) => let j_212__ := Mk_Max n in
                                                       if x GHC.Base.>= y : bool
                                                       then Mk_Max m
                                                       else j_212__
    end.

Local Definition instance_forall___GHC_Base_Ord_a___GHC_Base_Monoid__Data_Foldable_Max_a__mempty {inst_a}
                                                                                                 `{GHC.Base.Ord inst_a}
    : (Max inst_a) :=
  Mk_Max None.

Local Definition instance_forall___GHC_Base_Ord_a___GHC_Base_Monoid__Data_Foldable_Max_a__mconcat {inst_a}
                                                                                                  `{GHC.Base.Ord inst_a}
    : list (Max inst_a) -> (Max inst_a) :=
  GHC.Base.foldr
  instance_forall___GHC_Base_Ord_a___GHC_Base_Monoid__Data_Foldable_Max_a__mappend
  instance_forall___GHC_Base_Ord_a___GHC_Base_Monoid__Data_Foldable_Max_a__mempty.

Program Instance instance_forall___GHC_Base_Ord_a___GHC_Base_Monoid__Data_Foldable_Max_a_ {a}
                                                                                          `{GHC.Base.Ord a}
  : GHC.Base.Monoid (Max a) := fun _ k =>
    k
    {|GHC.Base.mappend__ := instance_forall___GHC_Base_Ord_a___GHC_Base_Monoid__Data_Foldable_Max_a__mappend ;
    GHC.Base.mconcat__ := instance_forall___GHC_Base_Ord_a___GHC_Base_Monoid__Data_Foldable_Max_a__mconcat ;
    GHC.Base.mempty__ := instance_forall___GHC_Base_Ord_a___GHC_Base_Monoid__Data_Foldable_Max_a__mempty |}.

Local Definition instance_forall___GHC_Base_Ord_a___GHC_Base_Monoid__Data_Foldable_Min_a__mappend {inst_a}
                                                                                                  `{GHC.Base.Ord inst_a}
    : (Min inst_a) -> (Min inst_a) -> (Min inst_a) :=
  fun arg_204__ arg_205__ =>
    match arg_204__ , arg_205__ with
      | m , Mk_Min None => m
      | Mk_Min None , n => n
      | Mk_Min (Some x as m) , Mk_Min (Some y as n) => let j_206__ := Mk_Min n in
                                                       if x GHC.Base.<= y : bool
                                                       then Mk_Min m
                                                       else j_206__
    end.

Local Definition instance_forall___GHC_Base_Ord_a___GHC_Base_Monoid__Data_Foldable_Min_a__mempty {inst_a}
                                                                                                 `{GHC.Base.Ord inst_a}
    : (Min inst_a) :=
  Mk_Min None.

Local Definition instance_forall___GHC_Base_Ord_a___GHC_Base_Monoid__Data_Foldable_Min_a__mconcat {inst_a}
                                                                                                  `{GHC.Base.Ord inst_a}
    : list (Min inst_a) -> (Min inst_a) :=
  GHC.Base.foldr
  instance_forall___GHC_Base_Ord_a___GHC_Base_Monoid__Data_Foldable_Min_a__mappend
  instance_forall___GHC_Base_Ord_a___GHC_Base_Monoid__Data_Foldable_Min_a__mempty.

Program Instance instance_forall___GHC_Base_Ord_a___GHC_Base_Monoid__Data_Foldable_Min_a_ {a}
                                                                                          `{GHC.Base.Ord a}
  : GHC.Base.Monoid (Min a) := fun _ k =>
    k
    {|GHC.Base.mappend__ := instance_forall___GHC_Base_Ord_a___GHC_Base_Monoid__Data_Foldable_Min_a__mappend ;
    GHC.Base.mconcat__ := instance_forall___GHC_Base_Ord_a___GHC_Base_Monoid__Data_Foldable_Min_a__mconcat ;
    GHC.Base.mempty__ := instance_forall___GHC_Base_Ord_a___GHC_Base_Monoid__Data_Foldable_Min_a__mempty |}.

(* Skipping instance instance_Data_Foldable_Foldable_GHC_Generics_U1 *)

(* Skipping instance instance_Data_Foldable_Foldable_GHC_Generics_V1 *)

(* Skipping instance instance_Data_Foldable_Foldable_GHC_Generics_Par1 *)

(* Skipping instance
   instance_forall___Data_Foldable_Foldable_f___Data_Foldable_Foldable__GHC_Generics_Rec1_f_ *)

(* Skipping instance instance_Data_Foldable_Foldable__GHC_Generics_K1_i_c_ *)

(* Skipping instance
   instance_forall___Data_Foldable_Foldable_f___Data_Foldable_Foldable__GHC_Generics_M1_i_c_f_ *)

(* Skipping instance
   instance_forall___Data_Foldable_Foldable_f____Data_Foldable_Foldable_g___Data_Foldable_Foldable___GHC_Generics______f_g_ *)

(* Skipping instance
   instance_forall___Data_Foldable_Foldable_f____Data_Foldable_Foldable_g___Data_Foldable_Foldable___GHC_Generics______f_g_ *)

(* Skipping instance
   instance_forall___Data_Foldable_Foldable_f____Data_Foldable_Foldable_g___Data_Foldable_Foldable___GHC_Generics______f_g_ *)

(* Skipping instance
   instance_Data_Foldable_Foldable__GHC_Generics_URec__GHC_Ptr_Ptr_unit__ *)

(* Skipping instance
   instance_Data_Foldable_Foldable__GHC_Generics_URec_GHC_Char_Char_ *)

(* Skipping instance
   instance_Data_Foldable_Foldable__GHC_Generics_URec_GHC_Types_Double_ *)

(* Skipping instance
   instance_Data_Foldable_Foldable__GHC_Generics_URec_GHC_Types_Float_ *)

(* Skipping instance
   instance_Data_Foldable_Foldable__GHC_Generics_URec_GHC_Num_Int_ *)

(* Skipping instance
   instance_Data_Foldable_Foldable__GHC_Generics_URec_GHC_Num_Word_ *)

Definition asum {t} {f} {a} `{Foldable t} `{GHC.Base.Alternative f} : t (f
                                                                        a) -> f a :=
  foldr _GHC.Base.<|>_ GHC.Base.empty.

Definition msum {t} {m} {a} `{Foldable t} `{GHC.Base.MonadPlus m} : t (m a) -> m
                                                                    a :=
  asum.

Definition concat {t} {a} `{Foldable t} : t (list a) -> list a :=
  fun xs => GHC.Base.build (fun c n => foldr (fun x y => foldr c y x) n xs).

Definition concatMap {t} {a} {b} `{Foldable t} : (a -> list b) -> t a -> list
                                                 b :=
  fun f xs => GHC.Base.build (fun c n => foldr (fun x b => foldr c b (f x)) n xs).

Definition find {t} {a} `{Foldable t} : (a -> bool) -> t a -> option a :=
  fun p =>
    getFirst GHC.Base.∘ foldMap (fun x =>
                                  Data.Monoid.Mk_First (if p x : bool then Some x else None)).

Definition foldlM {t} {m} {b} {a} `{Foldable t} `{GHC.Base.Monad m}
    : (b -> a -> m b) -> b -> t a -> m b :=
  fun f z0 xs =>
    let f' := fun x k z => f z x GHC.Base.>>= k in foldr f' GHC.Base.return_ xs z0.

Definition foldrM {t} {m} {a} {b} `{Foldable t} `{GHC.Base.Monad m}
    : (a -> b -> m b) -> b -> t a -> m b :=
  fun f z0 xs =>
    let f' := fun k x z => f x z GHC.Base.>>= k in foldl f' GHC.Base.return_ xs z0.

Definition hash_compose {a} {b} {c} :=
  (@Coq.Program.Basics.compose a b c).

Definition or {t} `{Foldable t} : t bool -> bool :=
  hash_compose getAny (foldMap Data.Monoid.Mk_Any).

Definition any {t} {a} `{Foldable t} : (a -> bool) -> t a -> bool :=
  fun p => hash_compose getAny (foldMap (hash_compose Data.Monoid.Mk_Any p)).

Definition and {t} `{Foldable t} : t bool -> bool :=
  hash_compose getAll (foldMap Data.Monoid.Mk_All).

Definition all {t} {a} `{Foldable t} : (a -> bool) -> t a -> bool :=
  fun p => hash_compose getAll (foldMap (hash_compose Data.Monoid.Mk_All p)).

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Product_elem
    : forall {a}, forall `{GHC.Base.Eq_ a}, a -> Data.Monoid.Product a -> bool :=
  fun {a} `{GHC.Base.Eq_ a} =>
    hash_compose (fun arg_217__ => arg_217__ GHC.Base.∘ getProduct) _GHC.Base.==_.

Program Instance instance_Data_Foldable_Foldable_Data_Monoid_Product : Foldable
                                                                       Data.Monoid.Product := fun _ k =>
    k {|elem__ := fun {a} `{GHC.Base.Eq_ a} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Product_elem ;
      fold__ := fun {m} `{GHC.Base.Monoid m} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Product_fold ;
      foldMap__ := fun {m} {a} `{GHC.Base.Monoid m} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Product_foldMap ;
      foldl__ := fun {b} {a} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Product_foldl ;
      foldl'__ := fun {b} {a} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Product_foldl' ;
      foldr__ := fun {a} {b} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Product_foldr ;
      foldr'__ := fun {a} {b} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Product_foldr' ;
      length__ := fun {a} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Product_length ;
      null__ := fun {a} => instance_Data_Foldable_Foldable_Data_Monoid_Product_null ;
      product__ := fun {a} `{GHC.Num.Num a} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Product_product ;
      sum__ := fun {a} `{GHC.Num.Num a} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Product_sum ;
      toList__ := fun {a} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Product_toList |}.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Sum_elem
    : forall {a}, forall `{GHC.Base.Eq_ a}, a -> Data.Monoid.Sum a -> bool :=
  fun {a} `{GHC.Base.Eq_ a} =>
    hash_compose (fun arg_233__ => arg_233__ GHC.Base.∘ getSum) _GHC.Base.==_.

Program Instance instance_Data_Foldable_Foldable_Data_Monoid_Sum : Foldable
                                                                   Data.Monoid.Sum := fun _ k =>
    k {|elem__ := fun {a} `{GHC.Base.Eq_ a} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Sum_elem ;
      fold__ := fun {m} `{GHC.Base.Monoid m} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Sum_fold ;
      foldMap__ := fun {m} {a} `{GHC.Base.Monoid m} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Sum_foldMap ;
      foldl__ := fun {b} {a} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Sum_foldl ;
      foldl'__ := fun {b} {a} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Sum_foldl' ;
      foldr__ := fun {a} {b} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Sum_foldr ;
      foldr'__ := fun {a} {b} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Sum_foldr' ;
      length__ := fun {a} => instance_Data_Foldable_Foldable_Data_Monoid_Sum_length ;
      null__ := fun {a} => instance_Data_Foldable_Foldable_Data_Monoid_Sum_null ;
      product__ := fun {a} `{GHC.Num.Num a} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Sum_product ;
      sum__ := fun {a} `{GHC.Num.Num a} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Sum_sum ;
      toList__ := fun {a} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Sum_toList |}.

Local Definition instance_Data_Foldable_Foldable_Data_Monoid_Dual_elem
    : forall {a}, forall `{GHC.Base.Eq_ a}, a -> Data.Monoid.Dual a -> bool :=
  fun {a} `{GHC.Base.Eq_ a} =>
    hash_compose (fun arg_249__ => arg_249__ GHC.Base.∘ getDual) _GHC.Base.==_.

Program Instance instance_Data_Foldable_Foldable_Data_Monoid_Dual : Foldable
                                                                    Data.Monoid.Dual := fun _ k =>
    k {|elem__ := fun {a} `{GHC.Base.Eq_ a} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Dual_elem ;
      fold__ := fun {m} `{GHC.Base.Monoid m} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Dual_fold ;
      foldMap__ := fun {m} {a} `{GHC.Base.Monoid m} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Dual_foldMap ;
      foldl__ := fun {b} {a} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Dual_foldl ;
      foldl'__ := fun {b} {a} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Dual_foldl' ;
      foldr__ := fun {a} {b} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Dual_foldr ;
      foldr'__ := fun {a} {b} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Dual_foldr' ;
      length__ := fun {a} => instance_Data_Foldable_Foldable_Data_Monoid_Dual_length ;
      null__ := fun {a} => instance_Data_Foldable_Foldable_Data_Monoid_Dual_null ;
      product__ := fun {a} `{GHC.Num.Num a} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Dual_product ;
      sum__ := fun {a} `{GHC.Num.Num a} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Dual_sum ;
      toList__ := fun {a} =>
        instance_Data_Foldable_Foldable_Data_Monoid_Dual_toList |}.

Local Definition instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__product {inst_a}
    : forall {a}, forall `{GHC.Num.Num a}, (GHC.Tuple.pair_type inst_a) a -> a :=
  fun {a} `{GHC.Num.Num a} =>
    hash_compose getProduct
                 (instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__foldMap
                 Data.Monoid.Mk_Product).

Local Definition instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__sum {inst_a}
    : forall {a}, forall `{GHC.Num.Num a}, (GHC.Tuple.pair_type inst_a) a -> a :=
  fun {a} `{GHC.Num.Num a} =>
    hash_compose getSum
                 (instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__foldMap
                 Data.Monoid.Mk_Sum).

Program Instance instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a_ {a}
  : Foldable (GHC.Tuple.pair_type a) := fun _ k =>
    k {|elem__ := fun {a} `{GHC.Base.Eq_ a} =>
        instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__elem ;
      fold__ := fun {m} `{GHC.Base.Monoid m} =>
        instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__fold ;
      foldMap__ := fun {m} {a} `{GHC.Base.Monoid m} =>
        instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__foldMap ;
      foldl__ := fun {b} {a} =>
        instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__foldl ;
      foldl'__ := fun {b} {a} =>
        instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__foldl' ;
      foldr__ := fun {a} {b} =>
        instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__foldr ;
      foldr'__ := fun {a} {b} =>
        instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__foldr' ;
      length__ := fun {a} =>
        instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__length ;
      null__ := fun {a} =>
        instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__null ;
      product__ := fun {a} `{GHC.Num.Num a} =>
        instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__product ;
      sum__ := fun {a} `{GHC.Num.Num a} =>
        instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__sum ;
      toList__ := fun {a} =>
        instance_Data_Foldable_Foldable__GHC_Tuple_pair_type_a__toList |}.

Local Definition instance_Data_Foldable_Foldable__Data_Either_Either_a__product {inst_a}
    : forall {a}, forall `{GHC.Num.Num a}, (Data.Either.Either inst_a) a -> a :=
  fun {a} `{GHC.Num.Num a} =>
    hash_compose getProduct
                 (instance_Data_Foldable_Foldable__Data_Either_Either_a__foldMap
                 Data.Monoid.Mk_Product).

Local Definition instance_Data_Foldable_Foldable__Data_Either_Either_a__sum {inst_a}
    : forall {a}, forall `{GHC.Num.Num a}, (Data.Either.Either inst_a) a -> a :=
  fun {a} `{GHC.Num.Num a} =>
    hash_compose getSum
                 (instance_Data_Foldable_Foldable__Data_Either_Either_a__foldMap
                 Data.Monoid.Mk_Sum).

Program Instance instance_Data_Foldable_Foldable__Data_Either_Either_a_ {a}
  : Foldable (Data.Either.Either a) := fun _ k =>
    k {|elem__ := fun {a} `{GHC.Base.Eq_ a} =>
        instance_Data_Foldable_Foldable__Data_Either_Either_a__elem ;
      fold__ := fun {m} `{GHC.Base.Monoid m} =>
        instance_Data_Foldable_Foldable__Data_Either_Either_a__fold ;
      foldMap__ := fun {m} {a} `{GHC.Base.Monoid m} =>
        instance_Data_Foldable_Foldable__Data_Either_Either_a__foldMap ;
      foldl__ := fun {b} {a} =>
        instance_Data_Foldable_Foldable__Data_Either_Either_a__foldl ;
      foldl'__ := fun {b} {a} =>
        instance_Data_Foldable_Foldable__Data_Either_Either_a__foldl' ;
      foldr__ := fun {a} {b} =>
        instance_Data_Foldable_Foldable__Data_Either_Either_a__foldr ;
      foldr'__ := fun {a} {b} =>
        instance_Data_Foldable_Foldable__Data_Either_Either_a__foldr' ;
      length__ := fun {a} =>
        instance_Data_Foldable_Foldable__Data_Either_Either_a__length ;
      null__ := fun {a} =>
        instance_Data_Foldable_Foldable__Data_Either_Either_a__null ;
      product__ := fun {a} `{GHC.Num.Num a} =>
        instance_Data_Foldable_Foldable__Data_Either_Either_a__product ;
      sum__ := fun {a} `{GHC.Num.Num a} =>
        instance_Data_Foldable_Foldable__Data_Either_Either_a__sum ;
      toList__ := fun {a} =>
        instance_Data_Foldable_Foldable__Data_Either_Either_a__toList |}.

Local Definition instance_Data_Foldable_Foldable_option_product : forall {a},
                                                                    forall `{GHC.Num.Num a}, option a -> a :=
  fun {a} `{GHC.Num.Num a} =>
    hash_compose getProduct (instance_Data_Foldable_Foldable_option_foldMap
                 Data.Monoid.Mk_Product).

Local Definition instance_Data_Foldable_Foldable_option_sum : forall {a},
                                                                forall `{GHC.Num.Num a}, option a -> a :=
  fun {a} `{GHC.Num.Num a} =>
    hash_compose getSum (instance_Data_Foldable_Foldable_option_foldMap
                 Data.Monoid.Mk_Sum).

Program Instance instance_Data_Foldable_Foldable_option : Foldable option :=
  fun _ k =>
    k {|elem__ := fun {a} `{GHC.Base.Eq_ a} =>
        instance_Data_Foldable_Foldable_option_elem ;
      fold__ := fun {m} `{GHC.Base.Monoid m} =>
        instance_Data_Foldable_Foldable_option_fold ;
      foldMap__ := fun {m} {a} `{GHC.Base.Monoid m} =>
        instance_Data_Foldable_Foldable_option_foldMap ;
      foldl__ := fun {b} {a} => instance_Data_Foldable_Foldable_option_foldl ;
      foldl'__ := fun {b} {a} => instance_Data_Foldable_Foldable_option_foldl' ;
      foldr__ := fun {a} {b} => instance_Data_Foldable_Foldable_option_foldr ;
      foldr'__ := fun {a} {b} => instance_Data_Foldable_Foldable_option_foldr' ;
      length__ := fun {a} => instance_Data_Foldable_Foldable_option_length ;
      null__ := fun {a} => instance_Data_Foldable_Foldable_option_null ;
      product__ := fun {a} `{GHC.Num.Num a} =>
        instance_Data_Foldable_Foldable_option_product ;
      sum__ := fun {a} `{GHC.Num.Num a} =>
        instance_Data_Foldable_Foldable_option_sum ;
      toList__ := fun {a} => instance_Data_Foldable_Foldable_option_toList |}.

Definition mapM_ {t} {m} {a} {b} `{Foldable t} `{GHC.Base.Monad m} : (a -> m
                                                                     b) -> t a -> m unit :=
  fun f => foldr (_GHC.Base.>>_ GHC.Base.∘ f) (GHC.Base.return_ tt).

Definition forM_ {t} {m} {a} {b} `{Foldable t} `{GHC.Base.Monad m} : t
                                                                     a -> (a -> m b) -> m unit :=
  GHC.Base.flip mapM_.

Definition notElem {t} {a} `{Foldable t} `{GHC.Base.Eq_ a} : a -> t a -> bool :=
  fun x => negb GHC.Base.∘ elem x.

Definition sequenceA_ {t} {f} {a} `{Foldable t} `{GHC.Base.Applicative f} : t (f
                                                                              a) -> f unit :=
  foldr _GHC.Base.*>_ (GHC.Base.pure tt).

Definition sequence_ {t} {m} {a} `{Foldable t} `{GHC.Base.Monad m} : t (m
                                                                       a) -> m unit :=
  foldr _GHC.Base.>>_ (GHC.Base.return_ tt).

Definition traverse_ {t} {f} {a} {b} `{Foldable t} `{GHC.Base.Applicative f}
    : (a -> f b) -> t a -> f unit :=
  fun f => foldr (_GHC.Base.*>_ GHC.Base.∘ f) (GHC.Base.pure tt).

Definition for__ {t} {f} {a} {b} `{Foldable t} `{GHC.Base.Applicative f} : t
                                                                           a -> (a -> f b) -> f unit :=
  GHC.Base.flip traverse_.

(* Unbound variables:
     None Some appEndo bool cons default_elem false getAll getAny getDual getFirst
     getProduct getSum list negb nil option pair true tt unit
     Coq.Program.Basics.compose Data.Either.Either Data.Either.Mk_Left
     Data.Either.Mk_Right Data.Either.isLeft Data.Monoid.Dual Data.Monoid.Mk_All
     Data.Monoid.Mk_Any Data.Monoid.Mk_Dual Data.Monoid.Mk_Endo Data.Monoid.Mk_First
     Data.Monoid.Mk_Product Data.Monoid.Mk_Sum Data.Monoid.Product Data.Monoid.Sum
     Data.Proxy.Proxy GHC.Base.Alternative GHC.Base.Applicative GHC.Base.Eq_
     GHC.Base.Monad GHC.Base.MonadPlus GHC.Base.Monoid GHC.Base.Ord GHC.Base.build
     GHC.Base.empty GHC.Base.flip GHC.Base.foldl GHC.Base.foldl' GHC.Base.foldr
     GHC.Base.id GHC.Base.mappend GHC.Base.mempty GHC.Base.op_z2218U__
     GHC.Base.op_zdzn__ GHC.Base.op_zeze__ GHC.Base.op_zgze__ GHC.Base.op_zgzg__
     GHC.Base.op_zgzgze__ GHC.Base.op_zlzbzg__ GHC.Base.op_zlze__ GHC.Base.op_ztzg__
     GHC.Base.pure GHC.Base.return_ GHC.List.elem GHC.List.length GHC.List.null
     GHC.List.product GHC.List.sum GHC.Num.Int GHC.Num.Num GHC.Num.op_zp__
     GHC.Prim.coerce GHC.Tuple.pair_type
*)
