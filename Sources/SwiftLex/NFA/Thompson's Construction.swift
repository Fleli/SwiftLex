extension NFA {
    
    static func nfaFrom(_ literal: Character) -> NFA {
        
        let entry = NFAState()
        let accepting = NFAState()
        
        entry.addTransition(to: accepting, at: literal)
        
        return NFA(entry: entry, accepting: accepting)
        
    }
    
    static func nfaFromAlternationOf(_ arg1: NFA, _ arg2: NFA) -> NFA {
        
        let entry = NFAState()
        let accepting = NFAState()
        
        let nfa = NFA(entry: entry, accepting: accepting)
        
        entry.addTransition(to: arg1.entry, at: nil)
        entry.addTransition(to: arg2.entry, at: nil)
        
        arg1.accepting.addTransition(to: accepting, at: nil)
        arg2.accepting.addTransition(to: accepting, at: nil)
        
        return nfa
        
    }
    
    static func nfaFromConcatenationOf(_ arg1: NFA, _ arg2: NFA) -> NFA {
        
        let entry = NFAState()
        let accepting = NFAState()
        
        let nfa = NFA(entry: entry, accepting: accepting)
        
        entry.addTransition(to: arg1.entry, at: nil)
        arg1.accepting.addTransition(to: arg2.entry, at: nil)
        arg2.accepting.addTransition(to: accepting, at: nil)
        
        return nfa
        
    }
    
    static func nfaFromKleeneOf(_ arg: NFA) -> NFA {
        
        let entry = NFAState()
        let accepting = NFAState()
        
        let nfa = NFA(entry: entry, accepting: accepting)
        
        entry.addTransition(to: accepting, at: nil)
        entry.addTransition(to: arg.entry, at: nil)
        
        arg.accepting.addTransition(to: accepting, at: nil)
        arg.accepting.addTransition(to: arg.entry, at: nil)
        
        return nfa
        
    }
    
}
