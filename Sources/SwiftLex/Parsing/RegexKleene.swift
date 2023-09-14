class RegexKleene: Regex {
    
    var description: String { "(" + arg.description + "*)" }
    
    let arg: Regex
    
    init(_ arg: Regex) {
        self.arg = arg
    }
    
    func generateNFA() -> NFA {
        
        let argNFA = arg.generateNFA()
        
        return .nfaFromKleeneOf(argNFA)
        
    }
    
}
