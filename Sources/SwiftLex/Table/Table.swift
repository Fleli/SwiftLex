struct Table: CustomStringConvertible {
    
    var simulatedDFA: [[Character : Int]] = []
    
    var entry = -1
    
    var accepting: Set<Int> = []
    
    let specification: TokenSpecification
    
    var description: String {
        return "Table with entry = \(entry), accepting = \(accepting) and specification = \(specification)."
    }
    
    var stringForTable: String {
        return "\(simulatedDFA)"
    }
    
    var tableInitializerString: String {
        "Table([[Character : Int]](\(simulatedDFA)), \(entry), \(accepting), \(specification.initializerString))"
    }
    
    init(_ specification: TokenSpecification) {
        
        self.specification = specification
        
    }
    
    init(_ simulatedDFA: [[Character : Int]], _ entry: Int, _ accepting: Set<Int>, _ specification: TokenSpecification) {
        
        self.simulatedDFA = simulatedDFA
        self.entry = entry
        self.accepting = accepting
        self.specification = specification
        
    }
    
    func getStateAtTransition(for char: Character, in state: Int) -> Int {
        return simulatedDFA[state][char]  ??  0
    }
    
    func isAccepting(_ state: Int) -> Bool {
        return accepting.contains(state)
    }
    
}
