struct Vec3 {
    var x: Double
    var y: Double
    var z: Double

    init (_ x: Double = 0.0, _ y: Double = 0.0, _ z: Double = 0.0) {
        self.x = x
        self.y = y
        self.z = z
    }

    func mult(other: Vec3) -> Vec3 {
        return Vec3(x * other.x, y * other.y, z * other.z)
    }

    func add(other: Vec3) -> Vec3 {
        return Vec3(x + other.x, y + other.y, z + other.z)
    }

    func sub(other: Vec3) -> Vec3 {
        return Vec3(x - other.x, y - other.y, z - other.z)
    }

    func scale(scalar: Double) -> Vec3 {
        return Vec3(x * scalar, y * scalar, z * scalar)
    }

    func dot(other: Vec3) -> Double {
        return x * other.x + y * other.y + z * other.z
    }

    func length() -> Double {
        return (x * x + y * y + z * z).squareRoot()
    }

    func normalized() -> Vec3 {
        let len = self.length()
        return Vec3(x / len, y / len, z / len)
    }

    func clamp01() -> Vec3 {
        return Vec3(
            max(0.0, min(1.0, x)),
            max(0.0, min(1.0, y)),
            max(0.0, min(1.0, z))
        )
    }
}
