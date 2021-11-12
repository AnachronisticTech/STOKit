public class PatrolEscortRefit: Starship {
    public override var className: String {
        "Tempest Patrol Escort Refit"
    }

    override var canEquipDualCannons: Bool { true }

    public init(_ name: String) {
        super.init(
            name: name,
            foreWeapons: 4,
            rearWeapons: 4,
            engConsoles: 2,
            sciConsoles: 2,
            tacConsoles: 5
        )
        setRearWeapon(slot: 4, to: TempestTailGun(.XII, .Epic))
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        super.init(
            name: name,
            foreWeapons: 4,
            rearWeapons: 4,
            engConsoles: 2,
            sciConsoles: 2,
            tacConsoles: 5
        )
        try super.decodeLoadout(from: container)
        setRearWeapon(slot: 4, to: TempestTailGun(.XII, .Epic))
    }

    public override subscript(rear index: Int) -> Weapon? {
        get { super[rear: index] }
        set {
            if index == 4 { return }
            else { super[rear: index] = newValue }
        }
    }
}
