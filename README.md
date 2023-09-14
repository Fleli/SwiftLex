# SwiftLex

SwiftLex is a lexical analyzer generator written for and in Swift. It produces a maximal munch lexer from a specification that contains token types and corresponding regular expressions. It writes the resulting lexer to a file. The lexer yields an array of `Token` instances. The `Token` struct is automatically added to the lexer file. Each token has a `type` and some `content`. 

## How do I use SwiftLex?

To use SwiftLex, add the package to your project. Then import the package in a file of your choice, and call `SwiftLex.generateLexer(specification:path:name:)`. It expects three arguments: A _SwiftLex_ specification (see below for format), and a path and a filename for the generated file. All these are `String`s. Optionally, a fourth argument `print: Bool` can be passed if you want to allow or disallow that SwiftLex prints to the console, which it does by default.

## Input

Each line should contain one _token definition_. A token definition contains a token type followed by `:` and then the matching regex. Certain attributes might precede the token type if needed.

The token's `type` is designed to be easy to use with a parser, for example [SwiftSLR](https://github.com/Fleli/SwiftSLR). The token's `content` contains the actual text that matched the regex (RHS).

An example specification matching identifiers, integers and control symbols is the following:

```
identifier      :       [a-zA-Z_][a-zA-Z0-9_]*
integer         :       [0-9]*
@self control   :       [:;.,{}\\[\\]()]
```

Note that `@self` is used for control symbols: This attribute tells SwiftLex that the token's type should be equal to its content, instead of `control`. 

In addition to `@self`, the `@discard` attribute is useful for certain applications. It tells SwiftLex to match a token, but discard it from the returned array.

If some sequence of characters is matched by two or more tokens, the user might want to return one over the other. SwiftLex of course prefers the longest possible token (it uses maximal munch), but chooses the _first_ if several matches are found. Therefore, the preferred token types should be written first in the specification.

## Output

SwiftLex uses the specification to produce a lexer. This lexer is written to a file so that it can be used by other programs. The lexer produced by SwiftLex is table-driven.

## Architecture

Lexer generation by SwiftLex is a 7-step process. Steps 2-6 are done for each `TokenSpecification` returned in step 1. The resulting array of `Table` from steps 2-6 are used by the (many) assembler functions to build the resulting lexer.

 Step   | Input                     | Output                    | Description 
--------|---------------------------|---------------------------|--------------------------------------------------------
1       | `String`                  | `[TokenSpecification]`    | Split each line to find attributes, types and regexes
2       | `TokenSpecification`      | `TokenList`               | The regex is lexed
3       | `TokenList`               | `Regex`                   | The regex is parser
4       | `Regex`                   | `NFA`                     | An NFA is generated from the regex (Thompson's construction)
5       | `NFA`                     | `DFA`                     | The NFA is converted to a DFA (Subset construction)
6       | `DFA`                     | `Table`                   | The DFA is converted to a table.
7       | `[Table]`                 | `String`                  | Tables are used to generate a lexer. The lexer is written to a file.
