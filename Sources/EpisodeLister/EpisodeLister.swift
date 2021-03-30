import STOKit
import Foundation

@main
struct EpisodeLister {
    static func main() {
        // getEpisodes()

        // let boff = BridgeOfficer(name: "Jessica", faction: .Starfleet2409, career: .Tactical, "47B2B728-566A-41E0-845F-DC630BBFBC72")
        // let id = boff.identifier
        // boff.save()
        // guard let jessica = BridgeOfficer.load(with: id) else { fatalError() }
        // print(jessica.name)

        // var character = PlayableCharacter(name: "Talia", faction: .Starfleet2409, career: .Engineering)
        // character.journal.episodes[Episode(name: "Graduation Day", arc: .StarfleetDSCTutorial, number: 1)] = true
        // character.reputations[.Omega].set(xp: 7500)
        // character.bridgeOfficers.append(jessica)
        // character.save()
        // guard let talia = PlayableCharacter.load("Talia") else { fatalError() }
        // print("eps: \(talia.journal.episodes.sorted())")
        // print("reps: \(talia.reputations.sorted())")
        // print("boffs: \(talia.bridgeOfficers)")

        print("")
        let ship = LightCruiser("U.S.S. Miranda")
        print(ship)
        ship.setForeWeapon(slot: 1, to: BeamWeapon(.BeamArray, .Phaser, .I, .Common))
        ship.setForeWeapon(slot: 2, to: KineticTorpedoWeapon(.Standard, .Photon, .I, .Common))
        ship.setRearWeapon(slot: 1, to: CannonWeapon(.Single, .Disruptor, .II, .Uncommon))
        print(ship)
        ship.save()
        print(Starship.load(named: "U.S.S. Miranda"))
        
        let newShip = AssaultCruiser("U.S.S. Pearce")
        print(newShip)
        newShip.setForeWeapon(slot: 4, to: BeamWeapon(.BeamArray, .Phaser, .XV, .Epic))
        newShip.setForeWeapon(slot: 2, to: BeamWeapon(.BeamArray, .Phaser, .XV, .Epic))
        newShip.setForeWeapon(slot: 3, to: PhaserQuadCannons(.XV, .Epic))
        newShip.setForeWeapon(slot: 1, to: KineticTorpedoWeapon(.WideAngle, .Quantum, .XV, .Epic))
        newShip.setRearWeapon(slot: 1, to: CannonWeapon(.Single, .Disruptor, .II, .Uncommon))
        newShip.setRearWeapon(slot: 2, to: PhotonTorpedo(.XV, .Epic))
        newShip.setRearWeapon(slot: 4, to: AncientAntiprotonOmniBeamArray(.XV, .Epic))
        print(newShip)
        newShip.save()
        print(Starship.load(named: "U.S.S. Pearce"))
    }

    static func getEpisodes() {
        print("Getting episodes")
        let episodes = Episode.all()
        for faction in Faction.allCases {
            print("Story arcs for \(faction.description)")
            for arc in faction.arcs.sorted() {
                print("\t\(arc.description): \(episodes.filter({ $0.arc == arc }).sorted().map({ $0.name }))")
            }
        }
    }
}
