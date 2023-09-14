enum LexError: Error {
    
    case unexpectedEndOfInput(_ expected: String)
    case encounteredUnknown
    case wrongInputFormat
    case tooShort
    
}
