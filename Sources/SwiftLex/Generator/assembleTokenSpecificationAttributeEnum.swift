extension Generator {
    
    func assembleTokenSpecificationAttrbuteEnum() -> String {
        
        return """
        enum TokenSpecificationAttribute {
            
            case discard
            case selfType
            
        }
        """
        
    }
    
}
