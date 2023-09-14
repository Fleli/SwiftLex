extension Generator {
    
    func generateLexer(with tables: [Table], fileName: String) -> String {
        
        var stringOfSimulatorInitializers = ""
        
        for table in tables {
            
            let initializerString = table.tableInitializerString
            
            let simulatorInitializer = "\t\tDFASimulator(\(initializerString)),\n"
            stringOfSimulatorInitializers += simulatorInitializer
            
        }
        
        stringOfSimulatorInitializers.removeLast(2)
        stringOfSimulatorInitializers.append("\n")
        
        let lexerClassString =
        
            """
            
            \(assembleInitialComments(fileName))
            
            \(assembleLexClass(stringOfSimulatorInitializers))
            
            \(assembleDFASimulatorClass())
            
            \(assembleTokenStruct())
            
            \(assembleRegionStruct())
            
            \(assembleTableStruct())
            
            \(assembleTokenSpecificationStruct())
            
            \(assembleTokenSpecificationAttrbuteEnum())
            
            \(assembleLexError())
            
            """
        
        return lexerClassString
        
    }
    
}
