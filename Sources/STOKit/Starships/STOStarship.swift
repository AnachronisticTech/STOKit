internal protocol STOStarshipBase {
    var name: String { get set }

    var foreWeapons: STOWeaponArray { get }
    var rearWeapons: STOWeaponArray { get }
}

open class STOStarship: STOStarshipBase {
    public var name: String
    public private(set) var foreWeapons: STOWeaponArray
    public private(set) var rearWeapons: STOWeaponArray

    internal init(name: String, foreWeapons: Int, rearWeapons: Int) {
        self.name = name
        self.foreWeapons = STOWeaponArray(size: foreWeapons)
        self.rearWeapons = STOWeaponArray(size: rearWeapons)
    }

    public func setForeWeapon(slot index: Int, to weapon: STOWeapon? = nil) {
        foreWeapons[index-1] = weapon
    }

    public func setRearWeapon<W: STOWeapon>(slot index: Int, to weapon: W? = nil) {
        if let _ = weapon.self as? STOCannonWeapon.Type { return }
        rearWeapons[index-1] = weapon
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
