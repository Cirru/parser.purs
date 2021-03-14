module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Class.Console (log)

import Test.Unit (suite, test)
import Test.Unit.Main (runTest)
import Test.Unit.Assert as Assert

import CirruParser (parseCirru, CirruNode(..))

main :: Effect Unit
main = do
  a <- pure $ CirruList [
                CirruList [
                    (CirruLeaf "defn"),( CirruLeaf "f"),
                    CirruList [CirruLeaf "a", CirruLeaf "b"],
                    CirruList [CirruLeaf "+", CirruLeaf "a", CirruLeaf "b"]
                  ]
                ]
  b <- pure $ parseCirru "defn f (a b) (+ a b)"
  c <- pure $ CirruList []
  log $ show $ a
  log $ show $ b
  log $ show $ a == b
  runTest do
    suite "parser" do
      test "parse demo" do
        Assert.equal a b
        Assert.equal false (a == c)
