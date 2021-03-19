import STOKit

@main
struct EpisodeLister {
    static func main() {
        // getEpisodes()

        let boff = STOBridgeOfficer(name: "Jessica", faction: .Starfleet2409, career: .Tactical, "47B2B728-566A-41E0-845F-DC630BBFBC72")
        let id = boff.identifier
        boff.save()
        guard let jessica = STOBridgeOfficer.load(with: id) else { fatalError() }
        print(jessica.name)

        var character = STOPlayableCharacter(name: "Talia", faction: .Starfleet2409, career: .Engineering)
        character.journal.episodes[STOEpisode(name: "Graduation Day", arc: .StarfleetDSCTutorial, number: 1)] = true
        character.reputations[.Omega].set(xp: 7500)
        character.bridgeOfficers.append(jessica)
        character.save()
        guard let talia = STOPlayableCharacter.load("Talia") else { fatalError() }
        // print("eps: \(talia.journal.episodes.sorted())")
        // print("reps: \(talia.reputations.sorted())")
        print("boffs: \(talia.bridgeOfficers)")
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
}
