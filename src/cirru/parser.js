let parser = require("@cirru/parser.ts");

let transformType = (x, leafCtor, listCtor) => {
  if (typeof x === "string") {
    return leafCtor(x);
  }
  if (Array.isArray(x)) {
    return listCtor(x.map((y) => transformType(y, leafCtor, listCtor)));
  }
  throw new Error("Unknown data for transformation");
};

exports.parseCirruImpl = (content) => (leafCtor) => (listCtor) => {
  return transformType(parser.parse(content), leafCtor, listCtor);
};
