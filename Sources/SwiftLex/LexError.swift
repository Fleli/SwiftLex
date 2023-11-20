enum LexError: Error, CustomStringConvertible {
    
    case unexpectedEndOfInput(_ expected: String)
    case encounteredUnknown
    case wrongInputFormat
    case tooShort
    
    var description: String {
        
        switch self {
        case .unexpectedEndOfInput(let expected):
            return "Unexpected end of input. Expected '\(expected)'."
        case .encounteredUnknown:
            return "Encountered unknown character."
        case .wrongInputFormat:
            return "The input is ill-formed."
        case .tooShort:
            return "Too short (ill-formed input)."
        }
        
    }
    
}
