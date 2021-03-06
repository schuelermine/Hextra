{-# LANGUAGE NoMonomorphismRestriction, ExplicitForAll #-}

module Hextra.Conditional where

import Hextra.Function

if' a b c = if a then b else c
($?) = uncurry3' if'

wrapunwrap :: forall a b. (a -> b, b -> a) -> (b -> b) -> a -> a
wrapunwrap (wrap, unwrap) f = unwrap . f . wrap

symmetrical :: forall a b. (a -> b) -> (a -> b -> Bool) -> a -> Bool
symmetrical f g a = g a (f a)

replace :: forall a. Eq a => a -> a -> a -> a
replace a b = applyIf (== a) (const b)

applyIf :: forall a. (a -> Bool) -> (a -> a) -> a -> a
applyIf p f = applyEither p f id

applyEither :: forall a b. (a -> Bool) -> (a -> b) -> (a -> b) -> a -> b
applyEither p f g a
    | p a = f a
    | True = g a

ifCondition :: forall a b. (a -> Bool) -> b -> b -> a -> b
ifCondition p a b x
    | p x = a
    | True = b

-- TODO Think about implementing this as applyEither p (const a) (const b)