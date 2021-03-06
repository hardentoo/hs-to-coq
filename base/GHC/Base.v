(* Default settings (from HsToCoq.Coq.Preamble) *)

Generalizable All Variables.

Unset Implicit Arguments.
Set Maximal Implicit Insertion.
Unset Strict Implicit.
Unset Printing Implicit Defensive.

Require Coq.Program.Tactics.
Require Coq.Program.Wf.

(* Converted imports: *)

Require Coq.Init.Datatypes.
Require Coq.Lists.List.
Require GHC.Prim.
Require GHC.Tuple.

(* Converted type declarations: *)

Record Monoid__Dict a := Monoid__Dict_Build {
  mappend__ : a -> a -> a ;
  mconcat__ : list a -> a ;
  mempty__ : a }.

Definition Monoid a :=
  forall r, (Monoid__Dict a -> r) -> r.

Existing Class Monoid.

Definition mappend `{g : Monoid a} : a -> a -> a :=
  g _ (mappend__ a).

Definition mconcat `{g : Monoid a} : list a -> a :=
  g _ (mconcat__ a).

Definition mempty `{g : Monoid a} : a :=
  g _ (mempty__ a).

Record Functor__Dict f := Functor__Dict_Build {
  fmap__ : forall {a} {b}, (a -> b) -> f a -> f b ;
  op_zlzd____ : forall {a} {b}, a -> f b -> f a }.

Definition Functor f :=
  forall r, (Functor__Dict f -> r) -> r.

Existing Class Functor.

Definition fmap `{g : Functor f} : forall {a} {b}, (a -> b) -> f a -> f b :=
  g _ (fmap__ f).

Definition op_zlzd__ `{g : Functor f} : forall {a} {b}, a -> f b -> f a :=
  g _ (op_zlzd____ f).

Notation "'_<$_'" := (op_zlzd__).

Infix "<$" := (_<$_) (at level 99).

Record Applicative__Dict f := Applicative__Dict_Build {
  op_zlztzg____ : forall {a} {b}, f (a -> b) -> f a -> f b ;
  op_ztzg____ : forall {a} {b}, f a -> f b -> f b ;
  pure__ : forall {a}, a -> f a }.

Definition Applicative f `{Functor f} :=
  forall r, (Applicative__Dict f -> r) -> r.

Existing Class Applicative.

Definition op_zlztzg__ `{g : Applicative f}
   : forall {a} {b}, f (a -> b) -> f a -> f b :=
  g _ (op_zlztzg____ f).

Definition op_ztzg__ `{g : Applicative f} : forall {a} {b}, f a -> f b -> f b :=
  g _ (op_ztzg____ f).

Definition pure `{g : Applicative f} : forall {a}, a -> f a :=
  g _ (pure__ f).

Notation "'_<*>_'" := (op_zlztzg__).

Infix "<*>" := (_<*>_) (at level 99).

Notation "'_*>_'" := (op_ztzg__).

Infix "*>" := (_*>_) (at level 99).

Record Monad__Dict m := Monad__Dict_Build {
  op_zgzg____ : forall {a} {b}, m a -> m b -> m b ;
  op_zgzgze____ : forall {a} {b}, m a -> (a -> m b) -> m b ;
  return___ : forall {a}, a -> m a }.

Definition Monad m `{Applicative m} :=
  forall r, (Monad__Dict m -> r) -> r.

Existing Class Monad.

Definition op_zgzg__ `{g : Monad m} : forall {a} {b}, m a -> m b -> m b :=
  g _ (op_zgzg____ m).

Definition op_zgzgze__ `{g : Monad m}
   : forall {a} {b}, m a -> (a -> m b) -> m b :=
  g _ (op_zgzgze____ m).

Definition return_ `{g : Monad m} : forall {a}, a -> m a :=
  g _ (return___ m).

Notation "'_>>_'" := (op_zgzg__).

Infix ">>" := (_>>_) (at level 99).

Notation "'_>>=_'" := (op_zgzgze__).

Infix ">>=" := (_>>=_) (at level 99).

Record Alternative__Dict f := Alternative__Dict_Build {
  empty__ : forall {a}, f a ;
  many__ : forall {a}, f a -> f (list a) ;
  op_zlzbzg____ : forall {a}, f a -> f a -> f a ;
  some__ : forall {a}, f a -> f (list a) }.

Definition Alternative f `{Applicative f} :=
  forall r, (Alternative__Dict f -> r) -> r.

Existing Class Alternative.

Definition empty `{g : Alternative f} : forall {a}, f a :=
  g _ (empty__ f).

Definition many `{g : Alternative f} : forall {a}, f a -> f (list a) :=
  g _ (many__ f).

Definition op_zlzbzg__ `{g : Alternative f} : forall {a}, f a -> f a -> f a :=
  g _ (op_zlzbzg____ f).

Definition some `{g : Alternative f} : forall {a}, f a -> f (list a) :=
  g _ (some__ f).

Notation "'_<|>_'" := (op_zlzbzg__).

Infix "<|>" := (_<|>_) (at level 99).

Record MonadPlus__Dict (m : Type -> Type) := MonadPlus__Dict_Build {
  mplus__ : forall {a}, m a -> m a -> m a ;
  mzero__ : forall {a}, m a }.

Definition MonadPlus (m : Type -> Type) `{Alternative m} `{Monad m} :=
  forall r, (MonadPlus__Dict m -> r) -> r.

Existing Class MonadPlus.

Definition mplus `{g : MonadPlus m} : forall {a}, m a -> m a -> m a :=
  g _ (mplus__ m).

Definition mzero `{g : MonadPlus m} : forall {a}, m a :=
  g _ (mzero__ m).
(* Midamble *)

(* This includes everything that should be defined in GHC/Base.hs, but cannot
   be generated from Base.hs.

The types defined in GHC.Base:

  list, (), Int, Bool, Ordering, Char, String

are all mapped to corresponding Coq types. Therefore, the Eq/Ord classes must
be defined in this module so that we can create instances for these types.

 *)


(********************* Types ************************)

Require Export GHC.Prim.

Require Export GHC.Tuple.

(* List notation *)
Require Export Coq.Lists.List.

(* Booleans *)
Require Export Bool.Bool.

(* Int and Integer types *)
Require Export GHC.Num.

(* Char type *)
Require Export GHC.Char.


(* Strings *)
Require Coq.Strings.String.
Definition String := list Char.

Bind Scope string_scope with String.string.
Fixpoint hs_string__ (s : String.string) : String :=
  match s with
  | String.EmptyString => nil
  | String.String c s  => &#c :: hs_string__ s
  end.
Notation "'&' s" := (hs_string__ s) (at level 1, format "'&' s").

(* IO --- PUNT *)
Definition FilePath := String.

