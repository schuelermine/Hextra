{-# LANUAGE ExplicitForAll #-}

module Extra.Num where

import Extra.Function as Fun

(<->) :: forall n. (Num n) => n -> n -> n
(<->) = abs .> (-)
-- Absolute difference of Nums