class Scene {
    let objects: [Primitive]
    let lights: [Sphere]

    init(objects: [Primitive], lights: [Sphere]) {
        self.objects = objects
        self.lights = lights
    }

    func closestIntersection(ray: Ray) -> Intersection? {
        var closestIntersection: Intersection? = nil
        var closestDistance = Double.infinity

        for object in objects {
            if let intersection = object.intersect(ray: ray) {
                if intersection.distance < closestDistance {
                    closestDistance = intersection.distance
                    closestIntersection = intersection
                }
            }
        }

        return closestIntersection
    }
}
