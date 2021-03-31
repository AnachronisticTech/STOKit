open class KineticTorpedoWeapon: Weapon {
    public var mark: Mark
    public var quality: Quality

    private let _weaponType: TorpedoWeaponType!
    public var weaponType: some WeaponType {
        _weaponType
    }

    private let _damageType: TorpedoKineticDamageType!
    public var damageType: some DamageType {
        _damageType
    }

    public required init(
        _ weaponType: TorpedoWeaponType, 
        _ damageType: TorpedoKineticDamageType, 
        _ mark: Mark, 
        _ quality: Quality
    ) {
        self._weaponType = weaponType
        self._damageType = damageType
        self.mark = mark
        self.quality = quality
    }

    public var description: String {
        return "\(weaponType)\(damageType) Torpedo Launcher - Mk \(mark) \(quality)"
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WeaponCodingKeys.self)
        self.mark = try container.decode(Mark.self, forKey: .mark)
        self.quality = try container.decode(Quality.self, forKey: .quality)
        self._weaponType = try container.decode(TorpedoWeaponType.self, forKey: ._weaponType)
        self._damageType = try container.decode(TorpedoKineticDamageType.self, forKey: ._damageType)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: WeaponCodingKeys.self)
        try container.encode(mark, forKey: .mark)
        try container.encode(quality, forKey: .quality)
        try container.encode(_weaponType, forKey: ._weaponType)
        try container.encode(_damageType, forKey: ._damageType)
    }

    internal static func decode<W: KineticTorpedoWeapon>(from container: KeyedDecodingContainer<WeaponCodingKeys>, as type: W.Type) throws -> W {
        let mark = try container.decode(Mark.self, forKey: .mark)
        let quality = try container.decode(Quality.self, forKey: .quality)
        let weaponType = try container.decode(TorpedoWeaponType.self, forKey: ._weaponType)
        let damageType = try container.decode(TorpedoKineticDamageType.self, forKey: ._damageType)
        return type.init(weaponType, damageType, mark, quality)
    }
}
