extension Generator {
    
    func assembleLexClass(_ stringOfSimulatorInitializers: String) -> String {
        
        return """
        public class Lexer {
            
            private typealias SimulatorResult = (simulator: DFASimulator, lastAccepting: Int)
            
            private var index = 0
            
            private var line = 0
            private var col = 0
            
            private var input: String = ""
            private var tokens: [Token] = []
            
            private var simulators: [DFASimulator] =
            [
        \(stringOfSimulatorInitializers)
            ]
            
            public func lex(_ input: String) throws -> [Token] {
                
                self.index = 0
                self.input = input
                
                self.line = 0
                self.col = 0
                
                tokens = []
                
                while (index < input.count) {
                    
                    if let token = try nextToken() {
                        tokens.append(token)
                    }
                    
                }
                
                return tokens
                
            }
            
            private func nextToken() throws -> Token? {
                
                let maximalMunch = simulateDFAs()
                
                let attributes = maximalMunch.simulator.attributes
                let type = maximalMunch.simulator.type
                let content = try sliceInput(with: index, maximalMunch.lastAccepting)
                
                let newLines = content.filter {$0 == "\\n"} .count
                
                if (newLines > 0) {
                    col = -1
                    line += newLines
                }
                
                let startCol = col
                
                adjustIndices(maximalMunch)
                
                let endCol = col - 1
                
                if (attributes.contains(.discard)) {
                    return nil
                }
                
                let region = Region(line, startCol, line, endCol)
                
                if attributes.contains(.selfType) {
                    return Token(content, content, region)
                }
                
                return Token(type, content, region)
                
            }
            
            private func simulateDFAs() -> SimulatorResult {
                
                var results: [SimulatorResult] = []
                
                for (simulator) in (simulators) {
                    let lastAccepting = simulator.simulateUntilDead(input, index)
                    results.append((simulator, lastAccepting))
                }
                
                let sortedResults = results.sorted {
                    
                    if ($0.lastAccepting == $1.lastAccepting) {
                        return $0.simulator.specificationPrecedence > $1.simulator.specificationPrecedence
                    }
                    
                    return $0.lastAccepting > $1.lastAccepting
                    
                }
                
                return sortedResults[0]
                
            }
            
            private func sliceInput(with index: Int, _ lastAccepting: Int) throws -> String {
                
                let startIndex = input.index(input.startIndex, offsetBy: index)
                let endIndex = input.index(input.startIndex, offsetBy: lastAccepting)
                
                guard (endIndex > startIndex) else {
                    throw LexError.invalidCharacter(input[startIndex], tokens)
                }
                
                let slice = input[startIndex ..< endIndex]
                
                return String(slice)
                
            }
            
            private func adjustIndices(_ result: SimulatorResult) {
                
                let lastAccepting = result.lastAccepting
                col += lastAccepting - index
                index = lastAccepting
                
            }
            
        }
        """
        
    }
    
}
