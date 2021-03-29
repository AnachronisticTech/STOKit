import Foundation

internal protocol STOStarshipBase: Codable {
    var name: String { get set }

    var foreWeapons: STOWeaponArray { get }
    var rearWeapons: STOWeaponArray { get }
}

open class STOStarship: STOStarshipBase {
    public var name: String
    public private(set) var foreWeapons: STOWeaponArray
    public private(set) var rearWeapons: STOWeaponArray

    enum CodingKeys: String, CodingKey {
        case name, foreWeapons, rearWeapons
    }

    internal init(name: String, foreWeapons: Int, rearWeapons: Int) {
        self.name = name
        self.foreWeapons = STOWeaponArray(size: foreWeapons)
        self.rearWeapons = STOWeaponArray(size: rearWeapons)
    }

    public required init(from decoder: Decoder) throws {
        fatalError("You cannot instantiate an abstract starship")
    }

    public func setForeWeapon<W: STOWeapon>(slot index: Int, to weapon: W? = nil) {
        foreWeapons[index-1] = weapon
    }

    public func setRearWeapon<W: STOWeapon>(slot index: Int, to weapon: W? = nil) {
        if let _ = weapon.self as? STOCannonWeapon.Type { return }
        rearWeapons[index-1] = weapon
    }

    internal func decodeLoadout(from container: KeyedDecodingContainer<CodingKeys>) throws {
        let fore = try container.nestedContainer(
            keyedBy: STOWeaponArray.CodingKeys.self,
            forKey: .foreWeapons
        )
        try decode(weaponsContainer: fore)
        let rear = try container.nestedContainer(
            keyedBy: STOWeaponArray.CodingKeys.self,
            forKey: .rearWeapons
        )
        try decode(weaponsContainer: rear, true)
    }

    func decode(
        weaponsContainer container: KeyedDecodingContainer<STOWeaponArray.CodingKeys>, 
        _ rear: Bool = false
    ) throws {
        @inline(__always) func setWeapon<W: STOWeapon>(slot index: Int, to weapon: W?) {
            rear ? setRearWeapon(slot: index, to: weapon) : setForeWeapon(slot: index, to: weapon)
        }

        for (index, key) in STOWeaponArray.CodingKeys.allCases.enumerated() {
            if !container.allKeys.contains(key) { continue }
            if try container.decodeNil(forKey: key) { continue }
            let weaponContainer = try container.nestedContainer(
                keyedBy: STOWeaponCodingKeys.self,
                forKey: key
            )
            if 
                let className = try? weaponContainer.decode(String.self, forKey: .class),
                let type = STOBeamWeapon.specialTypes[className]
            {
                let mark = try weaponContainer.decode(STOMark.self, forKey: .mark)
                let quality = try weaponContainer.decode(STOQuality.self, forKey: .quality)
                let weaponType = try weaponContainer.decode(STOBeamWeaponType.self, forKey: ._weaponType)
                let damageType = try weaponContainer.decode(STOEnergyDamageType.self, forKey: ._damageType)
                let weapon = type.init(weaponType, damageType, mark, quality)
                setWeapon(slot: index+1, to: weapon)
            } else if let weapon = try? container.decode(STOCannonWeapon.self, forKey: key) {
                setWeapon(slot: index+1, to: weapon)
            } else if let weapon = try? container.decode(STOBeamWeapon.self, forKey: key) {
                setWeapon(slot: index+1, to: weapon)
            } else if let weapon = try? container.decode(STOKineticTorpedoWeapon.self, forKey: key) {
                setWeapon(slot: index+1, to: weapon)
            }
        }
    }
}

extension STOStarship: CustomStringConvertible {
    public var description: String {
        """
        \(name)
            Fore weapons: \(foreWeapons)
            Rear weapons: \(rearWeapons)
        """
    }
}