(* ASZ: I've been assured that this is OK *)
Inductive IO (a : Type) : Type :=.
Inductive IORef (a : Type) : Type :=.
Inductive IOError : Type :=.

(****************************************************)

(* function composition *)
Require Export Coq.Program.Basics.

Notation "[,]"  := (fun x y => (x,y)).
Notation "[,,]" := (fun x0 y1 z2 => (x0, y1, z2)).
Notation "[,,,]" := (fun x0 x1 x2 x3 => (x0,x1,x2,x3)).
Notation "[,,,,]" := (fun x0 x1 x2 x3 x4 => (x0,x1,x2,x3,x4)).
Notation "[,,,,,]" := (fun x0 x1 x2 x3 x4 x5 => (x0,x1,x2,x3,x4,x5)).
Notation "[,,,,,,]" := (fun x0 x1 x2 x3 x4 x5 x6 => (x0,x1,x2,x3,x4,x5,x6)).
Notation "[,,,,,,,]" := (fun x0 x1 x2 x3 x4 x5 x6 x7 => (x0,x1,x2,x3,x4,x5,x6,x7)).

Notation "'_++_'"   := (fun x y => x ++ y).
Notation "'_::_'"   := (fun x y => x :: y).

Notation "[->]"  := arrow.



(* Configure type argument to be maximally inserted *)
Arguments List.app {_} _ _.

(****************************************************)


Definition Synonym {A : Type} (_uniq : Type) (x : A) : A := x.
Arguments Synonym {A}%type _uniq%type x%type.

(****************************************************)

Axiom errorWithoutStackTrace : forall {A : Type}, String -> A.


(*********** built in classes Eq & Ord **********************)

(* Don't clash with Eq constructor for the comparison type. *)
Record Eq___Dict a := Eq___Dict_Build {
  op_zeze____ : (a -> (a -> bool)) ;
  op_zsze____ : (a -> (a -> bool)) }.

Definition Eq_ a := forall r, (Eq___Dict a -> r) -> r.
Existing Class Eq_.

Definition op_zeze__ {a} {g : Eq_ a} := g _ (op_zeze____ _).
Definition op_zsze__ {a} {g : Eq_ a} := g _ (op_zsze____ _).

Notation "'_/=_'" := (op_zsze__).
Infix "/=" := (op_zsze__) (no associativity, at level 70).
Notation "'_==_'" := (op_zeze__).
Infix "==" := (op_zeze__) (no associativity, at level 70).

Definition eq_default {a} (eq : a -> a -> bool) : Eq_ a :=
  fun _ k => k {|op_zeze____ := eq; op_zsze____ := fun x y => negb (eq x y) |}.

Record Ord__Dict a := Ord__Dict_Build {
  op_zl____ : a -> a -> bool ;
  op_zlze____ : a -> a -> bool ;
  op_zg____ : a -> a -> bool ;
  op_zgze____ : a -> a -> bool ;
  compare__ : a -> a -> comparison ;
  max__ : a -> a -> a ;
  min__ : a -> a -> a }.

Definition Ord a `{Eq_ a} :=
  forall r, (Ord__Dict a -> r) -> r.

Existing Class Ord.

Definition op_zl__ `{g : Ord a} : a -> a -> bool :=
  g _ (op_zl____ a).

Definition op_zlze__ `{g : Ord a} : a -> a -> bool :=
  g _ (op_zlze____ a).

Definition op_zg__ `{g : Ord a} : a -> a -> bool :=
  g _ (op_zg____ a).

Definition op_zgze__ `{g : Ord a} : a -> a -> bool :=
  g _ (op_zgze____ a).

Definition compare `{g : Ord a} : a -> a -> comparison :=
  g _ (compare__ a).

Definition max `{g : Ord a} : a -> a -> a :=
  g _ (max__ a).

Definition min `{g : Ord a} : a -> a -> a :=
  g _ (min__ a).

Notation "'_<_'" := (op_zl__).
Infix "<" := (op_zl__) (no associativity, at level 70).

Notation "'_<=_'" := (op_zlze__).
Infix "<=" := (op_zlze__) (no associativity, at level 70).

Notation "'_>_'" := (op_zg__).
Infix ">" := (op_zg__) (no associativity, at level 70).

Notation "'_>=_'" := (op_zgze__).
Infix ">=" := (op_zgze__) (no associativity, at level 70).

(*********** Eq/Ord for primitive types **************************)

Instance Eq_Int___ : Eq_ Int := fun _ k => k {|
                               op_zeze____ := fun x y => (x =? y)%Z;
                               op_zsze____ := fun x y => negb (x =? y)%Z;
                               |}.

Instance Ord_Int___ : Ord Int := fun _ k => k {|
  op_zl____   := fun x y => (x <? y)%Z;
  op_zlze____ := fun x y => (x <=? y)%Z;
  op_zg____   := fun x y => (y <? x)%Z;
  op_zgze____ := fun x y => (y <=? x)%Z;
  compare__   := Z.compare%Z ;
  max__       := Z.max%Z;
  min__       := Z.min%Z;
|}.

Instance Eq_Integer___ : Eq_ Integer := fun _ k => k {|
                               op_zeze____ := fun x y => (x =? y)%Z;
                               op_zsze____ := fun x y => negb (x =? y)%Z;
                             |}.

Instance Ord_Integer___ : Ord Integer := fun _ k => k {|
  op_zl____   := fun x y => (x <? y)%Z;
  op_zlze____ := fun x y => (x <=? y)%Z;
  op_zg____   := fun x y => (y <? x)%Z;
  op_zgze____ := fun x y => (y <=? x)%Z;
  compare__   := Z.compare%Z ;
  max__       := Z.max%Z;
  min__       := Z.min%Z;
|}.

Instance Eq_Word___ : Eq_ Word := fun _ k => k {|
                               op_zeze____ := fun x y => (x =? y)%N;
                               op_zsze____ := fun x y => negb (x =? y)%N;
                             |}.

Instance Ord_Word___ : Ord Word := fun _ k => k {|
  op_zl____   := fun x y => (x <? y)%N;
  op_zlze____ := fun x y => (x <=? y)%N;
  op_zg____   := fun x y => (y <? x)%N;
  op_zgze____ := fun x y => (y <=? x)%N;
  compare__   := N.compare%N ;
  max__       := N.max%N;
  min__       := N.min%N;
|}.

Instance Eq_Char___ : Eq_ Char := fun _ k => k {|
                               op_zeze____ := fun x y => (x =? y)%N;
                               op_zsze____ := fun x y => negb (x =? y)%N;
                             |}.

Instance Ord_Char___ : Ord Char := fun _ k => k {|
  op_zl____   := fun x y => (x <? y)%N;
  op_zlze____ := fun x y => (x <=? y)%N;
  op_zg____   := fun x y => (y <? x)%N;
  op_zgze____ := fun x y => (y <=? x)%N;
  compare__   := N.compare%N ;
  max__       := N.max%N;
  min__       := N.min%N;
|}.

Instance Eq_bool___ : Eq_ bool := fun _ k => k {|
                               op_zeze____ := eqb;
                               op_zsze____ := fun x y => negb (eqb x y);
                             |}.

Definition compare_bool (b1:bool)(b2:bool) : comparison :=
  match b1 , b2 with
  | true , true => Eq
  | false, false => Eq
  | true , false => Gt
  | false , true => Lt
  end.

Instance Ord_bool___ : Ord bool := fun _ k => k {|
  op_zl____   := fun x y => andb (negb x) y;
  op_zlze____ := fun x y => orb (negb x) y;
  op_zg____   := fun x y => orb (negb y) x;
  op_zgze____ := fun x y => andb (negb y) x;
  compare__   := compare_bool;
  max__       := orb;
  min__       := andb
|}.

Instance Eq_unit___ : Eq_ unit := fun _ k => k {|
                               op_zeze____ := fun x y => true;
                               op_zsze____ := fun x y => false;
                             |}.

Instance Ord_unit___ : Ord unit := fun _ k => k {|
  op_zl____   := fun x y => false;
  op_zlze____ := fun x y => true;
  op_zg____   := fun x y => false;
  op_zgze____ := fun x y => true;
  compare__   := fun x y => Eq ;
  max__       := fun x y => tt;
  min__       := fun x y => tt;
|}.

Definition eq_comparison (x : comparison) (y: comparison) :=
  match x , y with
  | Eq, Eq => true
  | Gt, Gt => true
  | Lt, Lt => true
  | _ , _  => false
end.

Instance Eq_comparison___ : Eq_ comparison := fun _ k => k
{|
  op_zeze____ := eq_comparison;
  op_zsze____ := fun x y => negb (eq_comparison x y);
|}.

Definition compare_comparison  (x : comparison) (y: comparison) :=
  match x , y with
  | Eq, Eq => Eq
  | _, Eq  => Gt
  | Eq, _  => Lt
  | Lt, Lt => Eq
  | _, Lt  => Lt
  | Lt, _  => Gt
  | Gt, Gt => Eq
end.

Definition ord_default {a} (comp : a -> a -> comparison) `{Eq_ a} : Ord a :=
  fun _ k => k (Ord__Dict_Build _
  (fun x y => (comp x y) == Lt)
  ( fun x y => negb ((comp y x) == Lt))
  (fun x y => (comp y x) == Lt)
  (fun x y => negb ((comp x y) == Lt))
  comp
  (fun x y =>
     match comp x y with
     | Lt => y
     | _  => x
     end)
  (fun x y =>   match comp x y with
             | Gt => y
             | _  => x
             end)).

Instance Ord_comparison___ : Ord comparison := ord_default compare_comparison.

Definition eq_pair {t1} {t2} `{Eq_ t1} `{Eq_ t2} (a b : (t1 * t2)) := 
  match a, b with
  | (a1, a2), (b1, b2) =>
    (a1 == b1) && (a2 == b2)
  end.

Definition compare_pair {t1} {t2} `{Ord t1} `{Ord t2} (a b : (t1 * t2)) :=
  match a, b with
  | (a1, a2), (b1, b2) =>
    match compare a1 b1 with
    | Lt => Lt
    | Gt => Gt
    | Eq => compare a2 b2
    end
  end.

Instance Eq_pair___ {a} {b} `{Eq_ a} `{Eq_ b} : Eq_ (a * b) := fun _ k => k
  {| op_zeze____ := eq_pair;
     op_zsze____ := fun x y => negb (eq_pair x y)
  |}.

Instance Ord_pair___ {a} {b} `{Ord a} `{Ord b} : Ord (a * b) :=
  ord_default compare_pair.

(* TODO: are these available in a library somewhere? *)
Definition eqlist {a} `{Eq_ a} : list a -> list a -> bool :=
	fix eqlist xs ys :=
	    match xs , ys with
	    | nil , nil => true
	    | x :: xs' , y :: ys' => andb (x == y) (eqlist xs' ys')
	    | _ ,  _ => false
	    end.

Fixpoint compare_list {a} `{Ord a} (xs :  list a) (ys : list a) : comparison :=
    match xs , ys with
    | nil , nil => Eq
    | nil , _   => Lt
    | _   , nil => Gt
    | x :: xs' , y :: ys' =>
      match compare x y with
          | Lt => Lt
          | Gt => Gt
          | Eq => compare_list xs' ys'
      end
    end.

Instance Eq_list {a} `{Eq_ a} : Eq_ (list a) := fun _ k => k
  {| op_zeze____ := eqlist;
     op_zsze____ := fun x y => negb (eqlist x y)
  |}.

Instance Ord_list {a} `{Ord a}: Ord (list a) :=
  ord_default compare_list.


(* ********************************************************* *)
(* Some Haskell functions we cannot translate (yet)          *)


(* The inner nil case is impossible. So it is left out of the Haskell version. *)
Fixpoint scanr {a b:Type} (f : a -> b -> b) (q0 : b) (xs : list a) : list b :=
  match xs with
  | nil => q0 :: nil
  | y :: ys => match scanr f q0 ys with
              | q :: qs =>  f y q :: (q :: qs)
              | nil => nil
              end
end.


(* The inner nil case is impossible. So it is left out of the Haskell version. *)
Fixpoint scanr1 {a :Type} (f : a -> a -> a) (q0 : a) (xs : list a) : list a :=
  match xs with
  | nil => q0 :: nil
  | y :: nil => y :: nil
  | y :: ys => match scanr1 f q0 ys with
              | q :: qs =>  f y q :: (q :: qs)
              | nil => nil
              end
end.

Definition foldl {a}{b} k z0 xs :=
  fold_right (fun (v:a) (fn:b->b) => (fun (z:b) => fn (k z v))) (id : b -> b) xs z0.

Definition foldl' {a}{b} k z0 xs :=
  fold_right (fun(v:a) (fn:b->b) => (fun(z:b) => fn (k z v))) (id : b -> b) xs z0.

(* Less general type for build *)
Definition build {a} : (forall {b}, (a -> b -> b) -> b -> b) -> list a :=
  fun g => g _ (fun x y => x :: y) nil.

(* A copy of it, to facilitate the rewrite rule in the edits file *)
Definition build' : forall {a}, (forall {b}, (a -> b -> b) -> b -> b) -> list a := @build.

(********************************************************************)

Definition oneShot {a} (x:a) := x.

(** Qualified notation for the notation defined here **)

Module ManualNotations.
Infix "GHC.Base./=" := (op_zsze__) (no associativity, at level 70).
Notation "'_GHC.Base./=_'" := (op_zsze__).
Infix "GHC.Base.==" := (op_zeze__) (no associativity, at level 70).
Notation "'_GHC.Base.==_'" := (op_zeze__).
Infix "GHC.Base.<" := (op_zl__) (no associativity, at level 70).
Notation "'_GHC.Base.<_'" := (op_zl__).
Infix "GHC.Base.<=" := (op_zlze__) (no associativity, at level 70).
Notation "'_GHC.Base.<=_'" := (op_zlze__).
Infix "GHC.Base.>" := (op_zg__) (no associativity, at level 70).
Notation "'_GHC.Base.>_'" := (op_zg__).
Infix "GHC.Base.>=" := (op_zgze__) (no associativity, at level 70).
Notation "'_GHC.Base.>=_'" := (op_zgze__).
End ManualNotations.


(* Converted value declarations: *)

Local Definition Monoid__list_mappend {inst_a}
   : list inst_a -> list inst_a -> list inst_a :=
  Coq.Init.Datatypes.app.

Local Definition Monoid__list_mconcat {inst_a}
   : list (list inst_a) -> list inst_a :=
  fun xss =>
    Coq.Lists.List.flat_map (fun xs =>
                               Coq.Lists.List.flat_map (fun x => cons x nil) xs) xss.

Local Definition Monoid__list_mempty {inst_a} : list inst_a :=
  nil.

Program Instance Monoid__list {a} : Monoid (list a) :=
  fun _ k =>
    k {| mappend__ := Monoid__list_mappend ;
         mconcat__ := Monoid__list_mconcat ;
         mempty__ := Monoid__list_mempty |}.

Local Definition Monoid__arrow_mappend {inst_b} {inst_a} `{Monoid inst_b}
   : (inst_a -> inst_b) -> (inst_a -> inst_b) -> (inst_a -> inst_b) :=
  fun f g x => mappend (f x) (g x).

Local Definition Monoid__arrow_mempty {inst_b} {inst_a} `{Monoid inst_b}
   : (inst_a -> inst_b) :=
  fun arg_0__ => mempty.

Local Definition Monoid__unit_mappend : unit -> unit -> unit :=
  fun arg_0__ arg_1__ => tt.

Local Definition Monoid__unit_mconcat : list unit -> unit :=
  fun arg_0__ => tt.

Local Definition Monoid__unit_mempty : unit :=
  tt.

Program Instance Monoid__unit : Monoid unit :=
  fun _ k =>
    k {| mappend__ := Monoid__unit_mappend ;
         mconcat__ := Monoid__unit_mconcat ;
         mempty__ := Monoid__unit_mempty |}.

(* Skipping instance Monoid__op_zt__ *)

Local Definition Monoid__op_zt____op_zt___mappend {inst_a} {inst_b} {inst_c}
  `{Monoid inst_a} `{Monoid inst_b} `{Monoid inst_c}
   : (inst_a * inst_b * inst_c)%type ->
     (inst_a * inst_b * inst_c)%type -> (inst_a * inst_b * inst_c)%type :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | pair (pair a1 b1) c1, pair (pair a2 b2) c2 =>
        pair (pair (mappend a1 a2) (mappend b1 b2)) (mappend c1 c2)
    end.

Local Definition Monoid__op_zt____op_zt___mempty {inst_a} {inst_b} {inst_c}
  `{Monoid inst_a} `{Monoid inst_b} `{Monoid inst_c}
   : (inst_a * inst_b * inst_c)%type :=
  pair (pair mempty mempty) mempty.

Local Definition Monoid__op_zt____op_zt____op_zt____23_mappend {inst_a} {inst_b}
  {inst_c} {inst_d} `{Monoid inst_a} `{Monoid inst_b} `{Monoid inst_c} `{Monoid
  inst_d}
   : (inst_a * inst_b * inst_c * inst_d)%type ->
     (inst_a * inst_b * inst_c * inst_d)%type ->
     (inst_a * inst_b * inst_c * inst_d)%type :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | pair (pair (pair a1 b1) c1) d1, pair (pair (pair a2 b2) c2) d2 =>
        pair (pair (pair (mappend a1 a2) (mappend b1 b2)) (mappend c1 c2)) (mappend d1
                                                                                    d2)
    end.

Local Definition Monoid__op_zt____op_zt____op_zt____23_mempty {inst_a} {inst_b}
  {inst_c} {inst_d} `{Monoid inst_a} `{Monoid inst_b} `{Monoid inst_c} `{Monoid
  inst_d}
   : (inst_a * inst_b * inst_c * inst_d)%type :=
  pair (pair (pair mempty mempty) mempty) mempty.

Local Definition Monoid__op_zt____op_zt____op_zt____op_zt____87_mappend {inst_a}
  {inst_b} {inst_c} {inst_d} {inst_e} `{Monoid inst_a} `{Monoid inst_b} `{Monoid
  inst_c} `{Monoid inst_d} `{Monoid inst_e}
   : (inst_a * inst_b * inst_c * inst_d * inst_e)%type ->
     (inst_a * inst_b * inst_c * inst_d * inst_e)%type ->
     (inst_a * inst_b * inst_c * inst_d * inst_e)%type :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | pair (pair (pair (pair a1 b1) c1) d1) e1
    , pair (pair (pair (pair a2 b2) c2) d2) e2 =>
        pair (pair (pair (pair (mappend a1 a2) (mappend b1 b2)) (mappend c1 c2))
                   (mappend d1 d2)) (mappend e1 e2)
    end.

Local Definition Monoid__op_zt____op_zt____op_zt____op_zt____87_mempty {inst_a}
  {inst_b} {inst_c} {inst_d} {inst_e} `{Monoid inst_a} `{Monoid inst_b} `{Monoid
  inst_c} `{Monoid inst_d} `{Monoid inst_e}
   : (inst_a * inst_b * inst_c * inst_d * inst_e)%type :=
  pair (pair (pair (pair mempty mempty) mempty) mempty) mempty.

Local Definition Monoid__comparison_mappend
   : comparison -> comparison -> comparison :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | Lt, _ => Lt
    | Eq, y => y
    | Gt, _ => Gt
    end.

Local Definition Monoid__comparison_mempty : comparison :=
  Eq.

Local Definition Monoid__option_mappend {inst_a} `{Monoid inst_a}
   : (option inst_a) -> (option inst_a) -> (option inst_a) :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | None, m => m
    | m, None => m
    | Some m1, Some m2 => Some (mappend m1 m2)
    end.

Local Definition Monoid__option_mempty {inst_a} `{Monoid inst_a}
   : (option inst_a) :=
  None.

Local Definition Applicative__pair_type_op_zlztzg__ {inst_a} `{Monoid inst_a}
   : forall {a} {b},
     (GHC.Tuple.pair_type inst_a) (a -> b) ->
     (GHC.Tuple.pair_type inst_a) a -> (GHC.Tuple.pair_type inst_a) b :=
  fun {a} {b} =>
    fun arg_0__ arg_1__ =>
      match arg_0__, arg_1__ with
      | pair u f, pair v x => pair (mappend u v) (f x)
      end.

Local Definition Applicative__pair_type_pure {inst_a} `{Monoid inst_a}
   : forall {a}, a -> (GHC.Tuple.pair_type inst_a) a :=
  fun {a} => fun x => pair mempty x.

(* Skipping instance Monoid__IO *)

Local Definition Applicative__arrow_op_zlztzg__ {inst_a}
   : forall {a} {b},
     (GHC.Prim.arrow inst_a) (a -> b) ->
     (GHC.Prim.arrow inst_a) a -> (GHC.Prim.arrow inst_a) b :=
  fun {a} {b} => fun f g x => f x (g x).

Local Definition Monad__arrow_op_zgzgze__ {inst_r}
   : forall {a} {b},
     (GHC.Prim.arrow inst_r) a ->
     (a -> (GHC.Prim.arrow inst_r) b) -> (GHC.Prim.arrow inst_r) b :=
  fun {a} {b} => fun f k => fun r => k (f r) r.

Local Definition Monad__arrow_op_zgzg__ {inst_r}
   : forall {a} {b},
     (GHC.Prim.arrow inst_r) a ->
     (GHC.Prim.arrow inst_r) b -> (GHC.Prim.arrow inst_r) b :=
  fun {a} {b} => fun m k => Monad__arrow_op_zgzgze__ m (fun arg_0__ => k).

Local Definition Functor__pair_type_fmap {inst_a}
   : forall {a} {b},
     (a -> b) -> (GHC.Tuple.pair_type inst_a) a -> (GHC.Tuple.pair_type inst_a) b :=
  fun {a} {b} =>
    fun arg_0__ arg_1__ =>
      match arg_0__, arg_1__ with
      | f, pair x y => pair x (f y)
      end.

Local Definition Functor__option_fmap
   : forall {a} {b}, (a -> b) -> option a -> option b :=
  fun {a} {b} =>
    fun arg_0__ arg_1__ =>
      match arg_0__, arg_1__ with
      | _, None => None
      | f, Some a => Some (f a)
      end.

Local Definition Applicative__option_op_ztzg__
   : forall {a} {b}, option a -> option b -> option b :=
  fun {a} {b} =>
    fun arg_0__ arg_1__ =>
      match arg_0__, arg_1__ with
      | Some _m1, m2 => m2
      | None, _m2 => None
      end.

Local Definition Applicative__option_pure : forall {a}, a -> option a :=
  fun {a} => Some.

Local Definition Monad__option_op_zgzgze__
   : forall {a} {b}, option a -> (a -> option b) -> option b :=
  fun {a} {b} =>
    fun arg_0__ arg_1__ =>
      match arg_0__, arg_1__ with
      | Some x, k => k x
      | None, _ => None
      end.

(* Skipping instance Alternative__option *)

(* Skipping instance MonadPlus__option *)

Local Definition Applicative__list_op_zlztzg__
   : forall {a} {b}, list (a -> b) -> list a -> list b :=
  fun {a} {b} =>
    fun fs xs =>
      Coq.Lists.List.flat_map (fun f =>
                                 Coq.Lists.List.flat_map (fun x => cons (f x) nil) xs) fs.

Local Definition Applicative__list_op_ztzg__
   : forall {a} {b}, list a -> list b -> list b :=
  fun {a} {b} =>
    fun xs ys =>
      Coq.Lists.List.flat_map (fun _ =>
                                 Coq.Lists.List.flat_map (fun y => cons y nil) ys) xs.

Local Definition Applicative__list_pure : forall {a}, a -> list a :=
  fun {a} => fun x => cons x nil.

Local Definition Monad__list_op_zgzgze__
   : forall {a} {b}, list a -> (a -> list b) -> list b :=
  fun {a} {b} =>
    fun xs f =>
      Coq.Lists.List.flat_map (fun x =>
                                 Coq.Lists.List.flat_map (fun y => cons y nil) (f x)) xs.

(* Skipping instance Alternative__list *)

(* Skipping instance MonadPlus__list *)

(* Skipping instance Functor__IO *)

(* Skipping instance Applicative__IO *)

(* Skipping instance Monad__IO *)

(* Skipping instance Alternative__IO *)

(* Skipping instance MonadPlus__IO *)

Local Definition Ord__option_compare {inst_a} `{Ord inst_a}
   : option inst_a -> option inst_a -> comparison :=
  fun a b =>
    match a with
    | None => match b with | None => Eq | _ => Lt end
    | Some a1 => match b with | Some b1 => (compare a1 b1) | _ => Gt end
    end.

Local Definition Ord__option_op_zg__ {inst_a} `{Ord inst_a}
   : option inst_a -> option inst_a -> bool :=
  fun a b =>
    match a with
    | None => match b with | None => false | _ => false end
    | Some a1 => match b with | Some b1 => (a1 > b1) | _ => true end
    end.

Local Definition Ord__option_op_zgze__ {inst_a} `{Ord inst_a}
   : option inst_a -> option inst_a -> bool :=
  fun a b =>
    match a with
    | None => match b with | None => true | _ => false end
    | Some a1 => match b with | Some b1 => (a1 >= b1) | _ => true end
    end.

Local Definition Ord__option_op_zl__ {inst_a} `{Ord inst_a}
   : option inst_a -> option inst_a -> bool :=
  fun a b =>
    match a with
    | None => match b with | None => false | _ => true end
    | Some a1 => match b with | Some b1 => (a1 < b1) | _ => false end
    end.

Local Definition Ord__option_op_zlze__ {inst_a} `{Ord inst_a}
   : option inst_a -> option inst_a -> bool :=
  fun a b =>
    match a with
    | None => match b with | None => true | _ => true end
    | Some a1 => match b with | Some b1 => (a1 <= b1) | _ => false end
    end.

Local Definition Ord__option_min {inst_a} `{Ord inst_a}
   : option inst_a -> option inst_a -> option inst_a :=
  fun x y => if Ord__option_op_zlze__ x y : bool then x else y.

Local Definition Ord__option_max {inst_a} `{Ord inst_a}
   : option inst_a -> option inst_a -> option inst_a :=
  fun x y => if Ord__option_op_zlze__ x y : bool then y else x.

Local Definition Eq___option_op_zeze__ {inst_a} `{Eq_ inst_a}
   : option inst_a -> option inst_a -> bool :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | None, None => true
    | Some a1, Some b1 => ((a1 == b1))
    | _, _ => false
    end.

Local Definition Eq___option_op_zsze__ {inst_a} `{Eq_ inst_a}
   : option inst_a -> option inst_a -> bool :=
  fun a b => negb (Eq___option_op_zeze__ a b).

Program Instance Eq___option {a} `{Eq_ a} : Eq_ (option a) :=
  fun _ k =>
    k {| op_zeze____ := Eq___option_op_zeze__ ;
         op_zsze____ := Eq___option_op_zsze__ |}.

Program Instance Ord__option {a} `{Ord a} : Ord (option a) :=
  fun _ k =>
    k {| op_zl____ := Ord__option_op_zl__ ;
         op_zlze____ := Ord__option_op_zlze__ ;
         op_zg____ := Ord__option_op_zg__ ;
         op_zgze____ := Ord__option_op_zgze__ ;
         compare__ := Ord__option_compare ;
         max__ := Ord__option_max ;
         min__ := Ord__option_min |}.

Definition ap {m} {a} {b} `{(Monad m)} : m (a -> b) -> m a -> m b :=
  fun m1 m2 => m1 >>= (fun x1 => m2 >>= (fun x2 => return_ (x1 x2))).

Definition assert {a} : bool -> a -> a :=
  fun _pred r => r.

Definition breakpoint {a} : a -> a :=
  fun r => r.

Definition breakpointCond {a} : bool -> a -> a :=
  fun arg_0__ arg_1__ => match arg_0__, arg_1__ with | _, r => r end.

Definition const {a} {b} : a -> b -> a :=
  fun arg_0__ arg_1__ => match arg_0__, arg_1__ with | x, _ => x end.

Definition asTypeOf {a} : a -> a -> a :=
  const.

Local Definition Applicative__arrow_pure {inst_a}
   : forall {a}, a -> (GHC.Prim.arrow inst_a) a :=
  fun {a} => const.

Definition eqString : String -> String -> bool :=
  fix eqString arg_0__ arg_1__
        := match arg_0__, arg_1__ with
           | nil, nil => true
           | cons c1 cs1, cons c2 cs2 => andb (c1 == c2) (eqString cs1 cs2)
           | _, _ => false
           end.

Definition flip {a} {b} {c} : (a -> b -> c) -> b -> a -> c :=
  fun f x y => f y x.

Definition foldr {a} {b} : (a -> b -> b) -> b -> list a -> b :=
  fun k z =>
    let fix go arg_0__
              := match arg_0__ with
                 | nil => z
                 | cons y ys => k y (go ys)
                 end in
    go.

Definition mapM {m} {a} {b} `{Monad m} : (a -> m b) -> list a -> m (list b) :=
  fun f as_ =>
    let k := fun a r => f a >>= (fun x => r >>= (fun xs => return_ (cons x xs))) in
    foldr k (return_ nil) as_.

Local Definition Monoid__option_mconcat {inst_a} `{Monoid inst_a}
   : list (option inst_a) -> (option inst_a) :=
  foldr Monoid__option_mappend Monoid__option_mempty.

Program Instance Monoid__option {a} `{Monoid a} : Monoid (option a) :=
  fun _ k =>
    k {| mappend__ := Monoid__option_mappend ;
         mconcat__ := Monoid__option_mconcat ;
         mempty__ := Monoid__option_mempty |}.

Local Definition Monoid__comparison_mconcat : list comparison -> comparison :=
  foldr Monoid__comparison_mappend Monoid__comparison_mempty.

Program Instance Monoid__comparison : Monoid comparison :=
  fun _ k =>
    k {| mappend__ := Monoid__comparison_mappend ;
         mconcat__ := Monoid__comparison_mconcat ;
         mempty__ := Monoid__comparison_mempty |}.

Local Definition Monoid__op_zt____op_zt____op_zt____op_zt____87_mconcat {inst_a}
  {inst_b} {inst_c} {inst_d} {inst_e} `{Monoid inst_a} `{Monoid inst_b} `{Monoid
  inst_c} `{Monoid inst_d} `{Monoid inst_e}
   : list (inst_a * inst_b * inst_c * inst_d * inst_e)%type ->
     (inst_a * inst_b * inst_c * inst_d * inst_e)%type :=
  foldr Monoid__op_zt____op_zt____op_zt____op_zt____87_mappend
  Monoid__op_zt____op_zt____op_zt____op_zt____87_mempty.

Program Instance Monoid__op_zt____op_zt____op_zt____op_zt____87 {a} {b} {c} {d}
  {e} `{Monoid a} `{Monoid b} `{Monoid c} `{Monoid d} `{Monoid e}
   : Monoid (a * b * c * d * e)%type :=
  fun _ k =>
    k {| mappend__ := Monoid__op_zt____op_zt____op_zt____op_zt____87_mappend ;
         mconcat__ := Monoid__op_zt____op_zt____op_zt____op_zt____87_mconcat ;
         mempty__ := Monoid__op_zt____op_zt____op_zt____op_zt____87_mempty |}.

Local Definition Monoid__op_zt____op_zt____op_zt____23_mconcat {inst_a} {inst_b}
  {inst_c} {inst_d} `{Monoid inst_a} `{Monoid inst_b} `{Monoid inst_c} `{Monoid
  inst_d}
   : list (inst_a * inst_b * inst_c * inst_d)%type ->
     (inst_a * inst_b * inst_c * inst_d)%type :=
  foldr Monoid__op_zt____op_zt____op_zt____23_mappend
  Monoid__op_zt____op_zt____op_zt____23_mempty.

Program Instance Monoid__op_zt____op_zt____op_zt____23 {a} {b} {c} {d} `{Monoid
  a} `{Monoid b} `{Monoid c} `{Monoid d}
   : Monoid (a * b * c * d)%type :=
  fun _ k =>
    k {| mappend__ := Monoid__op_zt____op_zt____op_zt____23_mappend ;
         mconcat__ := Monoid__op_zt____op_zt____op_zt____23_mconcat ;
         mempty__ := Monoid__op_zt____op_zt____op_zt____23_mempty |}.

Local Definition Monoid__op_zt____op_zt___mconcat {inst_a} {inst_b} {inst_c}
  `{Monoid inst_a} `{Monoid inst_b} `{Monoid inst_c}
   : list (inst_a * inst_b * inst_c)%type -> (inst_a * inst_b * inst_c)%type :=
  foldr Monoid__op_zt____op_zt___mappend Monoid__op_zt____op_zt___mempty.

Program Instance Monoid__op_zt____op_zt__ {a} {b} {c} `{Monoid a} `{Monoid b}
  `{Monoid c}
   : Monoid (a * b * c)%type :=
  fun _ k =>
    k {| mappend__ := Monoid__op_zt____op_zt___mappend ;
         mconcat__ := Monoid__op_zt____op_zt___mconcat ;
         mempty__ := Monoid__op_zt____op_zt___mempty |}.

Local Definition Monoid__arrow_mconcat {inst_b} {inst_a} `{Monoid inst_b}
   : list (inst_a -> inst_b) -> (inst_a -> inst_b) :=
  foldr Monoid__arrow_mappend Monoid__arrow_mempty.

Program Instance Monoid__arrow {b} {a} `{Monoid b} : Monoid (a -> b) :=
  fun _ k =>
    k {| mappend__ := Monoid__arrow_mappend ;
         mconcat__ := Monoid__arrow_mconcat ;
         mempty__ := Monoid__arrow_mempty |}.

Definition id {a} : a -> a :=
  fun x => x.

Definition join {m} {a} `{(Monad m)} : m (m a) -> m a :=
  fun x => x >>= id.

Definition sequence {m} {a} `{Monad m} : list (m a) -> m (list a) :=
  mapM id.

Definition liftA {f} {a} {b} `{Applicative f} : (a -> b) -> f a -> f b :=
  fun f a => pure f <*> a.

Definition liftA2 {f} {a} {b} {c} `{Applicative f}
   : (a -> b -> c) -> f a -> f b -> f c :=
  fun f a b => fmap f a <*> b.

Definition liftA3 {f} {a} {b} {c} {d} `{Applicative f}
   : (a -> b -> c -> d) -> f a -> f b -> f c -> f d :=
  fun f a b c => (fmap f a <*> b) <*> c.

Definition liftM {m} {a1} {r} `{(Monad m)} : (a1 -> r) -> m a1 -> m r :=
  fun f m1 => m1 >>= (fun x1 => return_ (f x1)).

Definition liftM2 {m} {a1} {a2} {r} `{(Monad m)}
   : (a1 -> a2 -> r) -> m a1 -> m a2 -> m r :=
  fun f m1 m2 => m1 >>= (fun x1 => m2 >>= (fun x2 => return_ (f x1 x2))).

Definition liftM3 {m} {a1} {a2} {a3} {r} `{(Monad m)}
   : (a1 -> a2 -> a3 -> r) -> m a1 -> m a2 -> m a3 -> m r :=
  fun f m1 m2 m3 =>
    m1 >>= (fun x1 => m2 >>= (fun x2 => m3 >>= (fun x3 => return_ (f x1 x2 x3)))).

Definition liftM4 {m} {a1} {a2} {a3} {a4} {r} `{(Monad m)}
   : (a1 -> a2 -> a3 -> a4 -> r) -> m a1 -> m a2 -> m a3 -> m a4 -> m r :=
  fun f m1 m2 m3 m4 =>
    m1 >>=
    (fun x1 =>
       m2 >>=
       (fun x2 => m3 >>= (fun x3 => m4 >>= (fun x4 => return_ (f x1 x2 x3 x4))))).

Definition liftM5 {m} {a1} {a2} {a3} {a4} {a5} {r} `{(Monad m)}
   : (a1 -> a2 -> a3 -> a4 -> a5 -> r) ->
     m a1 -> m a2 -> m a3 -> m a4 -> m a5 -> m r :=
  fun f m1 m2 m3 m4 m5 =>
    m1 >>=
    (fun x1 =>
       m2 >>=
       (fun x2 =>
          m3 >>=
          (fun x3 => m4 >>= (fun x4 => m5 >>= (fun x5 => return_ (f x1 x2 x3 x4 x5)))))).

Definition map {A B : Type} (f : A -> B) xs :=
  Coq.Lists.List.map f xs.

Local Definition Functor__list_fmap
   : forall {a} {b}, (a -> b) -> list a -> list b :=
  fun {a} {b} => map.

Definition mapFB {elt} {lst} {a}
   : (elt -> lst -> lst) -> (a -> elt) -> a -> lst -> lst :=
  fun c f => fun x ys => c (f x) ys.

Definition op_z2218U__ {b} {c} {a} : (b -> c) -> (a -> b) -> a -> c :=
  fun f g => fun x => f (g x).

Notation "'_∘_'" := (op_z2218U__).

Infix "∘" := (_∘_) (left associativity, at level 40).

Local Definition Functor__list_op_zlzd__
   : forall {a} {b}, a -> list b -> list a :=
  fun {a} {b} => Functor__list_fmap ∘ const.

Program Instance Functor__list : Functor list :=
  fun _ k =>
    k {| fmap__ := fun {a} {b} => Functor__list_fmap ;
         op_zlzd____ := fun {a} {b} => Functor__list_op_zlzd__ |}.

Program Instance Applicative__list : Applicative list :=
  fun _ k =>
    k {| op_zlztzg____ := fun {a} {b} => Applicative__list_op_zlztzg__ ;
         op_ztzg____ := fun {a} {b} => Applicative__list_op_ztzg__ ;
         pure__ := fun {a} => Applicative__list_pure |}.

Local Definition Monad__list_return_ : forall {a}, a -> list a :=
  fun {a} => pure.

Local Definition Monad__list_op_zgzg__
   : forall {a} {b}, list a -> list b -> list b :=
  fun {a} {b} => _*>_.

Program Instance Monad__list : Monad list :=
  fun _ k =>
    k {| op_zgzg____ := fun {a} {b} => Monad__list_op_zgzg__ ;
         op_zgzgze____ := fun {a} {b} => Monad__list_op_zgzgze__ ;
         return___ := fun {a} => Monad__list_return_ |}.

Local Definition Functor__option_op_zlzd__
   : forall {a} {b}, a -> option b -> option a :=
  fun {a} {b} => Functor__option_fmap ∘ const.

Program Instance Functor__option : Functor option :=
  fun _ k =>
    k {| fmap__ := fun {a} {b} => Functor__option_fmap ;
         op_zlzd____ := fun {a} {b} => Functor__option_op_zlzd__ |}.

Local Definition Applicative__option_op_zlztzg__
   : forall {a} {b}, option (a -> b) -> option a -> option b :=
  fun {a} {b} =>
    fun arg_0__ arg_1__ =>
      match arg_0__, arg_1__ with
      | Some f, m => fmap f m
      | None, _m => None
      end.

Program Instance Applicative__option : Applicative option :=
  fun _ k =>
    k {| op_zlztzg____ := fun {a} {b} => Applicative__option_op_zlztzg__ ;
         op_ztzg____ := fun {a} {b} => Applicative__option_op_ztzg__ ;
         pure__ := fun {a} => Applicative__option_pure |}.

Local Definition Monad__option_op_zgzg__
   : forall {a} {b}, option a -> option b -> option b :=
  fun {a} {b} => _*>_.

Local Definition Monad__option_return_ : forall {a}, a -> option a :=
  fun {a} => pure.

Program Instance Monad__option : Monad option :=
  fun _ k =>
    k {| op_zgzg____ := fun {a} {b} => Monad__option_op_zgzg__ ;
         op_zgzgze____ := fun {a} {b} => Monad__option_op_zgzgze__ ;
         return___ := fun {a} => Monad__option_return_ |}.

Local Definition Functor__pair_type_op_zlzd__ {inst_a}
   : forall {a} {b},
     a -> (GHC.Tuple.pair_type inst_a) b -> (GHC.Tuple.pair_type inst_a) a :=
  fun {a} {b} => Functor__pair_type_fmap ∘ const.

Program Instance Functor__pair_type {a} : Functor (GHC.Tuple.pair_type a) :=
  fun _ k =>
    k {| fmap__ := fun {a} {b} => Functor__pair_type_fmap ;
         op_zlzd____ := fun {a} {b} => Functor__pair_type_op_zlzd__ |}.

Local Definition Applicative__pair_type_op_ztzg__ {inst_a} `{Monoid inst_a}
   : forall {a} {b},
     (GHC.Tuple.pair_type inst_a) a ->
     (GHC.Tuple.pair_type inst_a) b -> (GHC.Tuple.pair_type inst_a) b :=
  fun {a} {b} => fun a1 a2 => Applicative__pair_type_op_zlztzg__ (id <$ a1) a2.

Program Instance Applicative__pair_type {a} `{Monoid a}
   : Applicative (GHC.Tuple.pair_type a) :=
  fun _ k =>
    k {| op_zlztzg____ := fun {a} {b} => Applicative__pair_type_op_zlztzg__ ;
         op_ztzg____ := fun {a} {b} => Applicative__pair_type_op_ztzg__ ;
         pure__ := fun {a} => Applicative__pair_type_pure |}.

Local Definition Monad__pair_type_return_ {inst_a} `{Monoid inst_a}
   : forall {a}, a -> (GHC.Tuple.pair_type inst_a) a :=
  fun {a} => pure.

Local Definition Monad__pair_type_op_zgzgze__ {inst_a} `{Monoid inst_a}
   : forall {a} {b},
     (GHC.Tuple.pair_type inst_a) a ->
     (a -> (GHC.Tuple.pair_type inst_a) b) -> (GHC.Tuple.pair_type inst_a) b :=
  fun {a} {b} =>
    fun arg_0__ arg_1__ =>
      match arg_0__, arg_1__ with
      | pair u a, k => let 'pair v b := k a in pair (mappend u v) b
      end.

Local Definition Monad__pair_type_op_zgzg__ {inst_a} `{Monoid inst_a}
   : forall {a} {b},
     (GHC.Tuple.pair_type inst_a) a ->
     (GHC.Tuple.pair_type inst_a) b -> (GHC.Tuple.pair_type inst_a) b :=
  fun {a} {b} => fun m k => Monad__pair_type_op_zgzgze__ m (fun arg_0__ => k).

Program Instance Monad__pair_type {a} `{Monoid a}
   : Monad (GHC.Tuple.pair_type a) :=
  fun _ k =>
    k {| op_zgzg____ := fun {a} {b} => Monad__pair_type_op_zgzg__ ;
         op_zgzgze____ := fun {a} {b} => Monad__pair_type_op_zgzgze__ ;
         return___ := fun {a} => Monad__pair_type_return_ |}.

Local Definition Functor__arrow_fmap {inst_r}
   : forall {a} {b},
     (a -> b) -> (GHC.Prim.arrow inst_r) a -> (GHC.Prim.arrow inst_r) b :=
  fun {a} {b} => _∘_.

Local Definition Functor__arrow_op_zlzd__ {inst_r}
   : forall {a} {b},
     a -> (GHC.Prim.arrow inst_r) b -> (GHC.Prim.arrow inst_r) a :=
  fun {a} {b} => Functor__arrow_fmap ∘ const.

Program Instance Functor__arrow {r} : Functor (GHC.Prim.arrow r) :=
  fun _ k =>
    k {| fmap__ := fun {a} {b} => Functor__arrow_fmap ;
         op_zlzd____ := fun {a} {b} => Functor__arrow_op_zlzd__ |}.

Local Definition Applicative__arrow_op_ztzg__ {inst_a}
   : forall {a} {b},
     (GHC.Prim.arrow inst_a) a ->
     (GHC.Prim.arrow inst_a) b -> (GHC.Prim.arrow inst_a) b :=
  fun {a} {b} => fun a1 a2 => Applicative__arrow_op_zlztzg__ (id <$ a1) a2.

Program Instance Applicative__arrow {a} : Applicative (GHC.Prim.arrow a) :=
  fun _ k =>
    k {| op_zlztzg____ := fun {a} {b} => Applicative__arrow_op_zlztzg__ ;
         op_ztzg____ := fun {a} {b} => Applicative__arrow_op_ztzg__ ;
         pure__ := fun {a} => Applicative__arrow_pure |}.

Local Definition Monad__arrow_return_ {inst_r}
   : forall {a}, a -> (GHC.Prim.arrow inst_r) a :=
  fun {a} => pure.

Program Instance Monad__arrow {r} : Monad (GHC.Prim.arrow r) :=
  fun _ k =>
    k {| op_zgzg____ := fun {a} {b} => Monad__arrow_op_zgzg__ ;
         op_zgzgze____ := fun {a} {b} => Monad__arrow_op_zgzgze__ ;
         return___ := fun {a} => Monad__arrow_return_ |}.

Definition op_zd__ {a} {b} : (a -> b) -> a -> b :=
  fun f x => f x.

Notation "'_$_'" := (op_zd__).

Infix "$" := (_$_) (at level 99).

Definition op_zlztztzg__ {f} {a} {b} `{Applicative f}
   : f a -> f (a -> b) -> f b :=
  liftA2 (flip _$_).

Notation "'_<**>_'" := (op_zlztztzg__).

Infix "<**>" := (_<**>_) (at level 99).

Definition op_zdzn__ {a} {b} : (a -> b) -> a -> b :=
  fun f x => let 'vx := x in f vx.

Notation "'_$!_'" := (op_zdzn__).

Infix "$!" := (_$!_) (at level 99).

Definition op_zezlzl__ {m} {a} {b} `{Monad m} : (a -> m b) -> m a -> m b :=
  fun f x => x >>= f.

Notation "'_=<<_'" := (op_zezlzl__).

Infix "=<<" := (_=<<_) (at level 99).

Definition otherwise : bool :=
  true.

Definition when {f} `{(Applicative f)} : bool -> f unit -> f unit :=
  fun p s => if p : bool then s else pure tt.

Module Notations.
Export ManualNotations.
Notation "'_GHC.Base.<$_'" := (op_zlzd__).
Infix "GHC.Base.<$" := (_<$_) (at level 99).
Notation "'_GHC.Base.<*>_'" := (op_zlztzg__).
Infix "GHC.Base.<*>" := (_<*>_) (at level 99).
Notation "'_GHC.Base.*>_'" := (op_ztzg__).
Infix "GHC.Base.*>" := (_*>_) (at level 99).
Notation "'_GHC.Base.>>_'" := (op_zgzg__).
Infix "GHC.Base.>>" := (_>>_) (at level 99).
Notation "'_GHC.Base.>>=_'" := (op_zgzgze__).
Infix "GHC.Base.>>=" := (_>>=_) (at level 99).
Notation "'_GHC.Base.<|>_'" := (op_zlzbzg__).
Infix "GHC.Base.<|>" := (_<|>_) (at level 99).
Notation "'_GHC.Base.∘_'" := (op_z2218U__).
Infix "GHC.Base.∘" := (_∘_) (left associativity, at level 40).
Notation "'_GHC.Base.$_'" := (op_zd__).
Infix "GHC.Base.$" := (_$_) (at level 99).
Notation "'_GHC.Base.<**>_'" := (op_zlztztzg__).
Infix "GHC.Base.<**>" := (_<**>_) (at level 99).
Notation "'_GHC.Base.$!_'" := (op_zdzn__).
Infix "GHC.Base.$!" := (_$!_) (at level 99).
Notation "'_GHC.Base.=<<_'" := (op_zezlzl__).
Infix "GHC.Base.=<<" := (_=<<_) (at level 99).
End Notations.

(* Unbound variables:
     Eq Eq_ Gt Lt None Ord Some String Type andb bool compare comparison cons false
     list negb nil op_zeze__ op_zg__ op_zgze__ op_zl__ op_zlze__ op_zt__ option pair
     true tt unit Coq.Init.Datatypes.app Coq.Lists.List.flat_map Coq.Lists.List.map
     GHC.Prim.arrow GHC.Tuple.pair_type
*)
