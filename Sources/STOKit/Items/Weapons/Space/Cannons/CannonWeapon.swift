open class CannonWeapon: Weapon {
    private let _weaponType: CannonWeaponType!
    public var weaponType: some WeaponType {
        _weaponType
    }

    private let _damageType: EnergyDamageType!
    public var damageType: some DamageType {
        _damageType
    }

    public required init(
        _ weaponType: CannonWeaponType, 
        _ damageType: EnergyDamageType, 
        _ mark: Mark, 
        _ quality: Quality
    ) {
        self._weaponType = weaponType
        self._damageType = damageType
        super.init(mark: mark, quality: quality)
    }

    public override var description: String {
        return "\(damageType) \(weaponType) - Mk \(mark) \(quality)"
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self._weaponType = try container.decode(CannonWeaponType.self, forKey: ._weaponType)
        self._damageType = try container.decode(EnergyDamageType.self, forKey: ._damageType)
        super.init(
            mark: try container.decode(Mark.self, forKey: .mark),
            quality: try container.decode(Quality.self, forKey: .quality)
        )
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(_weaponType, forKey: ._weaponType)
        try container.encode(_damageType, forKey: ._damageType)
        try super.encode(to: encoder)
    }

    private static func decode<W: CannonWeapon>(from container: KeyedDecodingContainer<Keys>, as type: W.Type) throws -> W {
        let mark = try container.decode(Mark.self, forKey: .mark)
        let quality = try container.decode(Quality.self, forKey: .quality)
        let weaponType = try container.decode(CannonWeaponType.self, forKey: ._weaponType)
        let damageType = try container.decode(EnergyDamageType.self, forKey: ._damageType)
        return type.init(weaponType, damageType, mark, quality)
    }

    internal override class func decode(container: KeyedDecodingContainer<Keys>) -> Self? {
        guard
            let className = try? container.decode(String.self, forKey: .class),
            let type = specialTypes[className],
            let item = try? decode(from: container, as: type) as? Self
        else {
            return nil
        }
        return item
    }
}
