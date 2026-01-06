struct LightMaterial: Material {
    private let  _value: Vec3

    var color: Vec3 {
        return _value
    }

    init(color: Vec3) {
        _value = color
    }

    func emit() -> Vec3 {
        return color
    }
}
