import Foundation

internal protocol StarshipBase: Codable {
    var name: String { get set }

    var foreWeapons: WeaponArray { get }
    var rearWeapons: WeaponArray { get }

    var engConsoles: ConsoleArray<EngineeringConsole> { get }
}

open class Starship: StarshipBase {
    public var name: String
    public private(set) var foreWeapons: WeaponArray
    public private(set) var rearWeapons: WeaponArray

    public private(set) var engConsoles: ConsoleArray<EngineeringConsole>

    internal enum CodingKeys: String, CodingKey {
        case name, `class`
        case foreWeapons, rearWeapons
        case engConsoles
    }

    internal init(name: String, foreWeapons: Int, rearWeapons: Int, engConsoles: Int) {
        self.name = name
        self.foreWeapons = WeaponArray(size: foreWeapons)
        self.rearWeapons = WeaponArray(size: rearWeapons)
        self.engConsoles = ConsoleArray(size: engConsoles)
    }

    public required init(from decoder: Decoder) throws {
        fatalError("You cannot instantiate an abstract starship")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(foreWeapons, forKey: .foreWeapons)
        try container.encode(rearWeapons, forKey: .rearWeapons)
        try container.encode(engConsoles, forKey: .engConsoles)
    }

    public func setForeWeapon<W: Weapon>(slot index: Int, to weapon: W? = nil) {
        foreWeapons[index-1] = weapon
    }

    public func setRearWeapon<W: Weapon>(slot index: Int, to weapon: W? = nil) {
        if let _ = weapon.self as? CannonWeapon.Type { return }
        rearWeapons[index-1] = weapon
    }

    public func setEngineeringConsole<C: Console>(slot index: Int, to console: C? = nil) {
        guard let console = console as? EngineeringConsole else { return }
        engConsoles[index-1] = console 
    }

    internal func decodeLoadout(from container: KeyedDecodingContainer<CodingKeys>) throws {
        let fore = try container.nestedContainer(
            keyedBy: WeaponArray.CodingKeys.self,
            forKey: .foreWeapons
        )
        try decode(weaponsContainer: fore)
        let rear = try container.nestedContainer(
            keyedBy: WeaponArray.CodingKeys.self,
            forKey: .rearWeapons
        )
        try decode(weaponsContainer: rear, true)

        let eng = try container.nestedContainer(
            keyedBy: ConsoleArrayCodingKeys.self,
            forKey: .engConsoles
        )
        try decode(consolesContainer: eng)
    }

    internal func decode(
        weaponsContainer container: KeyedDecodingContainer<WeaponArray.CodingKeys>, 
        _ rear: Bool = false
    ) throws {
        func setWeapon<W: Weapon>(slot index: Int, to weapon: W?) {
            rear ? setRearWeapon(slot: index, to: weapon) : setForeWeapon(slot: index, to: weapon)
        }

        for (index, key) in WeaponArray.CodingKeys.allCases.enumerated() {
            if !container.allKeys.contains(key) { continue }
            if try container.decodeNil(forKey: key) { continue }
            let weaponContainer = try container.nestedContainer(
                keyedBy: WeaponCodingKeys.self,
                forKey: key
            )
            if let className = try? weaponContainer.decode(String.self, forKey: .class) {
                if let type = BeamWeapon.specialTypes[className] {
                    let weapon = try BeamWeapon.decode(from: weaponContainer, as: type.self)
                    setWeapon(slot: index+1, to: weapon)
                } else if let type = CannonWeapon.specialTypes[className] {
                    let weapon = try CannonWeapon.decode(from: weaponContainer, as: type.self)
                    setWeapon(slot: index+1, to: weapon)
                } else if let type = KineticTorpedoWeapon.specialTypes[className] {
                    let weapon = try KineticTorpedoWeapon.decode(from: weaponContainer, as: type.self)
                    setWeapon(slot: index+1, to: weapon)
                } else if let type = EnergyTorpedoWeapon.specialTypes[className] {
                    let weapon = try EnergyTorpedoWeapon.decode(from: weaponContainer, as: type.self)
                    setWeapon(slot: index+1, to: weapon)
                }
            } else if let weapon = try? container.decode(CannonWeapon.self, forKey: key) {
                setWeapon(slot: index+1, to: weapon)
            } else if let weapon = try? container.decode(BeamWeapon.self, forKey: key) {
                setWeapon(slot: index+1, to: weapon)
            } else if let weapon = try? container.decode(KineticTorpedoWeapon.self, forKey: key) {
                setWeapon(slot: index+1, to: weapon)
            }
        }
    }

    internal func decode(consolesContainer container: KeyedDecodingContainer<ConsoleArrayCodingKeys>) throws {
        func setConsole<C: Console>(slot index: Int, to console: C?) {
            if let console = console {
                if let console = console as? EngineeringConsole {
                    setEngineeringConsole(slot: index, to: console)
                // } else if let console = console as? ScienceConsole {
                //     setScienceConsole(slot: index, to: console)
                // } else if let console = console as? TacticalConsole {
                //     setTacticalConsole(slot: index, to: console)
                }
            }
        }

        for (index, key) in ConsoleArrayCodingKeys.allCases.enumerated() {
            if !container.allKeys.contains(key) { continue }
            if try container.decodeNil(forKey: key) { continue }
            let consoleContainer = try container.nestedContainer(
                keyedBy: ConsoleCodingKeys.self,
                forKey: key
            )
            if let className = try? consoleContainer.decode(String.self, forKey: .class) {
                if let type = EngineeringConsole.specialTypes[className] {
                    let console = try EngineeringConsole.decode(from: consoleContainer, as: type)
                    setConsole(slot: index+1, to: console)
                // } else if let type = ScienceConsole.specialTypes[className] {
                //     let console = try ScienceConsole.decode(from: consoleContainer, as: type)
                //     setConsole(slot: index+1, to: console)
                // } else if let type = TacticalConsole.specialTypes[className] {
                //     let console = try TacticalConsole.decode(from: consoleContainer, as: type)
                //     setConsole(slot: index+1, to: console)
                }
            }
        }
    }

    internal static let specialTypes: [String: Starship.Type] = {
        return _specialTypes.reduce([String: Starship.Type]()) { (dict, type) -> [String: Starship.Type] in
            var dict = dict
            dict[String(describing: type.self)] = type.self
            return dict
        }
    }()
    private static let _specialTypes: [Starship.Type] = [
        AssaultCruiser.self,
        LightCruiser.self
    ]
}

extension Starship: CustomStringConvertible {
    public var description: String {
        """
        \(name)
            Fore weapons: \(foreWeapons)
            Rear weapons: \(rearWeapons)
            ----
            Engineering consoles: \(engConsoles)
        """
    }
}

extension Starship {
    public func save() {
        let directoryURL = URL(string: "file:///\(FileManager.default.currentDirectoryPath)")!
            .appendingPathComponent("Output")
            .appendingPathComponent("Ships")
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

    public static func load(named name: String) -> some Starship {
        let fileURL = URL(string: "file:///\(FileManager.default.currentDirectoryPath)")!
            .appendingPathComponent("Output")
            .appendingPathComponent("Ships")
            .appendingPathComponent("\(name).json")
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            fatalError("No ship named \(name) exists")
        }

        let decoder = JSONDecoder()
        if
            let data = try? Data(contentsOf: fileURL),
            let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let shipClass = dict["class"] as? String,
            let shipType = Starship.specialTypes[shipClass],
            let ship = try? decoder.decode(shipType, from: data)
        {
            return ship
        } else {
            fatalError("Could not decode ship named \(name)")
        }
    }
}
