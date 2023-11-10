plugins {
    alias(libs.plugins.android.application)
    alias(libs.plugins.kotlin.android)
    alias(libs.plugins.ksp)
    alias(libs.plugins.hilt)
}

android {
    namespace = "com.clone.whatsapp"
    compileSdk = libs.versions.compileSdkVersion.get().toInt() //libs.versions.compile.sdk.version.get().toInt()

    defaultConfig {
        applicationId = "com.clone.whatsapp"
        minSdk = libs.versions.minSdk.get().toInt()
        targetSdk = libs.versions.targetSdk.get().toInt()
        versionCode = 1
        versionName = "0.1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        vectorDrawables {
            useSupportLibrary = true
        }
        // Consult the README on instructions for setting up Unsplash API key
        buildConfigField("String", "THIRD_PARTY_ACCESS_KEY", "\"" + get3rdPartyAccessKey() + "\"")
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
    kotlinOptions {
        jvmTarget = "1.8"
    }
    buildFeatures {
        compose = true
        buildConfig = true
    }
    composeOptions {
        kotlinCompilerExtensionVersion = libs.versions.compose.compiler.get()
    }
    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
    }
}

dependencies {

    implementation(project(mapOf("path" to ":core")))
    ksp(libs.hilt.android.compiler)
    implementation(libs.core.ktx)
    implementation(libs.lifecycle.runtime.ktx)
    implementation(libs.activity.compose)
    implementation(platform(libs.androidx.compose.bom))
    implementation(libs.androidx.compose.ui)
    implementation("androidx.compose.ui:ui-graphics")
    implementation(libs.androidx.compose.ui.tooling.preview)
    implementation(libs.androidx.compose.material3)
    implementation(libs.retrofit)
    implementation(libs.moshi)
    implementation(libs.navigation.compose)
    implementation(libs.kotlinx.coroutines.android)
    implementation (libs.glide)
    implementation(libs.lifecycle.viewmodel.compose)
    implementation (libs.core.splashscreen)

    //Work Manager
    implementation(libs.work.runtime.ktx) // Kotlin + coroutines

    implementation(libs.hilt.android)
    debugImplementation(libs.androidx.compose.ui.tooling)
    debugImplementation("androidx.compose.ui:ui-test-manifest")

    testImplementation(libs.junit)
    kspAndroidTest(libs.hilt.android.compiler)
    androidTestImplementation(libs.hilt.android.testing)
    testImplementation(libs.kotlinx.coroutines.test)
    androidTestImplementation(libs.ext.junit)
    androidTestImplementation(libs.espresso.core)
    androidTestImplementation(platform(libs.androidx.compose.bom))
    androidTestImplementation(libs.androidx.compose.ui.test.junit4)
}

fun get3rdPartyAccessKey(): String? {
    // Once you have the key, add this line to the gradle.properties file, either in your user
    // home directory (usually ~/.gradle/gradle.properties on Linux and Mac) or in the project's
    // root folder, like xyz_access_key=<your API access key>
    return project.findProperty("xyz_access_key") as? String
}
