extension Generator {
    
    func assembleLexError() -> String {
        
        return """
        enum LexError: Error {
        
            case invalidCharacter(_ char: Character, _ tokens: [Token])
            
        }
        """
        
    }
    
}
