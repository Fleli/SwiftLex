extension DFA {
    
    func generateTable(with specification: TokenSpecification) -> Table {
        
        var table = Table(specification)
        
        var entry: Set<Int> = []
        var accepting: Set<Int> = []
        
        fillTable(&table, &entry, &accepting)
        setEntryAndAccepting(&table, entry, accepting)
        
        return table
        
    }
    
    private func fillTable(_ table: inout Table, _ entry: inout Set<Int>, _ accepting: inout Set<Int>) {
        
        let dfa = self
        
        let transitions = dfa.allTransitions
        let count = dfa.stateCount + 1
        
        table.simulatedDFA = Array<[Character : Int]>(repeating: [:], count: count)
        
        transitions.forEach { transition in
            
            let oldState = transition.oldState.id
            let newState = transition.newState.id
            let character = transition.character
            
            table.simulatedDFA[oldState][character] = newState
            
            for (state) in [transition.oldState, transition.newState] {
                
                if (state.isEntry) {
                    entry.insert(state.id)
                }
                
                if (state.isAccepting) {
                    accepting.insert(state.id)
                }
                
            }
            
        }
        
    }
    
    private func setEntryAndAccepting(_ table: inout Table, _ entry: Set<Int>, _ accepting: Set<Int>) {
        
        guard entry.count == 1, let entry = entry.first else {
            fatalError("Something went wrong")
        }
        
        table.entry = entry
        table.accepting = accepting
        
    }
    
}
