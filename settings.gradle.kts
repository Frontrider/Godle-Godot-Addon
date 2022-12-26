pluginManagement{
    repositories{
        mavenLocal()
        gradlePluginPortal()
    }
    resolutionStrategy {
        eachPlugin {
            if(requested.id.toString() =="io.github.frontrider.godle-publish"){
                useModule("io.github.frontrider:godle-publish:${requested.version}")
            }
        }
    }
}

rootProject.name = "Godle"
