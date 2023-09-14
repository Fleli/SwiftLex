struct NFATransition: CustomStringConvertible {
    
    var fromState: NFAState?
    let character: Character?
    let newState: NFAState
    
    var description: String { "\(fromState!) -> \(newState) @ \(character ?? "-")" }
    
    init(character: Character?, newState: NFAState, fromState: NFAState? = nil) {
        
        self.character = character
        self.newState = newState
        
        self.fromState = fromState
        
        NFATransition.allTransitions.append(self)
        
    }
    
    static var allTransitions: [NFATransition] = []
    
}
