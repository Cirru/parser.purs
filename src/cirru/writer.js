let writer = require("@cirru/writer.ts");

let transformNodes = (xs) => {
  if (xs.isList) {
    return xs.list.map(transformNodes)
  } else {
    return xs.leaf
  }
}

exports.writeCirruFatImpl = (xs) => (options) => {
  let ys = transformNodes(xs)
  return writer.writeCirruCode(ys, options)
}