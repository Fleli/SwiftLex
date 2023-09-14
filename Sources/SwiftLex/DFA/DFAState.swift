class DFAState: Hashable, CustomStringConvertible {
    
    var nfaStates: Set<NFAState> = []
    var transitions: Set<DFATransition> = []
    
    var isEntry: Bool { nfaStates.filter { $0.isEntry }.count > 0 }
    var isAccepting: Bool { nfaStates.filter { $0.isAccepting }.count > 0 }
    
    var description: String {
        return "D" + String(id) + " \(isAccepting ? "(ACCEPTING)" : "")\(isEntry ? "(ENTRY)" : "") " + "(\(nfaStates))"
    }
    
    var didFinish = false
    
    weak var dfa: DFA?
    
    var id: Int
    
    init(_ nfaStates: Set<NFAState>, dfa: DFA) {
        
        self.nfaStates = nfaStates
        
        self.dfa = dfa
        
        self.id = dfa.stateCounter
        dfa.stateCounter += 1
        
    }
    
    init(_ nfaStates: Set<NFAState>) {
        
        self.nfaStates = nfaStates
        self.dfa = nil
        
        id = -1
        
    }
    
    func generateDFATransitions() {
        
        if (didFinish) {
            return
        }
        
        let subsetTransitions: [Character : Set<NFAState>] = generateSubsetTransitions()
        
        insertTransitions(subsetTransitions)
        
        didFinish = true
        
        propagate()
        
    }
    
    private func generateSubsetTransitions() -> [Character : Set<NFAState>] {
        
        var subsetTransitions: [Character : Set<NFAState>] = [:]
        
        nfaStates.map { $0.transitions }.forEach { $0.forEach { transition in
            
            guard let c = transition.character else { return }
            
            if (subsetTransitions[c] == nil) {
                subsetTransitions[c] = []
            }
            
            let newState = transition.newState
            
            subsetTransitions[c]?.insert(newState)
            
        }}
        
        return subsetTransitions
        
    }
    
    private func insertTransitions(_ subsetTransitions: [Character : Set<NFAState>]) {
        
        guard let dfa = dfa else {
            fatalError("No associated DFA.")
        }
        
        for pair in subsetTransitions {
            
            let char = pair.key
            let nfaStates = pair.value
            
            let epsilonClosure = epsilonClosureOf(nfaStates)
            
            let dfaState = dfa.getDFAState(with: epsilonClosure)
            
            let transition = DFATransition(oldState: self, newState: dfaState, character: char)
            
            transitions.insert(transition)
            
        }
        
    }
    
    private func epsilonClosureOf(_ nfaStates: Set<NFAState>) -> Set<NFAState> {
        
        var epsilonClosure: Set<NFAState> = []
        
        for nfaState in nfaStates {
            
            let subClosure = nfaState.epsilonClosure()
            epsilonClosure = epsilonClosure.union(subClosure)
            
        }
        
        return epsilonClosure
        
    }
    
    private func propagate() {
        
        for transition in transitions {
            
            transition.newState.generateDFATransitions()
            
        }
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(nfaStates)
    }
    
    static func == (lhs: DFAState, rhs: DFAState) -> Bool {
        return lhs === rhs
    }
    
}
