import STOKit
import Foundation
import SQLite

@main
struct EpisodeLister {
    static func main() {
        characters()
        ships()
    }

    static func getEpisodes() {
        print("Getting episodes")
        let episodes = Episode.all()
        for faction in Faction.allCases {
            print("Story arcs for \(faction)")
            for arc in faction.arcs.sorted() {
                print("\t\(arc): \(episodes.filter({ $0.arc == arc }).sorted().map({ $0.name }))")
            }
        }
    }

    static func saveEpisodesToDB() {
        print("Saving episodes")
        guard let db = try? getDatabase() else {
            print("Could not get database")
            return
        }
        let episodesTable = Table("episodes")
        let id = Expression<String>("id")
        let name = Expression<String>("name")
        let arc = Expression<String>("arc")
        let number = Expression<Int>("number")
        do {
            try db.run(episodesTable.drop())
        } catch {
            print("Could not delete table: episodesTable")
        }
        do {
            try db.run(episodesTable.create { table in
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(arc)
                table.column(number)
            })
        } catch {
            print("Could not create table")
        }
        let episodes = Episode.all()
        for episode in episodes {
            let insert = episodesTable.insert(
                id <- episode.id.description, 
                name <- episode.name,
                arc <- episode.arc.description,
                number <- episode.number
            )
            let _ = try? db.run(insert)
        }
        print("Save complete")
    }

    static func characters() {
        let boff = BridgeOfficer(name: "Jessica", faction: .Starfleet2409, career: .Tactical, "47B2B728-566A-41E0-845F-DC630BBFBC72")
        let id = boff.identifier
        boff.save()
        guard let jessica = BridgeOfficer.load(with: id) else { fatalError() }
        print(jessica.name)

        var character = PlayableCharacter(name: "Talia", faction: .Starfleet2409, career: .Engineering)
        if let episode = character.journal.episodes
            .filter({ $0.arc == .Starfleet2409Tutorial })
            .first(where: { $0.number == 1 }) {
            character.journal.episodes[episode] = true
        }
        for episode in character.journal.episodes.filter({ $0.number == 3}) {
            character.journal.episodes[episode].toggle()
        }
        character.reputations[.Omega].set(xp: 7500)
        character.bridgeOfficers.append(jessica)
        character.inventory[0] = BeamWeapon(.DualBeamBank, .Polaron, .II, .Uncommon)
        character.inventory[1] = BeamWeapon(.DualBeamBank, .Tetryon, .VI, .Rare)
        character.inventory[2] = AncientAntiprotonOmniBeamArray(.XII, .VeryRare)
        character.inventory[3] = NeutroniumAlloy(.X, .Uncommon)

        character.inventory[4] = Deflector()
        character.inventory[5] = GravitonDeflector(.II, .UltraRare)
        character.inventory[6] = NeutrinoDeflector()
        character.inventory[7] = PositronDeflector(.II, .UltraRare)
        character.inventory[8] = TachyonDeflector()
        character.inventory[9] = AdvancedPositronDeflector()
        character.inventory[10] = FleetInterventionDeflector()
        character.inventory[11] = AssimilatedDeflector()
        character.inventory[12] = AdaptedHonorGuardGravitonDeflector()
        character.inventory[13] = PrevailingBolsteredDeflector()
        character.inventory[14] = BraydonReconnaissanceDeflector()
        character.inventory[15] = SolanaeDeflector()
        character.inventory[16] = SubatomicSDeflector()
        character.inventory[17] = RevolutionaryDeflector()

        character.save()
        guard let talia = PlayableCharacter.load("Talia") else { fatalError() }
        // print("eps: \(talia.journal.episodes.sorted())")
        print("reps: \(talia.reputations.sorted())")
        print("boffs: \(talia.bridgeOfficers)")
        print("completed: \(talia.journal.episodes.completed)")
        print("inventory: \(talia.inventory)")
    }

    static func ships() {
        print("")
        let ship = LightCruiser("U.S.S. Miranda")
        print(ship)
        ship.setForeWeapon(slot: 1, to: BeamWeapon(.BeamArray, .Phaser, .I, .Common))
        ship.setForeWeapon(slot: 2, to: KineticTorpedoWeapon(.Standard, .Photon, .I, .Common))
        ship.setRearWeapon(slot: 1, to: CannonWeapon(.Single, .Disruptor, .II, .Uncommon))
        print(ship)
        ship.save()
        print(Starship.load(named: "U.S.S. Miranda"))
        
        let newShip = FleetImperialIntelAssaultCruiserT6("U.S.S. Pearce")
        print(newShip)
        newShip.setForeWeapon(slot: 4, to: BeamWeapon(.BeamArray, .Phaser, .XV, .Epic))
        newShip.setForeWeapon(slot: 2, to: BeamWeapon(.BeamArray, .Phaser, .XV, .Epic))
        newShip.setForeWeapon(slot: 3, to: PhaserQuadCannons(.XV, .Epic))
        newShip.setForeWeapon(slot: 1, to: KineticTorpedoWeapon(.WideAngle, .Quantum, .XV, .Epic))
        newShip.setRearWeapon(slot: 1, to: CannonWeapon(.Single, .Disruptor, .II, .Uncommon))
        newShip.setRearWeapon(slot: 2, to: PhotonTorpedo(.XV, .Epic))
        newShip.setRearWeapon(slot: 3, to: BeamWeapon(.DualBeamBank, .Phaser, .XV, .Epic))
        newShip.setRearWeapon(slot: 4, to: AncientAntiprotonOmniBeamArray(.XV, .Epic))
        newShip.setEngineeringConsole(slot: 1, to: NeutroniumAlloy(.XV, .Epic))
        newShip.setTacticalConsole(slot: 1, to: PhaserRelay(.XV, .Epic))
        newShip.setScienceConsole(slot: 1, to: FieldGenerator(.XV, .Epic))
        newShip.deflector = PositronDeflector(.IV, .Rare)
        print(newShip)
        newShip.save()
        print(Starship.load(named: "U.S.S. Pearce"))
    }

    static func getDatabase() throws -> Connection {
        let directoryURL = URL(string: "file:///\(FileManager.default.currentDirectoryPath)")!
            .appendingPathComponent("Output")
        if !FileManager.default.fileExists(atPath: directoryURL.path) {
            try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true)
        }
        let fileURL = directoryURL.appendingPathComponent("db.sqlite3")
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            FileManager.default.createFile(atPath: fileURL.path, contents: nil)
        }
        return try Connection(fileURL.path)
    }
}
