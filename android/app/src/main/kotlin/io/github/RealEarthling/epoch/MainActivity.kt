@file:Suppress("PackageName")
package io.github.RealEarthling.epoch

import android.content.Context
import android.location.Location
import android.location.LocationListener
import android.location.LocationManager
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channelName = "io.github.RealEarthling.epoch/location"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channelName,
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getLastKnownLocation" -> requestNetworkLocation(result)
                else                   -> result.notImplemented()
            }
        }
    }

    private fun requestNetworkLocation(result: MethodChannel.Result) {
        val manager = getSystemService(Context.LOCATION_SERVICE)
                as? LocationManager
        if (manager == null) {
            result.error("UNAVAILABLE", "LocationManager not available", null)
            return
        }
        if (!manager.isProviderEnabled(LocationManager.NETWORK_PROVIDER)) {
            result.error("UNAVAILABLE", "Network location provider disabled", null)
            return
        }

        val useModernApi = Build.VERSION.SDK_INT >= Build.VERSION_CODES.R

        // Try cached fix first.
        val cachedFix = try {
            @Suppress("MissingPermission")
            manager.getLastKnownLocation(LocationManager.NETWORK_PROVIDER)
        } catch (_: SecurityException) {
            result.error("PERMISSION_DENIED", "Location permission denied", null)
            return
        }

        val sixHoursMs = 6L * 60 * 60 * 1000
        if (cachedFix != null &&
            System.currentTimeMillis() - cachedFix.time < sixHoursMs) {
            result.success(locationMap(cachedFix))
            return
        }

        // No usable cache – request a single active network update.
        var delivered = false
        val handler = Handler(Looper.getMainLooper())

        val listener = object : LocationListener {
            override fun onLocationChanged(location: Location) {
                if (!delivered) {
                    delivered = true
                    manager.removeUpdates(this)
                    result.success(locationMap(location))
                }
            }
            @Deprecated("Deprecated in Java")
            override fun onStatusChanged(
                provider: String?, status: Int, extras: Bundle?) {}
        }

        try {
            if (useModernApi) {
                @Suppress("MissingPermission")
                manager.getCurrentLocation(
                    LocationManager.NETWORK_PROVIDER,
                    null,
                    mainExecutor,
                ) { location ->
                    if (!delivered) {
                        delivered = true
                        if (location != null) {
                            result.success(locationMap(location))
                        } else {
                            result.error("UNAVAILABLE",
                                "Network location returned null", null)
                        }
                    }
                }
            } else {
                @Suppress("MissingPermission", "DEPRECATION")
                manager.requestSingleUpdate(
                    LocationManager.NETWORK_PROVIDER,
                    listener,
                    Looper.getMainLooper(),
                )
            }
        } catch (e: SecurityException) {
            result.error("PERMISSION_DENIED", "Location permission denied", null)
            return
        }

        handler.postDelayed({
            if (!delivered) {
                delivered = true
                if (!useModernApi) {
                    manager.removeUpdates(listener)
                }
                result.error("TIMEOUT",
                    "Network location request timed out", null)
            }
        }, 15_000L)
    }

    private fun locationMap(location: Location): Map<String, Double> =
        mapOf("latitude" to location.latitude,
            "longitude" to location.longitude)
}