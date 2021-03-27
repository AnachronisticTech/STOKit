import STOKit

@main
struct EpisodeLister {
    static func main() {
        // getEpisodes()

        // let boff = STOBridgeOfficer(name: "Jessica", faction: .Starfleet2409, career: .Tactical, "47B2B728-566A-41E0-845F-DC630BBFBC72")
        // let id = boff.identifier
        // boff.save()
        // guard let jessica = STOBridgeOfficer.load(with: id) else { fatalError() }
        // print(jessica.name)

        // var character = STOPlayableCharacter(name: "Talia", faction: .Starfleet2409, career: .Engineering)
        // character.journal.episodes[STOEpisode(name: "Graduation Day", arc: .StarfleetDSCTutorial, number: 1)] = true
        // character.reputations[.Omega].set(xp: 7500)
        // character.bridgeOfficers.append(jessica)
        // character.save()
        // guard let talia = STOPlayableCharacter.load("Talia") else { fatalError() }
        // // print("eps: \(talia.journal.episodes.sorted())")
        // // print("reps: \(talia.reputations.sorted())")
        // print("boffs: \(talia.bridgeOfficers)")

        print("")
        let ship = LightCruiser("Hello world")
        print(ship)
        ship.setForeWeapon(slot: 1, to: STOBeamArray(.Phaser, .I, .Common))
        ship.setForeWeapon(slot: 2, to: STOPhotonTorpedo(.I, .Common))
        ship.setRearWeapon(slot: 1, to: STOSingleCannon(.Disruptor, .II, .Uncommon))
        print(ship)
        
        let newShip = AssaultCruiser("U.S.S. Pearce")
        print(newShip)
        newShip.setForeWeapon(slot: 1, to: STOBeamArray(.Phaser, .XV, .Epic))
        newShip.setForeWeapon(slot: 2, to: STOBeamArray(.Phaser, .XV, .Epic))
        newShip.setForeWeapon(slot: 3, to: STOBeamArray(.Phaser, .XV, .Epic))
        newShip.setForeWeapon(slot: 4, to: STOPhotonTorpedo(.XV, .Epic))
        newShip.setRearWeapon(slot: 1, to: STOSingleCannon(.Disruptor, .XV, .Epic))
        newShip.setRearWeapon(slot: 4, to: AncientAntiprotonOmniBeamArray(.XV, .Epic))
        print(newShip)
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
