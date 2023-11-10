// Top-level build file where you can add configuration options common to all sub-projects/modules.
plugins {
    alias(libs.plugins.android.application) apply false
    alias(libs.plugins.kotlin.android) apply false
    alias(libs.plugins.hilt) apply false
    alias(libs.plugins.ksp) apply false
    alias(libs.plugins.detekt)
    alias(libs.plugins.com.android.library) apply false
}

val detektFormatting = libs.detekt.formatting
subprojects {
    apply {
        plugin("io.gitlab.arturbosch.detekt")
    }
    detekt {
        config.from(rootProject.files("config/detekt/detekt.yml"))
    }
    dependencies {
        detektPlugins(detektFormatting)
    }
}