import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart' as latlng;

import '../../../../Gojo-Mobile-Shared/UI/design_tokens/borders.dart';
import '../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../../Gojo-Mobile-Shared/resources/resources.dart';
import '../../../../constants/strings/app_routes.dart';
import '../../../../navigation/args/property_detail_args.dart';
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
            return FlutterMap(
              options: MapOptions(
                center: latlng.LatLng(
                  state.center.lat,
                  state.center.lng,
                ),
                zoom: 18,
                maxZoom: 18,
              ),
              children: [
                TileLayer(
                    urlTemplate:
                        "https://api.mapbox.com/styles/v1/nati123/clid8v2jw002o01r008qb4bqq/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibmF0aTEyMyIsImEiOiJja3ppc2JzMmExcXBsMndwZGplamVjYjB2In0.GlIgUrBczURuuqgWsmjSGw",
                    additionalOptions: const {
                      'accessToken':
                          'sk.eyJ1IjoibmF0aTEyMyIsImEiOiJjbGlkOHRwYWMwOWtuM2VxZjM0NHVwMzVrIn0.M33SSeIw7e1fANfx3v2q5A',
                      'id': 'mapbox.mapbox-streets-v8'
                    }),
                MarkerLayer(
                  markers: [
                    for (var property in state.properties)
                      Marker(
                        point: latlng.LatLng(
                          property.location.lat,
                          property.location.lng,
                        ),
                        builder: (context) => CircleButton(
                          icon: Icons.house,
                          onTap: () {
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
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          GojoRoutes.propertyDetail,
          arguments: PropertyDetailArgs(id: property.id),
        );
      },
      child: SizedBox(
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
                    Image(
                      image: CachedNetworkImageProvider(property.image),
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
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData icon;

  const CircleButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    double size = 90.0;

    return InkResponse(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Icon(
          icon,
          color: Resources.gojoColors.primaryColor,
        ),
      ),
    );
  }
}
