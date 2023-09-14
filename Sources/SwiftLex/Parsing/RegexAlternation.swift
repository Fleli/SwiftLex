class RegexAlternation: Regex {
    
    var description: String { "(" + arg1.description + "|" + arg2.description + ")" }
    
    let arg1: Regex
    let arg2: Regex
    
    init(_ arg1: Regex, _ arg2: Regex) {
        self.arg1 = arg1
        self.arg2 = arg2
    }
    
    func generateNFA() -> NFA {
        
        let arg1NFA = arg1.generateNFA()
        let arg2NFA = arg2.generateNFA()
        
        return .nfaFromAlternationOf(arg1NFA, arg2NFA)
        
    }
    
}
