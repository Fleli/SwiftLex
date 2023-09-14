extension String {
    
    subscript(index: Int) -> Character? {
        
        if (index >= count) {
            return nil
        }
        
        let a = self.index(startIndex, offsetBy: index)
        return self[a]
        
    }
    
}

extension Character {
    
    static var validChars: Set<Character> {
        
        var chars: Set<Character> = ["\n"]
        
        let start = 32
        let end = 126
        
        for (ascii) in (start ... end) {
            
            guard let char = ascii.toChar() else {
                fatalError()
            }
            
            chars.insert(char)
            
        }
        
        return chars
        
    }
    
}

extension Int {
    
    func toChar() -> Character? {
        
        guard (self >= 32 && self <= 126) else {
            return nil
        }
        
        guard let scalar = UnicodeScalar(self) else {
            return nil
        }
    
        let character = Character(scalar)
        
        return character
        
    }
    
}
