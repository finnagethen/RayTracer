class Camera {
    let position: Vec3

    init(position: Vec3) {
        self.position = position
    }

    func getRay(u: Double, v: Double) -> Ray {
        return Ray(origin: position, direction: Vec3(u, v, 1.0))
    }
}
