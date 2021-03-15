

module Cirru.Writer where

import Cirru.Node (CirruNode(..))

foreign import writeCirruImpl ::
  CirruNode ->
  { useInline :: Boolean} ->
  (String -> CirruNode) ->
  (Array CirruNode -> CirruNode) ->
  String

writeCirru :: CirruNode -> { useInline :: Boolean } -> String
writeCirru nodes options = writeCirruImpl nodes options CirruLeaf CirruList
