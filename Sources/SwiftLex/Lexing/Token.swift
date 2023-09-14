struct Token: Equatable {
    
    var isOperator: Bool
    var content: Character
    
    init(_ isOperator: Bool, _ content: Character) {
        self.isOperator = isOperator
        self.content = content
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return (lhs.isOperator == rhs.isOperator) && (lhs.content == rhs.content)
    }
    
}
