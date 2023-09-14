class NFAState: CustomStringConvertible, Hashable {
    
    var description: String { "N\(id) \(isEntry ? "(ENTRY)" : "")\(isAccepting ? "(ACCEPTING)" : "")" }
    
    let id: Int
    
    var transitions: [NFATransition] = []
    
    var isAccepting = false
    var isEntry = false
    
    init() {
        
        self.id = Self.idCounter
        Self.idCounter += 1
        
    }
    
    func addTransition(to newState: NFAState, at character: Character?) {
        
        let transition = NFATransition(character: character, newState: newState, fromState: self)
        transitions.append(transition)
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: NFAState, rhs: NFAState) -> Bool {
        return lhs === rhs
    }
    
    static var idCounter = 0
    
}
