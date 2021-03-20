

module Cirru.Writer where

import Data.Functor (map)

import Cirru.Node (CirruNode(..))

newtype FatNode = FatNode { isList :: Boolean, leaf :: String , list :: (Array FatNode) }

-- works, but with some extra performance cost of extra objects of transformation
transformFat :: CirruNode -> FatNode
transformFat (CirruLeaf t) = FatNode { isList: false, leaf: t, list: [] }
transformFat (CirruList xs) = FatNode { isList: true, leaf: "", list: (map transformFat xs) }

-- | via npm package @cirru/writer.ts
foreign import writeCirruFatImpl :: FatNode -> { useInline :: Boolean} -> String

-- | writes CirruNode back to string with npm package
-- | `useInline` option controls some simple inline expression to be inline
-- | also notice that the top levels requires to be `[[a...], [b...]]`, strings are invalid
writeCirru :: CirruNode -> { useInline :: Boolean } -> String
writeCirru nodes options = writeCirruFatImpl (transformFat nodes) options
