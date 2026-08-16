; Highlight import statement bindings and their braces distinctly.
; `after/` queries are additive and run last, so these win over the bundled ones.

(import_statement
  (import_clause
    (named_imports
      "{" @jsx.import.brace
      "}" @jsx.import.brace)))

(import_statement
  (import_clause
    (named_imports
      (import_specifier
        name: (identifier) @jsx.import.name))))

(import_statement
  (import_clause
    (named_imports
      (import_specifier
        alias: (identifier) @jsx.import.name))))

(import_statement
  (import_clause
    (identifier) @jsx.import.name))

(import_statement
  (import_clause
    (namespace_import
      (identifier) @jsx.import.name)))
