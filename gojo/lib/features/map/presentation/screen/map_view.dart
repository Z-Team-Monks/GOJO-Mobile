import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart' as latlng;

import '../../../../Gojo-Mobile-Shared/UI/design_tokens/borders.dart';
import '../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../../Gojo-Mobile-Shared/resources/resources.dart';
import '../../../home/presentation/screen/home_view.dart';
import '../../../home/presentation/screen/widgets/rating.dart';
import '../../data/model/property_mapview_item.dart';
import '../../data/repository/map_view_repository.dart';
import '../bloc/map_view_bloc.dart';
import 'widgets/property_info_row.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MapViewBloc(GetIt.I<MapViewRepository>())
          ..add(
            MapViewLoad(),
          );
      },
      child: const _MapView(),
    );
  }
}

class _MapView extends StatelessWidget {
  const _MapView();

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: "Gojo Map View",
      isFullScreen: true,
      child: BlocBuilder<MapViewBloc, MapViewState>(builder: (context, state) {
        switch (state.status) {
          case MapViewStatus.loading:
            return LoadingView();
          case MapViewStatus.error:
            return ErrorView();
          default:
            return MapViewContent();
        }
      }),
    );
  }
}

class MapViewContent extends StatelessWidget {
  const MapViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<MapViewBloc, MapViewState>(
          builder: (context, state) {
            debugPrint("location ${state.center.lat} ${state.center.lng}");
            return FlutterMap(
              options: MapOptions(
                center: latlng.LatLng(
                  state.center.lat,
                  state.center.lng,
                ),
                zoom: 18,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                MarkerLayer(
                  markers: [
                    for (var property in state.properties)
                      Marker(
                        point: latlng.LatLng(
                          property.location.lat,
                          property.location.lng,
                        ),
                        builder: (context) => IconButton(
                          icon: Icon(
                            Icons.house,
                            size: 30,
                            color: Resources.gojoColors.black,
                          ),
                          onPressed: () {
                            BlocProvider.of<MapViewBloc>(context).add(
                              MapViewPropertySelected(
                                property: property,
                              ),
                            );
                          },
                        ),
                      )
                  ],
                ),
              ],
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: BlocBuilder<MapViewBloc, MapViewState>(
            builder: (context, state) {
              return _buildPropertyCard(
                context,
                property: state.selectedProperty,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPropertyCard(
    BuildContext context, {
    required PropertyMapViewItem? property,
  }) {
    if (property == null) return Container();
    return SizedBox(
      height: 107,
      width: 300,
      child: Card(
        elevation: 3,
        shape: GojoBorders.rounded(GojoBorderRadiusSize.large),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image.asset(
                    property.image,
                    height: 100,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    property.title,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  PropertyInfoRow(
                    context: context,
                    icon: Icons.attach_money,
                    description: "${property.price} ETB",
                  ),
                  Rating(rating: "${property.rating}"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
