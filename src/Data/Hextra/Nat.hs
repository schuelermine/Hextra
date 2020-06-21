{-# LANGUAGE ExplicitForAll #-}

module Data.Hextra.Nat (difference, Nat.N(Nat.Z, Nat.S)) where
-- Nat module that doesn't clash with Prelude
-- Only reexports functions that don't clash,
-- does not export non-clashing aliases.
-- TODO ^ Clarify
-- See Data.Nat.Internal for actual documentation.

import qualified Data.Hextra.Nat.Internal as Nat

difference :: forall n. Integral n => Nat.N -> Nat.N -> n
difference = Nat.difference