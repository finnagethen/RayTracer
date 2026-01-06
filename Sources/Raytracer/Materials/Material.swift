protocol Material {
    var color: Vec3 { get }

    func emit() -> Vec3
}
