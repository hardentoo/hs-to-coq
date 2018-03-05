Generalizable All Variables.

Unset Implicit Arguments.
Set Maximal Implicit Insertion.
Unset Strict Implicit.
Unset Printing Implicit Defensive.

Require Coq.Program.Tactics.
Require Coq.Program.Wf.

(* Preamble *)

Require GHC.Base.
Require GHC.Enum.
Require Import Data.Set.Internal.
Require Import mathcomp.ssreflect.ssreflect.

Extraction Blacklist Prelude.
Extraction Language Haskell.

(*
 Warning: The following axioms must be realized in the extracted
 code: patternFailure PtrEquality.ptrEq PtrEquality.hetPtrEq
       Base.errorWithoutStackTrace unsafeFix.
*)
Extract Inductive bool => "Prelude.Bool" ["Prelude.True" "Prelude.False" ].
Extract Inductive comparison => 
"Prelude.Ordering" ["Prelude.EQ" "Prelude.LT" "Prelude.GT"].

Extract Constant patternFailure => "GHC.Base.undefined".
Extract Constant PtrEquality.ptrEq => "\ x y -> Prelude.False".
Extract Constant PtrEquality.hetPtrEq => "\ x y -> Prelude.False".
Extract Constant Base.errorWithoutStackTrace => "errorWithoutStackTrace".
Extract Constant unsafeFix => "unsafeFix".

Recursive Extraction Library Internal.