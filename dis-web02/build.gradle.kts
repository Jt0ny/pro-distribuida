plugins {
    id("java")
  //  id("application")
    id("io.freefair.lombok") version "9.1.0"
    id("com.gradleup.shadow") version "9.2.0"
}

group = "org.example"
version = "unspecified"

repositories {
    mavenCentral()
}

dependencies {
    implementation("io.helidon.webserver:helidon-webserver:4.3.2")
    implementation("io.helidon.http.media:helidon-http-media-jsonp:4.3.2")
    implementation("io.helidon.http.media:helidon-http-media-jsonb:4.3.2")

    //

}

tasks.test {
    useJUnitPlatform()
}

tasks.jar{
    manifest{
        attributes["Main-Class"] = "com.programacion.distribuida.MiAplicacionMain"
    }
}