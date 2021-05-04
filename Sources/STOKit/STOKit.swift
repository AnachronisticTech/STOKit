import Foundation

// test new features here before moving them to files

// internal struct Types {
//     private static let dictionaries: [[String: Item.Type]] = [
//         BeamWeapon.specialTypes,
//         CannonWeapon.specialTypes,
//         KineticTorpedoWeapon.specialTypes,
//         EngineeringConsole.specialTypes,
//         ScienceConsole.specialTypes,
//         TacticalConsole.specialTypes,
//         Deflector.specialTypes,
//     ]
//     internal static let masterList: [String: Item.Type] = {
//         var dictionary = [String: Item.Type]()
//         for dict in dictionaries {
//             dictionary.merge(dict) { current, _ in current }
//         }
//         return dictionary
//     }()

//     // internal static func type(named: String) -> some Item.Type {
//     //     if let type = BeamWeapon.specialTypes[type] {
//     //         return type
//     //     }
//     //     return BeamWeapon.self
//     // }

//     private static let types: [(Item.Type, [String: Item.Type])] = [
//         (BeamWeapon.self, BeamWeapon.specialTypes),
//         (CannonWeapon.self, CannonWeapon.specialTypes),
//         (KineticTorpedoWeapon.self, KineticTorpedoWeapon.specialTypes),
//         (EnergyTorpedoWeapon.self, EnergyTorpedoWeapon.specialTypes),
//         (EngineeringConsole.self, EngineeringConsole.specialTypes),
//         (ScienceConsole.self, ScienceConsole.specialTypes),
//         (TacticalConsole.self, TacticalConsole.specialTypes),
//         (Deflector.self, Deflector.specialTypes),
//     ]
//     internal static func supertype(of subtype: Item.Type) -> Item.Type? {
//         for (type, dict) in types {
//             if dict[String(describing: subtype)] != nil { return type }
//         }
//         return nil
//     }
// }


public struct Inventory {
    public typealias Items = [Item?]

    private var items: Items

    public init(size: Int = 72) {
        @Clamped(72...216) var _size = size
        items = Array(repeating: nil, count: _size)
    }

    public subscript(index: Int) -> Item? {
        get {
            guard (0..<items.count).contains(index) else { return nil }
            return items[index]
        }
        set {
            guard (0..<items.count).contains(index) else { return }
            items[index] = newValue
        }
    }
}

extension Inventory: CustomStringConvertible {
    public var description: String {
        let compact = items.compactMap { $0 }
        return "\(compact)"
//         return items
//             .compactMap { item in
//                 guard let item = item else { return nil }
//                 return "\(item)"
//             }
//             .joined(separator: "\n\t")
    }
}

extension Inventory: Codable {
    enum CodingKeys: CodingKey {
        case size
        case items
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = Array(repeating: nil, count: try container.decode(Int.self, forKey: .size))
        var itemsContainer = try container.nestedUnkeyedContainer(forKey: .items)
        var counter = 0
        while !itemsContainer.isAtEnd {
            if try itemsContainer.decodeNil() {
                counter += 1
                continue
            }

            let itemContainer = try itemsContainer.nestedContainer(keyedBy: WeaponCodingKeys.self)
            if let className = try? itemContainer.decode(String.self, forKey: .class) {
                print(className)
                // Item.decode(container: itemContainer)
                self.items[counter] = Weapon.decode(container: itemContainer)
            }
            counter += 1
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(items.count, forKey: .size)
        try container.encode(items, forKey: .items)
    }
}
