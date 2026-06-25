@file:Suppress("PackageName")

package io.github.RealEarthling.epoch

import android.location.Location
import android.location.LocationManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channelName = "io.github.RealEarthling.epoch/location"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channelName
        ).setMethodCallHandler { call, result ->
            if (call.method == "getLastKnownLocation") {
                val location = getLastKnownLocation()
                if (location != null) {
                    result.success(mapOf(
                        "latitude"  to location.latitude,
                        "longitude" to location.longitude,
                    ))
                } else {
                    result.error("UNAVAILABLE", "Location not available", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getLastKnownLocation(): Location? {
        val manager = getSystemService(LOCATION_SERVICE)
                as? LocationManager ?: return null
        val providers = listOf(
            LocationManager.NETWORK_PROVIDER,
            LocationManager.PASSIVE_PROVIDER,
        )
        return try {
            providers
                .mapNotNull { provider ->
                    @Suppress("MissingPermission")
                    manager.getLastKnownLocation(provider)
                }
                .maxByOrNull { it.time }  // most recent fix
        } catch (_: SecurityException) {
            null
        }
    }
}