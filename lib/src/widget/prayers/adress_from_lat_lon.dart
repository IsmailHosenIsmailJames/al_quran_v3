import "package:flutter/material.dart";
import "package:gap/gap.dart";
import "package:geocoding/geocoding.dart";

import "../../theme/colors/app_colors.dart";
import "../../theme/values/values.dart";

/// Fetches and formats a human-readable address from latitude and longitude.
///
/// Returns a string in the format "SubAdministrativeArea, AdministrativeArea, Country"
/// or null if the address cannot be determined or an error occurs.
Future<String?> fetchFormattedAddress(double lat, double long) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      // Construct the address, handling potentially null fields
      List<String> addressParts = [];
      if (place.subAdministrativeArea != null &&
          place.subAdministrativeArea!.isNotEmpty) {
        addressParts.add(place.subAdministrativeArea!);
      }
      if (place.administrativeArea != null &&
          place.administrativeArea!.isNotEmpty) {
        addressParts.add(place.administrativeArea!);
      }
      if (place.country != null && place.country!.isNotEmpty) {
        addressParts.add(place.country!);
      }
      return addressParts.join(", ");
    }
  } catch (e) {
    // Log the error or handle it as needed
    print("Error fetching address: $e");
  }
  return null; // Return null if no address found or error
}

Widget getAddressView({
  required double lat,
  required double long,
  bool keepDecoration = true,
  bool keepPadding = true,
  bool justAddress = false,
}) {
  return FutureBuilder<String?>(
    future: fetchFormattedAddress(lat, long),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting && !justAddress) {
        // Show a generic loading indicator only if we are not in 'justAddress' mode,
        // otherwise, let it be handled by the parent if needed.
        return const Text("Loading...");
      } else if (snapshot.hasError && !justAddress) {
        // Show error only if not in 'justAddress' mode
        return const Text("Error fetching address");
      }

      final String? address = snapshot.data;

      if (justAddress) {
        return Text(address ?? "Address not available");
      }

      // Full view with address, lat, and long
      return Container(
        decoration:
            keepDecoration
                ? BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(roundedRadius),
                )
                : null,
        padding: keepPadding ? const EdgeInsets.all(5) : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(address ?? "Address not available"),
            const Gap(5),
            Row(
              children: [
                const Text("Latitude: ", style: TextStyle(color: Colors.grey)),
                Text(lat.toString()),
              ],
            ),
            const Gap(5),
            Row(
              children: [
                const Text("Longitude: ", style: TextStyle(color: Colors.grey)),
                Text(long.toString()),
              ],
            ),
          ],
        ),
      );
    },
  );
}
