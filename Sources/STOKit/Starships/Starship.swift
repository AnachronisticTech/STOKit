import Foundation

internal protocol StarshipBase: Codable {
    var name: String { get set }
    var className: String { get }
    var canEquipDualCannons: Bool { get }

    var foreWeapons: ComponentArray<Weapon> { get }
    var rearWeapons: ComponentArray<Weapon> { get }

    var engConsoles: ComponentArray<EngineeringConsole> { get }
    var sciConsoles: ComponentArray<ScienceConsole> { get }
    var tacConsoles: ComponentArray<TacticalConsole> { get }

    var deflector: Deflector? { get }
}

open class Starship: StarshipBase {
    public var name: String
    public var className: String { String(describing: type(of: self)) }
    var canEquipDualCannons: Bool { false }

    public private(set) var foreWeapons: ComponentArray<Weapon>
    public private(set) var rearWeapons: ComponentArray<Weapon>

    public private(set) var engConsoles: ComponentArray<EngineeringConsole>
    public private(set) var sciConsoles: ComponentArray<ScienceConsole>
    public private(set) var tacConsoles: ComponentArray<TacticalConsole>

    public var deflector: Deflector?

    internal enum CodingKeys: String, CodingKey {
        case name, `class`
        case foreWeapons, rearWeapons
        case engConsoles, sciConsoles, tacConsoles
        case deflector
    }

    internal init(
        name: String,
        foreWeapons: Int,
        rearWeapons: Int,
        engConsoles: Int,
        sciConsoles: Int,
        tacConsoles: Int
    ) {
        self.name = name
        self.foreWeapons = ComponentArray(size: foreWeapons)
        self.rearWeapons = ComponentArray(size: rearWeapons)
        self.engConsoles = ComponentArray(size: engConsoles)
        self.sciConsoles = ComponentArray(size: sciConsoles)
        self.tacConsoles = ComponentArray(size: tacConsoles)
        self.deflector = nil
    }

    public required init(from decoder: Decoder) throws {
        fatalError("You cannot instantiate an abstract starship")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(String(describing: type(of: self)), forKey: .class)
        try container.encode(foreWeapons, forKey: .foreWeapons)
        try container.encode(rearWeapons, forKey: .rearWeapons)
        try container.encode(engConsoles, forKey: .engConsoles)
        try container.encode(sciConsoles, forKey: .sciConsoles)
        try container.encode(tacConsoles, forKey: .tacConsoles)
        try container.encode(deflector, forKey: .deflector)
    }

    internal func setForeWeapon<W: Weapon>(slot index: Int, to weapon: W? = nil) {
        foreWeapons[index-1] = weapon
    }

    internal func setRearWeapon<W: Weapon>(slot index: Int, to weapon: W? = nil) {
        rearWeapons[index-1] = weapon
    }

    internal func setEngineeringConsole<C: Console>(slot index: Int, to console: C? = nil) {
        guard let console = console as? EngineeringConsole else { return }
        engConsoles[index-1] = console
    }

    internal func setScienceConsole<C: Console>(slot index: Int, to console: C? = nil) {
        guard let console = console as? ScienceConsole else { return }
        sciConsoles[index-1] = console
    }

    internal func setTacticalConsole<C: Console>(slot index: Int, to console: C? = nil) {
        guard let console = console as? TacticalConsole else { return }
        tacConsoles[index-1] = console
    }

    public subscript(fore index: Int) -> Weapon? {
        get {
            guard (0..<foreWeapons.count).contains(index - 1) else { return nil }
            return foreWeapons[index - 1]
        }
        set {
            guard (0..<foreWeapons.count).contains(index - 1) else { return }
            guard newValue == nil || newValue!.isForeWeapon else { return }
            foreWeapons[index - 1] = newValue
        }
    }

    public subscript(rear index: Int) -> Weapon? {
        get {
            guard (0..<rearWeapons.count).contains(index - 1) else { return nil }
            return rearWeapons[index - 1]
        }
        set {
            guard (0..<foreWeapons.count).contains(index - 1) else { return }
            guard newValue == nil || newValue!.isRearWeapon else { return }
            rearWeapons[index - 1] = newValue
        }
    }

