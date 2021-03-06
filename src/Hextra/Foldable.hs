{-# LANGUAGE ExplicitForAll #-}

module Hextra.Foldable where

safeFoldr1 :: forall f a. Foldable f => (a -> a -> a) -> f a -> Maybe a
safeFoldr1 f = foldr q Nothing where
    q x Nothing = Just x
    q x (Just y) = Just $ f x y

safeMaximum :: forall f a. (Foldable f, Ord a) => f a -> Maybe a
safeMaximum = safeFoldr1 max
safeMinimum :: forall f a. (Foldable f, Ord a) => f a -> Maybe a
safeMinimum = safeFoldr1 min