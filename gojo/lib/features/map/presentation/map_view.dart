import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import 'package:gojo/Gojo-Mobile-Shared/resources/resources.dart';
import 'package:latlong2/latlong.dart' as latlng;

import '../../../Gojo-Mobile-Shared/UI/design_tokens/borders.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: "Gojo Map View",
      child: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: latlng.LatLng(8.9806, 38.7578),
              zoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 180,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildPropertyCard(context),
                    const SizedBox(width: 5),
                    _buildPropertyCard(context),
                    const SizedBox(width: 5),
                    _buildPropertyCard(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyCard(BuildContext context) {
    return Card(
      shape: GojoBorders.rounded(GojoBorderRadiusSize.large),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.overlay,
                  ),
                  child: Image.asset(
                    "assets/images/sofa.jpeg",
                    height: 100,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                _buildShowDistance(context),
              ],
            ),
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  " Niko's Auditorium",
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.attach_money,
                      size: 18,
                    ),
                    Text(
                      "45,000 ETB",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      size: 18,
                    ),
                    Text(
                      "Thu, Jan 10th, 4:00 am",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Padding _buildShowDistance(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            children: [
              Icon(
                Icons.place,
                size: 20,
                color: Resources.gojoColors.primaryContrastColor,
              ),
              Text(
                "2.3 km ",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Resources.gojoColors.primaryContrastColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
