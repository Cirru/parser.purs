
Cirru Parser for PureScript
---

### Usages

This module is based on ts version of code:

```bash
yarn add @cirru/parser.ts @cirru/writer.ts
```

_TODO_ install the module `purescript-cirru-parser`...

```purs
import Cirru.Node (CirruNode(...))
import Cirru.Parser (parseCirru)
import Cirru.Writer (writeCirru)

parseCirru "demo"

- CirruList [CirruList [CirruLeaf "demo"]]

writeCirru nodes { useInline: false }
```

### License

MIT
