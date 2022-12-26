import io.github.frontrider.godle.dsl.versioning.asGodot
import io.github.frontrider.godle.publish.dsl.AssetCategories
import io.github.frontrider.godle.publish.dsl.currentCommitHash
import godle.license.MIT

plugins{
    id("io.github.frontrider.godle") version "0.13.0"
    id("io.github.frontrider.godle-publish") version "0.3.2"
}

group = "io.github.frontrider"
version = "0.1.0"

godle{
    asGodot("3.5.1")
    addons {
        clearAddonsBeforeInstall = false
        install{
        }
    }
}

val godotUsername:String by project
val godotPassword:String by project

godlePublish{
    create("Godle"){
        description = """
             Companion addon for the Godle Gradle plugin.
        """.trimIndent()
        supportLevel.set("community")
        downloadProvider.set("GitHub")
        category = AssetCategories.Tools
        godotVersion.set("3.5")
        vcsUrl.set("https://github.com/Frontrider/Godle-Godot-Addon")
        iconUrl.set("https://raw.githubusercontent.com/Frontrider/Godot-Scene-Browser/${currentCommitHash()}/icon.png")
        license = MIT()
        credentials{
            username = godotUsername
            password = godotPassword
        }
    }
}