    public subscript(eng index: Int) -> Console? {
        get {
            guard (0..<engConsoles.count).contains(index - 1) else { return nil }
            return engConsoles[index - 1]
        }
        set {
            guard (0..<engConsoles.count).contains(index - 1) else { return }
            guard let console = newValue as? EngineeringConsole else { return }
            engConsoles[index - 1] = console
        }
    }

    public subscript(sci index: Int) -> Console? {
        get {
            guard (0..<sciConsoles.count).contains(index - 1) else { return nil }
            return sciConsoles[index - 1]
        }
        set {
            guard (0..<sciConsoles.count).contains(index - 1) else { return }
            guard let console = newValue as? ScienceConsole else { return }
            sciConsoles[index - 1] = console
        }
    }

    public subscript(tac index: Int) -> Console? {
        get {
            guard (0..<tacConsoles.count).contains(index - 1) else { return nil }
            return tacConsoles[index - 1]
        }
        set {
            guard (0..<tacConsoles.count).contains(index - 1) else { return }
            guard let console = newValue as? TacticalConsole else { return }
            tacConsoles[index - 1] = console
        }
    }

    internal func decodeLoadout(from container: KeyedDecodingContainer<CodingKeys>) throws {
        let groupKeys: [CodingKeys] = [.engConsoles, .sciConsoles, .tacConsoles, .foreWeapons, .rearWeapons]
        for group in groupKeys {
            try decode(container:
                try container.nestedContainer(
                    keyedBy: ComponentArrayCodingKeys.self,
                    forKey: group
                ), forKey: group
            )
        }

        if let deflectorContainer = try? container.nestedContainer(
            keyedBy: ItemCodingKeys.self,
            forKey: .deflector
        ) {
            deflector = Deflector.decode(container: deflectorContainer)
        }
    }

    private func decode(container: KeyedDecodingContainer<ComponentArrayCodingKeys>, forKey group: CodingKeys) throws {
        for (index, key) in ComponentArrayCodingKeys.allCases.enumerated() {
            if !container.allKeys.contains(key) { continue }
            if try container.decodeNil(forKey: key) { continue }
            let itemContainer = try container.nestedContainer(
                keyedBy: ItemCodingKeys.self,
                forKey: key
            )
            setItem(in: group, slot: index+1, to: Item.decode(container: itemContainer))
        }
    }

    private func setItem(in group: CodingKeys, slot index: Int, to item: Item?) {
        guard let item = item else { return }
        switch group {
            case .engConsoles:
                guard let item = item as? Console else { return }
                self[eng: index] = item
            case .sciConsoles:
                guard let item = item as? Console else { return }
                self[sci: index] = item
            case .tacConsoles:
                guard let item = item as? Console else { return }
                self[tac: index] = item
            case .foreWeapons:
                guard let item = item as? Weapon else { return }
                self[fore: index] = item
            case .rearWeapons:
                guard let item = item as? Weapon else { return }
                self[rear: index] = item
            default: return
        }
    }
}

extension Starship: CustomStringConvertible {
    public var description: String {
        """
        \(name) - \(className)
            Fore weapons         : \(foreWeapons)
            Deflector            : \(deflector != nil ? String(describing: deflector!) : "Empty")
            Rear weapons         : \(rearWeapons)
            ----------------------
            Engineering consoles : \(engConsoles)
            Science consoles     : \(sciConsoles)
            Tactical consoles    : \(tacConsoles)
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

    public static func load(from string: String) -> some Starship {
        let decoder = JSONDecoder()
        if
            let data = string.data(using: .utf8),
            let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let shipClass = dict["class"] as? String,
            let shipType = Starship.specialTypes[shipClass],
            let ship = try? decoder.decode(shipType, from: data)
        {
            return ship
        } else {
            fatalError("Could not decode ship from provided string")
        }
    }
}
