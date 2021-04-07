module Cirru.Parser
  ( parseCirru
  ) where

import Cirru.Node (CirruNode(..))

-- | exported from npm package @cirru/parser.ts
foreign import parseCirruImpl ::
  String ->
  (String -> CirruNode) ->
  ((Array CirruNode) -> CirruNode) ->
  CirruNode

-- | parse Cirru text into CirruNode with npm package @cirru/parser.ts .
-- | it will throw rather than return Left since js version uses error
parseCirru :: String -> CirruNode
parseCirru s = parseCirruImpl s CirruLeaf CirruList
