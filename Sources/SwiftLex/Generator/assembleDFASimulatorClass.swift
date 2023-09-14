extension Generator {
    
    func assembleDFASimulatorClass() -> String {
        
        return """
        private class DFASimulator {
            
            private let table: Table
            private var state: Int
            
            private var input: String = ""
            
            var type: String { table.specification.type }
            var attributes: [TokenSpecificationAttribute] { table.specification.attributes }
            var specificationPrecedence: Int { table.specification.specificationPrecedence }
            
            init(_ table: Table) {
                self.table = table
                self.state = table.entry
            }
            
            /// Returns the last accepting length
            func simulateUntilDead(_ input: String, _ index: Int) -> Int {
                
                reset()
                
                var index = index
                var lastAccepting = 0
                
                self.input = input
                
                while (state > 0) {
                    
                    guard let char = self[index] else {
                        return lastAccepting
                    }
                    
                    state = table.getStateAtTransition(for: char, in: state)
                    
                    index += 1
                    
                    if table.isAccepting(state) {
                        lastAccepting = index
                    }
                    
                }
                
                return lastAccepting
                
            }
            
            private func reset() {
                
                state = table.entry
                
            }
            
            private subscript(index: Int) -> Character? {
                
                guard index < input.count else { return nil }
                
                let stringIndex = input.index(input.startIndex, offsetBy: index)
                return input[stringIndex]
                
            }
            
        }
        """
        
    }
    
}
