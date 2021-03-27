public protocol STODamageType {}

public enum STOEnergyDamageType: STODamageType {
    case Phaser, Disruptor, Plasma
    case Tetryon, Polaron, Antiproton
}

public enum STOPhysicalDamageType: STODamageType {
    case Kinetic, Physical
}
