let writer = require("@cirru/writer.ts");

let transformNodes = (xs, leafCtor, listCtor) => {
  if (xs instanceof leafCtor) {
    // dirty solution to use `.value0`
    return xs.value0;
  }
  if (xs instanceof listCtor) {
    return xs.value0.map((x) => transformNodes(x, leafCtor, listCtor));
  }

  console.log("Unexpected node:", xs);
  throw new Error("Unexpected node");
};

exports.writeCirruImpl = (xs) => (options) => (leafCreate) => (listCreate) => {
  // dirty way of detecting type
  let leafCtor = leafCreate(null).constructor;
  let listCtor = listCreate(null).constructor;

  let ys = transformNodes(xs, leafCtor, listCtor);
  return writer.writeCirruCode(ys, options);
};
