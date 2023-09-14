struct DFATransition: Hashable, CustomStringConvertible {
    
    var oldState: DFAState
    var newState: DFAState
    var character: Character
    
    init(oldState: DFAState, newState: DFAState, character: Character) {
        
        self.oldState = oldState
        self.newState = newState
        self.character = character
        
        oldState.dfa!.allTransitions.insert(self)
        
    }
    
    var description: String {
        " \(oldState) -> \(newState)   @   \(character)"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(character)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.character == rhs.character && lhs.newState === rhs.newState && lhs.oldState === rhs.oldState
    }
    
}
