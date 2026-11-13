// CRLF-safe patch helpers for the theme XAML files.
const f = require("fs");
exports.edit = (file, fn) => {
  const raw = f.readFileSync(file, "utf8");
  const crlf = raw.includes("\r\n");
  const out = fn(raw.replace(/\r\n/g, "\n"));
  f.writeFileSync(file, crlf ? out.replace(/\n/g, "\r\n") : out);
  console.log("patched", file);
};
// replace exactly one occurrence of a, or throw
exports.rep = (s, a, b) => {
  const i = s.indexOf(a);
  if (i < 0) throw new Error("anchor not found: " + a.slice(0, 80));
  if (s.indexOf(a, i + 1) >= 0) throw new Error("anchor not unique: " + a.slice(0, 80));
  return s.slice(0, i) + b + s.slice(i + a.length);
};
// replace the span from start anchor (inclusive) to end anchor (exclusive)
exports.span = (s, a, b, repl) => {
  const i = s.indexOf(a), j = s.indexOf(b, i + 1);
  if (i < 0 || j < 0) throw new Error("span anchors not found: " + a.slice(0, 60) + " / " + b.slice(0, 60));
  return s.slice(0, i) + repl + s.slice(j);
};
