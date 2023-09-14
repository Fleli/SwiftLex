struct TokenList {
    
    var array: [Token] = []
    
    mutating func append(_ token: Token) {
        array.append(token)
    }
    
    subscript(index: Int) -> Token? {
        
        guard (index < array.count) else {
            return nil
        }
        
        return array[index]
        
    }
    
    func parse() throws -> Regex {
        
        return try Parser().parse(self)
        
    }
    
}
