module CirruParser where

import Data.Maybe (Maybe(..))
import Prelude (class Eq, class Show, show, (<>), (==))
import Data.Array (head, slice, length)

data CirruNode = CirruLeaf String | CirruList (Array CirruNode)

foreign import parseCirruImpl :: String ->
  (String -> CirruNode) ->
  ((Array CirruNode) -> CirruNode) ->
  CirruNode

parseCirru :: String -> CirruNode
parseCirru s = parseCirruImpl s CirruLeaf CirruList

instance showCirru :: Show CirruNode where
  show (CirruList xs) = "[" <> (concatNodes xs) <> "]"
    where
      concatNodes [] = ""
      concatNodes [y] = case y of
                          CirruLeaf y1 -> y1
                          CirruList y2 -> "[" <> (concatNodes y2) <> "]"
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
