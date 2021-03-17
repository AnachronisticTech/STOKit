import STOKit

@main
struct EpisodeLister {
    static func main() {
        // getEpisodes()
        save(character: STOPlayableCharacter(name: "Iesel", faction: .StarfleetDSC))
        // save(character: STOPlayableCharacter(name: "Talia", faction: .Starfleet2409))
        // loadCharacter(named: "Talia")
        guard var iesel = loadCharacter(named: "Iesel") as? STOPlayableCharacter else { fatalError() }
        print(iesel.reputations)
    }

    static func getEpisodes() {
        print("Getting episodes")
        let episodes = STOEpisode.all()
        for faction in STOFaction.allCases {
            print("Story arcs for \(faction.description)")
            for arc in faction.arcs.sorted(by: { $0.order < $1.order }) {
                print("\t\(arc.description): \(episodes.filter({ $0.arc == arc }).map({ $0.name }))")
            }
        }
    }

    static func save(character: STOPlayableCharacter) {
        print("Saving character")
        print(character.journal.episodes.sorted(by: { ($0.0.arc.order, $0.0.number) < ($1.0.arc.order, $1.0.number) }))
        print(character.journal.episodes[.Starfleet2409Tutorial])
        character.save()
    }

    @discardableResult
    static func loadCharacter(named name: String) -> STOCharacter? {
        print("Loading character")
        guard let character = STOPlayableCharacter.load(character: name) else { return nil }
        print(character.journal.episodes.completed)
        print(character.journal.episodes.incomplete)
        print(character.journal.episodes[.Starfleet2409Tutorial])
        print(character.journal.episodes[.StarfleetDSCTutorial])
        return character
    }
}
