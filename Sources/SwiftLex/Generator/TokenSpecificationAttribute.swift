enum TokenSpecificationAttribute: CustomStringConvertible {
    
    case discard
    case selfType
    
    // Legg til flere her. Husk å oppdatere assembleTokenSpecificationAttributeEnum med de samme casene
    
    var description: String {
        switch self {
        case .discard:
            return ".discard"
        case .selfType:
            return ".selfType"
        }
    }
    
}
