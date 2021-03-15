module Cirru.Parser where

import Cirru.Node (CirruNode(..))

foreign import parseCirruImpl :: String ->
  (String -> CirruNode) ->
  ((Array CirruNode) -> CirruNode) ->
  CirruNode

parseCirru :: String -> CirruNode
parseCirru s = parseCirruImpl s CirruLeaf CirruList
