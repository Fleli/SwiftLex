extension Generator {
    
    func assembleTokenStruct() -> String {
        
        return """
        public struct Token: CustomStringConvertible {
            
            public var type: String
            public var content: String
            public var region: Region
            
            public var description: String {
                
                var string = type
                
                string += String(repeating: " ", count: 20)
                string.removeLast(string.count - 20)
                
                string += content
                
                string += String(repeating: " ", count: 30)
                string.removeLast(string.count - 40)
                
                string += "\\(region)"
                
                return string
                
            }
            
            public init(_ type: String, _ content: String, _ region: Region) {
                
                self.type = type
                self.content = content
                self.region = region
                
            }
            
        }
        """
        
    }
    
}
