//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

public struct KeywordSpec {
  public var name: String
  public var isLexerClassified: Bool
  public var requiresLeadingSpace: Bool
  public var requiresTrailingSpace: Bool

  public var escapedName: String {
    if isLexerClassified || name == "Type" || name == "Protocol" {
      return "`\(name)`"
    } else {
      return name
    }
  }

  /// `isLexerClassified` determines whether the token kind is switched from being an identifier to a keyword in the lexer.
  /// This is true for keywords that used to be considered non-contextual.
  init(_ name: String, isLexerClassified: Bool = false, requiresLeadingSpace: Bool = false, requiresTrailingSpace: Bool = false) {
    self.name = name
    self.isLexerClassified = isLexerClassified
    self.requiresLeadingSpace = requiresLeadingSpace
    self.requiresTrailingSpace = requiresTrailingSpace
  }
}

public let KEYWORDS: [KeywordSpec] = [
  // Please keep these sorted alphabetically
  
  KeywordSpec("__consuming"),
  KeywordSpec("__objc_bridged"),
  KeywordSpec("__owned"),
  KeywordSpec("__raw_doc_comment"),
  KeywordSpec("__setter_access"),
  KeywordSpec("__shared"),
  KeywordSpec("__synthesized_protocol"),
  KeywordSpec("_alignment"),
  KeywordSpec("_alwaysEmitConformanceMetadata"),
  KeywordSpec("_alwaysEmitIntoClient"),
  KeywordSpec("_assemblyVision"),
  KeywordSpec("_backDeploy"),
  KeywordSpec("_borrow"),
  KeywordSpec("_borrowed"),
  KeywordSpec("_cdecl"),
  KeywordSpec("_clangImporterSynthesizedType"),
  KeywordSpec("_Class"),
  KeywordSpec("_compilerInitialized"),
  KeywordSpec("_const"),
  KeywordSpec("_custom"),
  KeywordSpec("_disfavoredOverload"),
  KeywordSpec("_documentation"),
  KeywordSpec("_dynamicReplacement"),
  KeywordSpec("_eagerMove"),
  KeywordSpec("_effects"),
  KeywordSpec("_exported"),
  KeywordSpec("_expose"),
  KeywordSpec("_fixed_layout"),
  KeywordSpec("_forbidSerializingReference"),
  KeywordSpec("_forward"),
  KeywordSpec("_frozen"),
  KeywordSpec("_hasInitialValue"),
  KeywordSpec("_hasMissingDesignatedInitializers"),
  KeywordSpec("_hasStorage"),
  KeywordSpec("_implementationOnly"),
  KeywordSpec("_implements"),
  KeywordSpec("_implicitSelfCapture"),
  KeywordSpec("_inheritActorContext"),
  KeywordSpec("_inheritsConvenienceInitializers"),
  KeywordSpec("_linear"),
  KeywordSpec("_local"),
  KeywordSpec("_marker"),
  KeywordSpec("_modify"),
  KeywordSpec("_move"),
  KeywordSpec("_moveOnly"),
  KeywordSpec("_NativeClass"),
  KeywordSpec("_NativeRefCountedObject"),
  KeywordSpec("_noAllocation"),
  KeywordSpec("_noEagerMove"),
  KeywordSpec("_noImplicitCopy"),
  KeywordSpec("_noLocks"),
  KeywordSpec("_noMetadata"),
  KeywordSpec("_nonEphemeral"),
  KeywordSpec("_nonoverride"),
  KeywordSpec("_nonSendable"),
  KeywordSpec("_objc_non_lazy_realization"),
  KeywordSpec("_objcImplementation"),
  KeywordSpec("_objcRuntimeName"),
  KeywordSpec("_opaqueReturnTypeOf"),
  KeywordSpec("_optimize"),
  KeywordSpec("_originallyDefinedIn"),
  KeywordSpec("_PackageDescription"),
  KeywordSpec("_private"),
  KeywordSpec("_projectedValueProperty"),
  KeywordSpec("_read"),
  KeywordSpec("_RefCountedObject"),
  KeywordSpec("_restatedObjCConformance"),
  KeywordSpec("_semantics"),
  KeywordSpec("_show_in_interface"),
  KeywordSpec("_silgen_name"),
  KeywordSpec("_specialize"),
  KeywordSpec("_specializeExtension"),
  KeywordSpec("_spi"),
  KeywordSpec("_spi_available"),
  KeywordSpec("_spiOnly"),
  KeywordSpec("_staticInitializeObjCMetadata"),
  KeywordSpec("_swift_native_objc_runtime_base"),
  KeywordSpec("_transparent"),
  KeywordSpec("_Trivial"),
  KeywordSpec("_TrivialAtMost"),
  KeywordSpec("_typeEraser"),
  KeywordSpec("_unavailableFromAsync"),
  KeywordSpec("_UnknownLayout"),
  KeywordSpec("_unsafeInheritExecutor"),
  KeywordSpec("_weakLinked"),
  KeywordSpec("actor"),
  KeywordSpec("addressWithNativeOwner"),
  KeywordSpec("addressWithOwner"),
  KeywordSpec("any"),
  KeywordSpec("Any", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("as", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("assignment"),
  KeywordSpec("associatedtype", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("associativity"),
  KeywordSpec("async", requiresTrailingSpace: true),
  KeywordSpec("autoclosure"),
  KeywordSpec("availability"),
  KeywordSpec("available"),
  KeywordSpec("await"),
  KeywordSpec("break", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("case", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("catch", isLexerClassified: true, requiresLeadingSpace: true),
  KeywordSpec("class", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("continue", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("convenience"),
  KeywordSpec("convention"),
  KeywordSpec("default", isLexerClassified: true),
  KeywordSpec("defer", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("deinit", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("deprecated"),
  KeywordSpec("derivative"),
  KeywordSpec("didSet"),
  KeywordSpec("differentiable"),
  KeywordSpec("discardableResult"),
  KeywordSpec("distributed"),
  KeywordSpec("do", isLexerClassified: true),
  KeywordSpec("dynamic"),
  KeywordSpec("dynamicCallable"),
  KeywordSpec("dynamicMemberLookup"),
  KeywordSpec("each"),
  KeywordSpec("else", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("enum", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("escaping"),
  KeywordSpec("exclusivity"),
  KeywordSpec("exported"),
  KeywordSpec("extension", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("fallthrough", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("false", isLexerClassified: true),
  KeywordSpec("fileprivate", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("final"),
  KeywordSpec("for", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("frozen"),
  KeywordSpec("func", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("get"),
  KeywordSpec("GKInspectable"),
  KeywordSpec("globalActor"),
  KeywordSpec("guard", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("higherThan"),
  KeywordSpec("IBAction"),
  KeywordSpec("IBDesignable"),
  KeywordSpec("IBInspectable"),
  KeywordSpec("IBOutlet"),
  KeywordSpec("IBSegueAction"),
  KeywordSpec("if", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("import", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("in", isLexerClassified: true, requiresLeadingSpace: true, requiresTrailingSpace: true),
  KeywordSpec("indirect"),
  KeywordSpec("infix"),
  KeywordSpec("init", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("inlinable"),
  KeywordSpec("inline"),
  KeywordSpec("inout", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("internal", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("introduced"),
  KeywordSpec("is", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("isolated"),
  KeywordSpec("kind"),
  KeywordSpec("lazy"),
  KeywordSpec("let", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("LLDBDebuggerFunction"),
  KeywordSpec("lowerThan"),
  KeywordSpec("macro"),
  KeywordSpec("main"),
  KeywordSpec("message"),
  KeywordSpec("mutableAddressWithNativeOwner"),
  KeywordSpec("mutableAddressWithOwner"),
  KeywordSpec("mutating"),
  KeywordSpec("nil", isLexerClassified: true),
  KeywordSpec("noasync"),
  KeywordSpec("noDerivative"),
  KeywordSpec("noescape"),
  KeywordSpec("nonisolated"),
  KeywordSpec("nonmutating"),
  KeywordSpec("nonobjc"),
  KeywordSpec("NSApplicationMain"),
  KeywordSpec("NSCopying"),
  KeywordSpec("NSManaged"),
  KeywordSpec("objc"),
  KeywordSpec("objcMembers"),
  KeywordSpec("obsoleted"),
  KeywordSpec("of"),
  KeywordSpec("open"),
  KeywordSpec("operator", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("optional"),
  KeywordSpec("override"),
  KeywordSpec("package"),
  KeywordSpec("postfix"),
  KeywordSpec("precedencegroup", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("preconcurrency"),
  KeywordSpec("prefix"),
  KeywordSpec("private", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("propertyWrapper"),
  KeywordSpec("Protocol"),
  KeywordSpec("protocol", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("public", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("reasync"),
  KeywordSpec("renamed"),
  KeywordSpec("repeat", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("required"),
  KeywordSpec("requires_stored_property_inits"),
  KeywordSpec("resultBuilder"),
  KeywordSpec("rethrows", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("return", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("reverse"),
  KeywordSpec("runtimeMetadata"),
  KeywordSpec("safe"),
  KeywordSpec("self", isLexerClassified: true),
  KeywordSpec("Self", isLexerClassified: true),
  KeywordSpec("Sendable"),
  KeywordSpec("set"),
  KeywordSpec("some"),
  KeywordSpec("spi"),
  KeywordSpec("spiModule"),
  KeywordSpec("static", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("struct", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("subscript", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("super", isLexerClassified: true),
  KeywordSpec("swift"),
  KeywordSpec("switch", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("target"),
  KeywordSpec("testable"),
  KeywordSpec("throw", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("throws", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("transpose"),
  KeywordSpec("true", isLexerClassified: true),
  KeywordSpec("try", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("Type"),
  KeywordSpec("typealias", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("typeWrapper"),
  KeywordSpec("typeWrapperIgnored"),
  KeywordSpec("UIApplicationMain"),
  KeywordSpec("unavailable"),
  KeywordSpec("unchecked"),
  KeywordSpec("unowned"),
  KeywordSpec("unsafe"),
  KeywordSpec("unsafe_no_objc_tagged_pointer"),
  KeywordSpec("unsafeAddress"),
  KeywordSpec("unsafeMutableAddress"),
  KeywordSpec("usableFromInline"),
  KeywordSpec("var", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("warn_unqualified_access"),
  KeywordSpec("weak"),
  KeywordSpec("where", isLexerClassified: true, requiresLeadingSpace: true, requiresTrailingSpace: true),
  KeywordSpec("while", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("willSet"),
  KeywordSpec("witness_method"),
  KeywordSpec("wrt"),
  KeywordSpec("yield"),
]

public func keywordsByLength() -> [(Int, [KeywordSpec])] {
  var result: [Int: [KeywordSpec]] = [:]
  for keyword in KEYWORDS {
    result[keyword.name.count, default: []].append(keyword)
  }
  return result.sorted(by: { $0.key < $1.key })
}