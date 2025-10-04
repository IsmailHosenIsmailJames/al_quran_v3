import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:geocoding/geocoding.dart";

import "../../theme/controller/theme_cubit.dart";
import "../../theme/controller/theme_state.dart";
import "../../theme/values/values.dart";

/// Fetches and formats a human-readable address from latitude and longitude.
///
/// Returns a string in the format "SubAdministrativeArea, AdministrativeArea, Country"
/// or null if the address cannot be determined or an error occurs.
Future<String?> fetchFormattedAddress(
  BuildContext context,
  double lat,
  double long,
) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      return AppLocalizations.of(context).formattedAddress(
        place.subAdministrativeArea ?? "",
        place.administrativeArea ?? "",
        place.country ?? "",
      );
    }
  } catch (e) {
    // Log the error or handle it as needed
    print("Error fetching address: $e");
  }
  return null; // Return null if no address found or error
}

Widget getAddressView({
  required BuildContext context,
  required double lat,
  required double long,
  bool keepDecoration = true,
  bool keepPadding = true,
  bool justAddress = false,
  TextStyle? style,
}) {
  return SizedBox(
    height: keepDecoration == true ? 100 : null,
    child: FutureBuilder<String?>(
      future: fetchFormattedAddress(context, lat, long),
      builder: (context, snapshot) {
        ThemeState themeState = context.read<ThemeCubit>().state;
        if (snapshot.connectionState == ConnectionState.waiting &&
            !justAddress) {
          // Show a generic loading indicator only if we are not in 'justAddress' mode,
          // otherwise, let it be handled by the parent if needed.
          return Text(AppLocalizations.of(context).loading, style: style);
        } else if (snapshot.hasError && !justAddress) {
          // Show error only if not in 'justAddress' mode
          return Text(
            AppLocalizations.of(context).errorFetchingAddress,
            style: style,
          );
        }

        final String? address = snapshot.data;

        if (justAddress) {
          return SizedBox(
            width: 200,
            child: Text(
              address ?? AppLocalizations.of(context).addressNotAvailable,
              style: style,
            ),
          );
        }

        // Full view with address, lat, and long
        return Container(
          height: 100,
          alignment: Alignment.topLeft,
          decoration:
              keepDecoration
                  ? BoxDecoration(
                    border: Border.all(color: themeState.primaryShade300),
                    borderRadius: BorderRadius.circular(roundedRadius),
                  )
                  : null,
          padding: keepPadding ? const EdgeInsets.all(5) : null,
          child: FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    address ?? AppLocalizations.of(context).addressNotAvailable,
                    style: style,
                  ),
                ),
                const Gap(5),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context).latitude,
                      style: (style ?? const TextStyle()).copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    Text(lat.toString(), style: style),
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context).longitude,
                      style: (style ?? const TextStyle()).copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    Text(long.toString(), style: style),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
