public protocol DamageType {}

public enum EnergyDamageType: String, DamageType, Codable {
    case Phaser, Disruptor, Plasma
    case Tetryon, Polaron, Antiproton
}

public enum PhysicalDamageType: String, DamageType, Codable {
    case Kinetic, Physical
}

public enum TorpedoKineticDamageType: String, DamageType, Codable {
    case Photon, Quantum, Plasma // Apparently vanilla Plasma torpedoes do kinetic damage
    case Transphasic, Chroniton, Tricobalt
}
