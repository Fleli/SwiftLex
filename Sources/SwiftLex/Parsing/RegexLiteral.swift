class RegexLiteral: Regex {
    
    var description: String { String(literal) }
    
    let literal: Character
    
    init(literal: Character) {
        self.literal = literal
    }
    
    func generateNFA() -> NFA {
        return .nfaFrom(literal)
    }
    
}
