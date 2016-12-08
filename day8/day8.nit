import tfa_model
import two_factor_auth_lexer

var input = args[0].to_path.read_all
var lex = new Lexer_two_factor_auth(input)
var parse = new Parser_two_factor_auth

parse.tokens.add_all lex.lex
var root = parse.parse

var literal = new TFALiteralVisitor
var screenv = new ScreenVisitor

literal.enter_visit(root)
screenv.enter_visit(root)

print screenv.screen.lit_count
