{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "cirru-parser"
, dependencies =
  [ "arrays", "console", "effect", "lists", "psci-support", "test-unit" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
, license = "MIT"
, repository = "https://github.com/Cirru/parser.purs"
}
