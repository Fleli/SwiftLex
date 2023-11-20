extension String {
    
    func generateTokens() throws -> TokenList {
        
        var index = 0
        var tokens = TokenList()
        
    loop: while (index < count) {
            
            let next = self[index]
            
            let token: Token
            
            switch (next) {
                
            case nil:
                break loop
            case "&", "|", "*", "(", ")", "[", "]", "^":
                token = Token(true, next!)
            case "\\" where (self[index + 1] == "n"):
                token = Token(false, "\n")
                index += 1
            case "\\" where (self[index + 1] == "t"):
                token = Token(false, "\t")
                index += 1
            case "\\" where (self[index + 1] != nil):
                token = Token(false, self[index + 1]!)
                index += 1
            case "\\":
                throw LexError.unexpectedEndOfInput("Expected character after escape character (\\)")
            default:
                token = Token(false, next!)
                
            }
            
            index += 1
            
            tokens.append(token)
            
        }
        
        for t in tokens.array {
            print(t.description)
        }
        
        return tokens
        
    }
    
}
