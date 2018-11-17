{-# LANGUAGE CPP #-}
{-# LANGUAGE FlexibleContexts #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module Test.QuickCheck.Instances.UUID () where

import Prelude ()
import Prelude.Compat

import Data.Word (Word32)

import System.Random
import Test.QuickCheck
import Test.QuickCheck.Gen

import qualified Data.UUID.Types as UUID

-------------------------------------------------------------------------------
-- uuid
-------------------------------------------------------------------------------

uuidFromWords :: (Word32, Word32, Word32, Word32) -> UUID.UUID
uuidFromWords (a,b,c,d) = UUID.fromWords a b c d

-- | Uniform distribution.
instance Arbitrary UUID.UUID where
    arbitrary = MkGen $ \gen _ -> fst (random gen)


instance CoArbitrary UUID.UUID where
    coarbitrary = coarbitrary . UUID.toWords

instance Function UUID.UUID where
    function = functionMap UUID.toWords uuidFromWords
