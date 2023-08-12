//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

public let STMT_NODES: [Node] = [
  // availability-condition -> '#available' '(' availability-spec ')'
  Node(
    kind: .availabilityCondition,
    base: .syntax,
    nameForDiagnostics: "availability condition",
    children: [
      Child(
        name: "availabilityKeyword",
        kind: .token(choices: [.token(.poundAvailable), .token(.poundUnavailable)])
      ),
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)])
      ),
      Child(
        name: "availabilityArguments",
        deprecatedName: "availabilitySpec",
        kind: .collection(kind: .availabilityArgumentList, collectionElementName: "AvailabilityArgument")
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)])
      ),
    ]
  ),

  // break-stmt -> 'break' identifier? ';'?
  Node(
    kind: .breakStmt,
    base: .stmt,
    nameForDiagnostics: "'break' statement",
    children: [
      Child(
        name: "breakKeyword",
        kind: .token(choices: [.keyword(text: "break")], requiresTrailingSpace: false)
      ),
      Child(
        name: "label",
        kind: .token(choices: [.token(.identifier)]),
        nameForDiagnostics: "label",
        isOptional: true
      ),
    ]
  ),

  // case-item-list -> case-item case-item-list?
  Node(
    kind: .switchCaseItemList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.switchCaseItem]
  ),

  // catch-clause-list -> catch-clause catch-clause-list?
  Node(
    kind: .catchClauseList,
    base: .syntaxCollection,
    nameForDiagnostics: "'catch' clause",
    elementChoices: [.catchClause]
  ),

  // catch-clause 'catch' case-item-list? code-block
  Node(
    kind: .catchClause,
    base: .syntax,
    nameForDiagnostics: "'catch' clause",
    parserFunction: "parseCatchClause",
    traits: ["WithCodeBlock"],
    children: [
      Child(
        name: "catchKeyword",
        kind: .token(choices: [.keyword(text: "catch")])
      ),
      Child(
        name: "catchItems",
        kind: .collection(kind: .catchItemList, collectionElementName: "CatchItem", defaultsToEmpty: true)
      ),
      Child(
        name: "body",
        kind: .node(kind: .codeBlock)
      ),
    ]
  ),

  // catch-item-list -> catch-item catch-item-list?
  Node(
    kind: .catchItemList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.catchItem]
  ),

  // catch-item -> pattern? where-clause? ','?
  Node(
    kind: .catchItem,
    base: .syntax,
    nameForDiagnostics: nil,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "pattern",
        kind: .node(kind: .pattern),
        isOptional: true
      ),
      Child(
        name: "whereClause",
        kind: .node(kind: .whereClause),
        isOptional: true
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  // condition-list -> condition
  //                 | condition ','? condition-list
  Node(
    kind: .conditionElementList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.conditionElement]
  ),

  // condition -> expression
  //            | availability-condition
  //            | case-condition
  //            | optional-binding-condition
  Node(
    kind: .conditionElement,
    base: .syntax,
    nameForDiagnostics: nil,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "condition",
        kind: .nodeChoices(choices: [
          Child(
            name: "expression",
            kind: .node(kind: .expr)
          ),
          Child(
            name: "availability",
            kind: .node(kind: .availabilityCondition)
          ),
          Child(
            name: "matchingPattern",
            kind: .node(kind: .matchingPatternCondition)
          ),
          Child(
            name: "optionalBinding",
            kind: .node(kind: .optionalBindingCondition)
          ),
        ])
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  // continue-stmt -> 'continue' label? ';'?
  Node(
    kind: .continueStmt,
    base: .stmt,
    nameForDiagnostics: "'continue' statement",
    children: [
      Child(
        name: "continueKeyword",
        kind: .token(choices: [.keyword(text: "continue")])
      ),
      Child(
        name: "label",
        kind: .token(choices: [.token(.identifier)]),
        nameForDiagnostics: "label",
        isOptional: true
      ),
    ]
  ),

  // defer-stmt -> 'defer' code-block ';'?
  Node(
    kind: .deferStmt,
    base: .stmt,
    nameForDiagnostics: "'defer' statement",
    traits: [
      "WithCodeBlock"
    ],
    children: [
      Child(
        name: "deferKeyword",
        kind: .token(choices: [.keyword(text: "defer")])
      ),
      Child(
        name: "body",
        kind: .node(kind: .codeBlock)
      ),
    ]
  ),

  // do-stmt -> identifier? ':'? 'do' code-block catch-clause-list ';'?
  Node(
    kind: .doStmt,
    base: .stmt,
    nameForDiagnostics: "'do' statement",
    traits: [
      "WithCodeBlock"
    ],
    children: [
      Child(
        name: "doKeyword",
        kind: .token(choices: [.keyword(text: "do")])
      ),
      Child(
        name: "body",
        kind: .node(kind: .codeBlock),
        nameForDiagnostics: "body"
      ),
      Child(
        name: "catchClauses",
        kind: .collection(kind: .catchClauseList, collectionElementName: "CatchClause", defaultsToEmpty: true)
      ),
    ]
  ),

  // expr-stmt -> expression ';'?
  Node(
    kind: .expressionStmt,
    base: .stmt,
    nameForDiagnostics: "expression",
    children: [
      Child(
        name: "expression",
        kind: .node(kind: .expr)
      )
    ]
  ),

  // fallthrough-stmt -> 'fallthrough' ';'?
  Node(
    kind: .fallThroughStmt,
    base: .stmt,
    nameForDiagnostics: "'fallthrough' statement",
    children: [
      Child(
        name: "fallthroughKeyword",
        kind: .token(choices: [.keyword(text: "fallthrough")])
      )
    ]
  ),

  // for-in-stmt -> label? ':'?
  //   'for' 'try'? 'await'? 'case'? pattern 'in' expr 'where'?
  //   expr code-block ';'?
  Node(
    kind: .forStmt,
    base: .stmt,
    nameForDiagnostics: "'for' statement",
    traits: [
      "WithCodeBlock"
    ],
    children: [
      Child(
        name: "forKeyword",
        kind: .token(choices: [.keyword(text: "for")])
      ),
      Child(
        name: "tryKeyword",
        kind: .token(choices: [.keyword(text: "try")]),
        isOptional: true
      ),
      Child(
        name: "awaitKeyword",
        kind: .token(choices: [.keyword(text: "await")]),
        isOptional: true
      ),
      Child(
        name: "caseKeyword",
        kind: .token(choices: [.keyword(text: "case")]),
        isOptional: true
      ),
      Child(
        name: "pattern",
        kind: .node(kind: .pattern)
      ),
      Child(
        name: "typeAnnotation",
        kind: .node(kind: .typeAnnotation),
        isOptional: true
      ),
      Child(
        name: "inKeyword",
        kind: .token(choices: [.keyword(text: "in")])
      ),
      Child(
        name: "sequence",
        deprecatedName: "sequenceExpr",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "whereClause",
        kind: .node(kind: .whereClause),
        isOptional: true
      ),
      Child(
        name: "body",
        kind: .node(kind: .codeBlock),
        nameForDiagnostics: "body"
      ),
    ]
  ),

  // discard-stmt -> 'discard' expr ';'?
  Node(
    kind: .discardStmt,
    base: .stmt,
    nameForDiagnostics: "'discard' statement",
    children: [
      Child(
        name: "discardKeyword",
        kind: .token(choices: [.keyword(text: "discard")])
      ),
      Child(
        name: "expression",
        kind: .node(kind: .expr)
      ),
    ]
  ),

  // guard-stmt -> 'guard' condition-list 'else' code-block ';'?
  Node(
    kind: .guardStmt,
    base: .stmt,
    nameForDiagnostics: "'guard' statement",
    traits: [
      "WithCodeBlock"
    ],
    children: [
      Child(
        name: "guardKeyword",
        kind: .token(choices: [.keyword(text: "guard")])
      ),
      Child(
        name: "conditions",
        kind: .collection(kind: .conditionElementList, collectionElementName: "Condition"),
        nameForDiagnostics: "condition"
      ),
      Child(
        name: "elseKeyword",
        kind: .token(choices: [.keyword(text: "else")])
      ),
      Child(
        name: "body",
        kind: .node(kind: .codeBlock),
        nameForDiagnostics: "body"
      ),
    ]
  ),

  // labeled-stmt -> label ':' stmt
  Node(
    kind: .labeledStmt,
    base: .stmt,
    nameForDiagnostics: "labeled statement",
    children: [
      Child(
        name: "label",
        deprecatedName: "labelName",
        kind: .token(choices: [.token(.identifier)]),
        nameForDiagnostics: "label name"
      ),
      Child(
        name: "colon",
        deprecatedName: "labelColon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "statement",
        kind: .node(kind: .stmt)
      ),
    ]
  ),

  Node(
    kind: .matchingPatternCondition,
    base: .syntax,
    nameForDiagnostics: "pattern matching",
    children: [
      Child(
        name: "caseKeyword",
        kind: .token(choices: [.keyword(text: "case")])
      ),
      Child(
        name: "pattern",
        kind: .node(kind: .pattern)
      ),
      Child(
        name: "typeAnnotation",
        kind: .node(kind: .typeAnnotation),
        isOptional: true
      ),
      Child(
        name: "initializer",
        kind: .node(kind: .initializerClause)
      ),
    ]
  ),

  Node(
    kind: .optionalBindingCondition,
    base: .syntax,
    nameForDiagnostics: "optional binding",
    children: [
      Child(
        name: "bindingSpecifier",
        deprecatedName: "bindingKeyword",
        kind: .token(choices: [.keyword(text: "let"), .keyword(text: "var"), .keyword(text: "inout")])
      ),
      Child(
        name: "pattern",
        kind: .node(kind: .pattern)
      ),
      Child(
        name: "typeAnnotation",
        kind: .node(kind: .typeAnnotation),
        isOptional: true
      ),
      Child(
        name: "initializer",
        kind: .node(kind: .initializerClause),
        isOptional: true
      ),
    ]
  ),

  // repeat-while-stmt -> label? ':'? 'repeat' code-block 'while' expr ';'?
  Node(
    kind: .repeatStmt,
    base: .stmt,
    nameForDiagnostics: "'repeat' statement",
    traits: [
      "WithCodeBlock"
    ],
    children: [
      Child(
        name: "repeatKeyword",
        kind: .token(choices: [.keyword(text: "repeat")])
      ),
      Child(
        name: "body",
        kind: .node(kind: .codeBlock),
        nameForDiagnostics: "body"
      ),
      Child(
        name: "whileKeyword",
        kind: .token(choices: [.keyword(text: "while")])
      ),
      Child(
        name: "condition",
        kind: .node(kind: .expr),
        nameForDiagnostics: "condition"
      ),
    ]
  ),

  // return-stmt -> 'return' expr? ';'?
  Node(
    kind: .returnStmt,
    base: .stmt,
    nameForDiagnostics: "'return' statement",
    children: [
      Child(
        name: "returnKeyword",
        kind: .token(choices: [.keyword(text: "return")])
      ),
      Child(
        name: "expression",
        kind: .node(kind: .expr),
        isOptional: true
      ),
    ]
  ),

  // throw-stmt -> 'throw' expr ';'?
  Node(
    kind: .throwStmt,
    base: .stmt,
    nameForDiagnostics: "'throw' statement",
    children: [
      Child(
        name: "throwKeyword",
        kind: .token(choices: [.keyword(text: "throw")])
      ),
      Child(
        name: "expression",
        kind: .node(kind: .expr)
      ),
    ]
  ),

  Node(
    kind: .whereClause,
    base: .syntax,
    nameForDiagnostics: "'where' clause",
    children: [
      Child(
        name: "whereKeyword",
        kind: .token(choices: [.keyword(text: "where")])
      ),
      Child(
        name: "condition",
        deprecatedName: "guardResult",
        kind: .node(kind: .expr)
      ),
    ]
  ),

  // while-stmt -> label? ':'? 'while' condition-list code-block ';'?
  Node(
    kind: .whileStmt,
    base: .stmt,
    nameForDiagnostics: "'while' statement",
    traits: [
      "WithCodeBlock"
    ],
    children: [
      Child(
        name: "whileKeyword",
        kind: .token(choices: [.keyword(text: "while")])
      ),
      Child(
        name: "conditions",
        kind: .collection(kind: .conditionElementList, collectionElementName: "Condition")
      ),
      Child(
        name: "body",
        kind: .node(kind: .codeBlock)
      ),
    ]
  ),

  Node(
    kind: .yieldedExpressionsClause,
    base: .syntax,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)])
      ),
      Child(
        name: "elements",
        deprecatedName: "elementList",
        kind: .collection(kind: .yieldedExpressionList, collectionElementName: "Element")
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)])
      ),
    ]
  ),

  // yield-stmt -> 'yield' '('? expr-list? ')'?
  Node(
    kind: .yieldStmt,
    base: .stmt,
    nameForDiagnostics: "'yield' statement",
    children: [
      Child(
        name: "yieldKeyword",
        kind: .token(choices: [.keyword(text: "yield")])
      ),
      Child(
        name: "yieldedExpressions",
        deprecatedName: "yields",
        kind: .nodeChoices(choices: [
          Child(
            name: "multiple",
            deprecatedName: "yieldList",
            kind: .node(kind: .yieldedExpressionsClause)
          ),
          Child(
            name: "single",
            deprecatedName: "simpleYield",
            kind: .node(kind: .expr)
          ),
        ])
      ),
    ]
  ),

]
