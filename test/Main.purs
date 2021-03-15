module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Class.Console (log)

import Test.Unit (suite, test)
import Test.Unit.Main (runTest)
import Test.Unit.Assert as Assert

import Cirru.Node (CirruNode(..))
import Cirru.Parser (parseCirru)
import Cirru.Writer (writeCirru)

fExpr :: CirruNode
fExpr = CirruList [
          CirruList [
              (CirruLeaf "defn"),( CirruLeaf "f"),
              CirruList [CirruLeaf "a", CirruLeaf "b"],
              CirruList [CirruLeaf "+", CirruLeaf "a", CirruLeaf "b"]
            ]
          ]

fCode :: String
fCode = "\ndefn f (a b)\n  + a b\n"

fCodeInline :: String
fCodeInline = "\ndefn f (a b) (+ a b)\n"

main :: Effect Unit
main = do
  a <- pure $ fExpr
  b <- pure $ parseCirru fCode
  c <- pure $ CirruList []
  log $ show $ a
  log $ show $ b
  log $ show $ a == b

  -- log $ writeCirru fExpr { useInline: true }

  runTest do
    suite "parser" do
      test "parse demo" do
        Assert.equal a b
        Assert.equal false (a == c)
        Assert.equal fCode (writeCirru fExpr { useInline: false })
        Assert.equal fCodeInline (writeCirru fExpr { useInline: true })
