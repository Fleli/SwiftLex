class Parser {
    
    private var index = 0
    private var input = TokenList()
    
    private var next: Token? { input[index] }
    
    func parse(_ input: TokenList) throws -> Regex {
        
        self.input = input
        self.index = 0
        
        let regex = try parse(3)
        
        return regex
        
    }
    
    private func parse(_ depth: Int) throws -> Regex {
        
        if (depth == 0) {
            return try parseFactor()
        }
        
        var regex = try parse(depth - 1)
        
        while let operation = try getOperator(at: depth) {
            
            incrementIndex()
            
            if (operation.content == "*") {
                
                regex = RegexKleene(regex)
                
            } else {
                
                let arg2 = try parse(depth - 1)
                
                switch (operation.content) {
                    
                case "&":       regex = RegexConcatenation(regex, arg2)
                case "|":       regex = RegexAlternation(regex, arg2)
                default:        throw LexError.encounteredUnknown
                    
                }
                
            }
            
        }
        
        return regex
        
    }
    
    private func incrementIndex(_ number: Int = 1) {
        index += number
    }
    
    private func getOperator(at depth: Int) throws -> Token? {
        
        guard let next = next else {
            return nil
        }
        
        if [ (1 , "*") , (2 , "&") , (3 , "|") ].contains(where: { $0 == (depth , next.content) && next.isOperator } ) {
            return next
        }
        
        if "*&|".contains(next.content) && next.isOperator {
            return nil
        }
        
        if (depth == 2) {
            
            index -= 1
            return Token(true, "&")
            
        }
        
        return nil
        
    }
    
    private func parseFactor() throws -> Regex {
        
        guard let next = next else {
            throw LexError.unexpectedEndOfInput("factor")
        }
        
        incrementIndex()
        
        if (next == Token(true, "(")) {
            
            let parenthesizedRegex = try parse(3)
            
            guard self.next == Token(true, ")") else {
                throw LexError.unexpectedEndOfInput("Expected ), not \(String(describing: self.next)) (at \(index))")
            }
            
            incrementIndex()
            
            return parenthesizedRegex
            
        } else if (next == Token(true, "[")) {
            
            let rangeDescribedRegex = try parseRangeDescription()
            
            guard self.next == Token(true, "]") else {
                throw LexError.unexpectedEndOfInput("]")
            }
            
            incrementIndex()
            
            return rangeDescribedRegex
            
        }
        
        return RegexLiteral(literal: next.content)
        
    }
    
    private func parseRangeDescription() throws -> Regex {
        
        var charsInRangeDescription: [Character] = []
        
        let isNonMatching = (next == Token(true, "^"))
        
        if (isNonMatching) {
            incrementIndex()
        }
        
        var buffer: [Token?] = [nil, nil, nil]
        
        fillBuffer(&buffer)
        
        while buffer[0] != Token(true, "]") {
            
            switch ( buffer[0], buffer[1], buffer[2] ) {
                
            case (nil, nil, nil):
                
                throw LexError.unexpectedEndOfInput("] or chars")
                
            case (let start , Token(false, "-") , let end) where (end != Token(true, "]")):
                
                let chars = try getCharsInClosedRange(from: start!.content, to: end!.content)
                charsInRangeDescription += chars
                
                incrementIndex(3)
                
            case (let start , _ , _):
                
                guard let start = start else {
                    fatalError("")
                }
                
                charsInRangeDescription.append(start.content)
                incrementIndex()
                
            }
            
            fillBuffer(&buffer)
            
        }
        
        guard (charsInRangeDescription.count > 0) else {
            throw LexError.wrongInputFormat
        }
        
        let regex = produceRegexFrom(chars: charsInRangeDescription, isNonMatching)
        
        return regex
        
    }
    
    private func fillBuffer(_ buffer: inout [Token?]) {
        
        for (offset) in (0 ... 2) {
            let char = input[index + offset]
            buffer[offset] = char
        }
        
    }
    
    private func getCharsInClosedRange(from start: Character, to end: Character) throws -> [Character] {
        
        guard let asciiStart = start.asciiValue, let asciiEnd = end.asciiValue, asciiStart <= asciiEnd else {
            throw LexError.wrongInputFormat
        }
        
        var chars: [Character] = []
        
        for (ascii) in (asciiStart ... asciiEnd) {
            
            let unicodeScalar = UnicodeScalar(ascii)
            let character = Character(unicodeScalar)
            
            chars.append(character)
            
        }
        
        return chars
        
    }
    
    private func produceRegexFrom(chars: [Character], _ isNonMatching: Bool) -> Regex {
        
        let regexChars: Set<Character>
        
        if (isNonMatching) {
            regexChars = Character.validChars.symmetricDifference(chars)
        } else {
            regexChars = Set<Character>(chars)
        }
        
        let first = regexChars.first!
        
        var regex: any Regex = RegexLiteral(literal: first)
        
        for (char) in (regexChars) {
            
            if (char == first) {
                continue
            }
            
            let literal = RegexLiteral(literal: char)
            regex = RegexAlternation(regex, literal)
            
        }
        
        return regex
        
    }
    
}
