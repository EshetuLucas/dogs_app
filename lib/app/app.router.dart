// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dogs_app/ui/views/dogs/dogs_view.dart' as _i2;
import 'package:dogs_app/ui/views/show_full_image/show_full_image_view.dart'
    as _i3;
import 'package:flutter/cupertino.dart' as _i5;
import 'package:flutter/material.dart' as _i4;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i6;

class Routes {
  static const dogsView = '/dogs-view';

  static const showFullImageView = '/show-full-image-view';

  static const all = <String>{
    dogsView,
    showFullImageView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.dogsView,
      page: _i2.DogsView,
    ),
    _i1.RouteDef(
      Routes.showFullImageView,
      page: _i3.ShowFullImageView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.DogsView: (data) {
      return _i4.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.DogsView(),
        settings: data,
      );
    },
    _i3.ShowFullImageView: (data) {
      final args = data.getArgs<ShowFullImageViewArguments>(nullOk: false);
      return _i4.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _i3.ShowFullImageView(key: args.key, imagePath: args.imagePath),
        settings: data,
        transitionsBuilder: data.transition ?? _i1.TransitionsBuilders.fadeIn,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class ShowFullImageViewArguments {
  const ShowFullImageViewArguments({
    this.key,
    required this.imagePath,
  });

  final _i5.Key? key;

  final String imagePath;

  @override
  String toString() {
    return '{"key": "$key", "imagePath": "$imagePath"}';
  }

  @override
  bool operator ==(covariant ShowFullImageViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.imagePath == imagePath;
  }

  @override
  int get hashCode {
    return key.hashCode ^ imagePath.hashCode;
  }
}

extension NavigatorStateExtension on _i6.NavigationService {
  Future<dynamic> navigateToDogsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.dogsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToShowFullImageView({
    _i5.Key? key,
    required String imagePath,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.showFullImageView,
        arguments: ShowFullImageViewArguments(key: key, imagePath: imagePath),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDogsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.dogsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithShowFullImageView({
    _i5.Key? key,
    required String imagePath,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.showFullImageView,
        arguments: ShowFullImageViewArguments(key: key, imagePath: imagePath),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
