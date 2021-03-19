import STOKit

@main
struct EpisodeLister {
    static func main() {
        // getEpisodes()
        var character = STOPlayableCharacter(name: "Iesel", faction: .StarfleetDSC)
        character.journal.episodes[STOEpisode(name: "Graduation Day", arc: .StarfleetDSCTutorial, number: 1)] = true
        character.reputations[.Omega].set(xp: 7500)
        save(character: character)
        // save(character: STOPlayableCharacter(name: "Talia", faction: .Starfleet2409))
        // loadCharacter(named: "Talia")
        guard var iesel = loadCharacter(named: "Iesel") as? STOPlayableCharacter else { fatalError() }
        print("eps: \(iesel.journal.episodes.sorted())")
        print("reps: \(iesel.reputations.sorted())")
    }

    static func getEpisodes() {
        print("Getting episodes")
        let episodes = STOEpisode.all()
        for faction in STOFaction.allCases {
            print("Story arcs for \(faction.description)")
            for arc in faction.arcs.sorted() {
                print("\t\(arc.description): \(episodes.filter({ $0.arc == arc }).sorted().map({ $0.name }))")
            }
        }
    }

    static func save(character: STOPlayableCharacter) {
        print("Saving character")
        // print(character.journal.episodes.sorted())
        // print(character.journal.episodes[.Starfleet2409Tutorial])
        character.save()
    }

    @discardableResult
    static func loadCharacter(named name: String) -> STOCharacter? {
        print("Loading character")
        guard let character = STOPlayableCharacter.load(character: name) else { return nil }
        // print(character.journal.episodes.completed)
        // print(character.journal.episodes.incomplete)
        // print(character.journal.episodes[.Starfleet2409Tutorial])
        // print(character.journal.episodes[.StarfleetDSCTutorial])
        return character
    }
}
