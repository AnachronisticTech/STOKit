import Foundation

public protocol STOCharacter: Codable {
    var faction: STOFaction { get }
    var name: String { get }

    init(name: String, faction: STOFaction)
}

public extension STOCharacter {
    func save() {
        let directoryURL = URL(string: "file:///\(FileManager.default.currentDirectoryPath)")!
            .appendingPathComponent("Characters")
        if !FileManager.default.fileExists(atPath: directoryURL.path) {
            try! FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true)
        }
        let fileURL = directoryURL.appendingPathComponent("\(name).json")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            try data.write(to: fileURL)
        } catch {
            print(error)
        }
    }

    static func load(character name: String) -> STOPlayableCharacter? {
        let fileURL = URL(string: "file:///\(FileManager.default.currentDirectoryPath)")!
            .appendingPathComponent("Characters")
            .appendingPathComponent("\(name).json")
        if !FileManager.default.fileExists(atPath: fileURL.path) { return nil }
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(STOPlayableCharacter.self, from: try Data(contentsOf: fileURL))
        } catch {
            print(error)
            return nil
        }
    }
}
