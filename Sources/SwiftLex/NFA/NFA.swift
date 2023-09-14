class NFA {
    
    var entry: NFAState
    var accepting: NFAState
    
    init(entry: NFAState, accepting: NFAState) {
        
        self.entry = entry
        self.accepting = accepting
        
    }
    
    func tellEntryAndAccepting() {
        self.entry.isEntry = true
        self.accepting.isAccepting = true
    }
    
}
