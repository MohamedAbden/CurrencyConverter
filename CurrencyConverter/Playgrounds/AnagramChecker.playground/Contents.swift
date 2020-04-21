

func anagramChecker(_ firstString:String,_ secondString:String) -> Bool{
    guard firstString.count == secondString.count else { return false }
    return firstString.lowercased().sorted() == secondString.lowercased().sorted()
}

let anagramSuccess = anagramChecker("debit card","bad credit")

let anagramFailure = anagramChecker("punishments","nine thumps")
