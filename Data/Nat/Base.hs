{-# LANGUAGE NoImplicitPrelude #-}

module Data.Nat.Base (N(Z, S), (+), (*), (-), toInteger, fromInteger, quotRem, quot, rem, zero, one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve) where
-- Defines natural numbers and operations on them

import qualified Prelude as Base
import Extra.Function
import Extra.Tuple
import qualified Extra.Num as Num

data N = Z | S N
-- Inductive natural number type
-- Z is 0, S is the successor function
-- S is equivalent to (+ 1)

(+) :: N -> N -> N
Z     + y = y
(S x) + y = S (x + y)
-- Addition of natural numbers
-- Zero is the identity, and therefore, a base case
-- Otherwise recursively peel away S layers from argument, apply (+) again, and apply S on the whole

(*) :: N -> N -> N
Z     * _ = Z
(S x) * y = (x * y) + y
-- Multiplication of natural numbers
-- Explanation 1:
--  Zero is an annihilator, and therefore, a base case
--  Otherwise recursively peel away S layers from one argument,
--  apply (*) again, and apply (+) with the untouched argument on the whole
--  annihilator = element which is always returned by the operation (in this case (*))
-- This works because multiplication is iterated addition
-- Explanation 2:
--  This is an implementation of iterated addition
--  Whenver one is removed from argument 1, argument 2 is added to the actual value,
--  so argument 2 is added argument 1 times to the actual value,
--  and since the base case for the recursion is always zero, the result is argument 1 times argument 2

(-) :: N -> N -> N
Z     - y     = y
(S x) - (S y) = x - y
-- Difference between two natural numbers
-- This exploit the fact that,
-- if you add something to two numbers, the difference stays the same
-- Peels away a layer of S on both arguments and then apllies itself again

min :: N -> N -> N
min Z _         = Z
min _ Z         = Z
min (S x) (S y) = S (min x y)
-- Finding the smallest of two natural numbers.
-- Zero is smaller than any other natural number, this is the recursion base case
-- When subtracting one, you don't change which number is the smallest,
-- so you just need to add one.

max :: N -> N -> N
max Z y         = y
max x Z         = x
max (S x) (S y) = S (max x y)
-- Finding the largest of two natural numbers.
-- Any other natural number is larger than zero, this is the recursion base case
-- When subtracting one, you don't change which number is the largest,
-- so you just need to add one.

toInteger :: N -> Base.Integer
toInteger Z     = 0
toInteger (S n) = 1 Base.+ toInteger n
-- Converts natural numbers to integers
-- Z converts to zero, and S converts to +1

fromInteger :: Base.Integer -> N
fromInteger n = case Base.compare 0 n of
    Base.GT -> S (fromInteger (n Base.+ 1))
    Base.EQ -> Z
    Base.LT -> S (fromInteger (n Base.- 1))
-- Converts integers to natural numbers
-- Reduces value towards 0 while applying S
-- Negative integers don't raise errors, but are treated like their positive counterparts.

quotRem :: N -> N -> (N, N)
quotRem = mapAll fromInteger .> Base.quotRem <. toInteger
-- Division and Modulo of natural numbers
-- This just converts them to integers, divides, and converts back
-- (<.) and (.>) are functions for composing two-argument and one-argument functions

quot = Base.fst .> quotRem
rem = Base.snd .> quotRem
-- Division and Modulo of natural numbers, but individually
-- Just extracts the first and second elemts of the result of quotRem

subtract :: Base.Integral n => N -> N -> n
subtract = (Base.-) <. toIntegral
-- Subtraction of two natural numbers. The result is not necessarily a natural number
-- For example, 7 - 21 = (-14), which isn't a natural number,
-- hence a type including an integral

-- Named numbers (up to 12):

zero = Z

one = S Z -- One (Zero + 1)

two = S one

three = S two

four = S three

five = S four

six = S five

seven = S six

eight = S seven

nine = S eight

ten = S nine

eleven = S ten

twelve = S eleven