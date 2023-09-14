extension NFA {
    
    func generateDFA() -> DFA {
        
        tellEntryAndAccepting()
        
        let entrySet = entry.epsilonClosure()
        let dfaEntry = DFAState(entrySet)
        
        let dfa = DFA(dfaEntry)
        
        dfaEntry.generateDFATransitions()
        
        return dfa
        
    }
    
}

extension NFAState {
    
    func epsilonClosure() -> Set<NFAState> {
        
        var closure: Set<NFAState> = []
        
        self.fillEpsilonClosure(&closure)
        
        return closure
        
    }
    
    private func fillEpsilonClosure(_ closure: inout Set<NFAState>) {
        
        if closure.contains(self) {
            return
        }
        
        closure.insert(self)
        
        let epsilonTransitions = transitions.filter { $0.character == nil }
        
        epsilonTransitions.forEach { transition in
            transition.newState.fillEpsilonClosure(&closure)
        }
        
    }
    
}
