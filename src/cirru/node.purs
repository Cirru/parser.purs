module Cirru.Node
  ( CirruNode(..)
  , isCirruLeaf
  , isCirruList
  ) where

import Prelude (class Eq, class Show, show, (<>), (==))
import Data.Maybe (Maybe(..))
import Data.Ord
import Data.Array (head, slice, length)

-- | bare Cirru syntax tree consists with String and Array String recursively
data CirruNode
  = CirruLeaf String
  | CirruList (Array CirruNode)

-- | detects a leaf
isCirruLeaf :: CirruNode -> Boolean
isCirruLeaf x = case x of
  CirruLeaf _ -> true
  CirruList _ -> false

-- | detects a list
isCirruList :: CirruNode -> Boolean
isCirruList x = case x of
  CirruLeaf _ -> false
  CirruList _ -> true

instance showCirru :: Show CirruNode where
  show (CirruList xs) = "(" <> (concatNodes xs) <> ")"
    where
    concatNodes [] = ""

    concatNodes [ y ] = case y of
      CirruLeaf y1 -> y1
      CirruList y2 -> "(" <> (concatNodes y2) <> ")"

    concatNodes ys = (show (readHead (head ys))) <> " " <> (concatNodes (slice 1 (length ys) ys))

    readHead y = case y of
      Nothing -> CirruLeaf ""
      Just z -> z
  show (CirruLeaf t) = t

instance eqCirru :: Eq CirruNode where
  eq (CirruLeaf x) (CirruLeaf y) = x == y
  eq (CirruLeaf _) (CirruList _) = false
  eq (CirruList _) (CirruLeaf _) = false
  eq (CirruList xs) (CirruList ys) = xs == ys

-- | leaf < list, shorter list < longer list, than compare items
instance ordCirruNode :: Ord CirruNode where
  compare (CirruLeaf x) (CirruLeaf y) = compare x y
  compare (CirruLeaf _) (CirruList _) = LT
  compare (CirruList _) (CirruLeaf _) = GT
  compare (CirruList xs) (CirruList ys) = case compare (length xs) (length ys) of
    LT -> LT
    GT -> GT
    EQ -> compare xs ys
