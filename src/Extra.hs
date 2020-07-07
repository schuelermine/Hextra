{-# LANGUAGE NoMonomorphismRestriction, ExplicitForAll #-}

module Extra where

import Extra.Function

(%) :: forall i. Integral i => i -> i -> i
(%) = mod

if' a b c = if a then b else c

(#) = elem
($?) = uncurry3' if'
(!) = seq
(§) = uncurry
(<=>) = compare
(?+) = max
(?-) = min

wrapunwrap :: (a -> b, b -> a) -> (b -> b) -> a -> a
wrapunwrap (wrap, unwrap) f = unwrap . f . wrap

symmetrical :: (a -> b) -> (a -> b -> Bool) -> a -> Bool
symmetrical f g a = g a (f a)

replace :: Eq a => a -> a -> a -> a
replace a b = applyIf (== a) (const b)

applyIf :: (a -> Bool) -> (a -> a) -> a -> a
applyIf p f = applyEither p f id

applyEither :: (a -> Bool) -> (a -> b) -> (a -> b) -> a -> b
applyEither p f g a
    | p a = f a
    | True = g a

ifCondition :: (a -> Bool) -> b -> b -> a -> b
ifCondition p a b x
    | p x = a
    | True = b

-- TODO Think about implementing this as applyEither p (const a) (const b)