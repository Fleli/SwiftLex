public func generateLexer(specification: String, path: String, name: String, print: Bool = true) throws {
    let _ = try Generator(specification, path, name, print)
}
