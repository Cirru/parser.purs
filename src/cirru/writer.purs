

module Cirru.Writer where

import Data.Functor (map)

import Cirru.Node (CirruNode(..))

newtype FatNode = FatNode { isList :: Boolean, leaf :: String , list :: (Array FatNode) }

-- works, but with some extra performance cost of extra objects of transformation
transformFat :: CirruNode -> FatNode
transformFat (CirruLeaf t) = FatNode { isList: false, leaf: t, list: [] }
transformFat (CirruList xs) = FatNode { isList: true, leaf: "", list: (map transformFat xs) }

foreign import writeCirruFatImpl :: FatNode -> { useInline :: Boolean} -> String

writeCirru :: CirruNode -> { useInline :: Boolean } -> String
writeCirru nodes options = writeCirruFatImpl (transformFat nodes) options
