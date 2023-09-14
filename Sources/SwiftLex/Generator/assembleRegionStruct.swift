extension Generator {
    
    func assembleRegionStruct() -> String {
        
        return """
        public struct Region: CustomStringConvertible {
        
            var startLine: Int
            var startCol: Int
            var endLine: Int
            var endCol: Int
            
            public var description: String {
                "ln \\(startLine) col \\(startCol) -> ln \\(endLine) col \\(endCol)"
            }
            
            init(_ startLine: Int, _ startCol: Int, _ endLine: Int, _ endCol: Int) {
                
                self.startLine = startLine
                self.startCol = startCol
                self.endLine = endLine
                self.endCol = endCol
                
            }
            
        }
        """
        
    }
    
}
