local ls = require "luasnip"

return {}, {
  ls.parser.parse_snippet("sout", "System.out.println($1);$0"),
  ls.parser.parse_snippet("psvm", "public static void main(String[] args) {\n\t$1\n}\n$0"),
}
