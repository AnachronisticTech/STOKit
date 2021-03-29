import STOKit
import Foundation

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
        ship.setForeWeapon(slot: 1, to: STOBeamWeapon(.BeamArray, .Phaser, .I, .Common))
        ship.setForeWeapon(slot: 2, to: STOKineticTorpedoWeapon(.Standard, .Photon, .I, .Common))
        ship.setRearWeapon(slot: 1, to: STOCannonWeapon(.Single, .Disruptor, .II, .Uncommon))
        print(ship)
        
        let newShip = AssaultCruiser("U.S.S. Pearce")
        print(newShip)
        newShip.setForeWeapon(slot: 4, to: STOBeamWeapon(.BeamArray, .Phaser, .XV, .Epic))
        newShip.setForeWeapon(slot: 2, to: STOBeamWeapon(.BeamArray, .Phaser, .XV, .Epic))
        newShip.setForeWeapon(slot: 3, to: STOBeamWeapon(.BeamArray, .Phaser, .XV, .Epic))
        newShip.setForeWeapon(slot: 1, to: STOKineticTorpedoWeapon(.WideAngle, .Quantum, .XV, .Epic))
        newShip.setRearWeapon(slot: 1, to: STOCannonWeapon(.Single, .Disruptor, .II, .Uncommon))
        newShip.setRearWeapon(slot: 2, to: PhotonTorpedo(.XV, .Epic))
        newShip.setRearWeapon(slot: 4, to: AncientAntiprotonOmniBeamArray(.XV, .Epic))
        print(newShip)

        let directoryURL = URL(string: "file:///\(FileManager.default.currentDirectoryPath)")!
            .appendingPathComponent("Characters")
        if !FileManager.default.fileExists(atPath: directoryURL.path) {
            try! FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true)
        }
        let fileURL = directoryURL.appendingPathComponent("ship.json")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(newShip)
            try data.write(to: fileURL)
        } catch {
            print(error)
        }
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL)
            let assaultCruiser = try decoder.decode(AssaultCruiser.self, from: data)
            print(assaultCruiser)
        } catch {
            print(error)
        }
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
