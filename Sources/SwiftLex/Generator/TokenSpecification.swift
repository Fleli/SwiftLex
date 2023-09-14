struct TokenSpecification {
    
    let type: String
    let regex: String                                   // Ikke med i lex-filen som produseres.
    let attributes: [TokenSpecificationAttribute]
    let specificationPrecedence: Int
    
    var initializerString: String { "TokenSpecification(\(specificationPrecedence), \"\(type)\", \(attributes))" }
    
    init(_ specificationPrecedence: Int, _ type: String, _ regex: String, _ attributes: [TokenSpecificationAttribute]) {
        
        self.specificationPrecedence = specificationPrecedence
        self.type = type
        self.regex = regex
        self.attributes = attributes
        
    }
    
}
