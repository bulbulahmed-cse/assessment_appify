/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class Assets {
  const Assets._();

  static const SvgGenImage vector = SvgGenImage('assets/Vector.svg');
  static const SvgGenImage analytics01 = SvgGenImage('assets/analytics-01.svg');
  static const AssetGenImage angry = AssetGenImage('assets/angry.png');
  static const SvgGenImage banner = SvgGenImage('assets/banner.svg');
  static const SvgGenImage camera01 = SvgGenImage('assets/camera-01.svg');
  static const AssetGenImage care = AssetGenImage('assets/care.png');
  static const SvgGenImage comment = SvgGenImage('assets/comment.svg');
  static const SvgGenImage commentFilled = SvgGenImage(
    'assets/comment_filled.svg',
  );
  static const SvgGenImage community = SvgGenImage('assets/community.svg');
  static const SvgGenImage doLike = SvgGenImage('assets/do_like.svg');
  static const SvgGenImage fileAttachment = SvgGenImage(
    'assets/file-attachment.svg',
  );
  static const AssetGenImage haha = AssetGenImage('assets/haha.png');
  static const SvgGenImage image02 = SvgGenImage('assets/image-02.svg');
  static const AssetGenImage like = AssetGenImage('assets/like.png');
  static const AssetGenImage loginBack = AssetGenImage('assets/login_back.png');
  static const SvgGenImage logout = SvgGenImage('assets/logout.svg');
  static const AssetGenImage love = AssetGenImage('assets/love.png');
  static const AssetGenImage sad = AssetGenImage('assets/sad.png');
  static const AssetGenImage userPng = AssetGenImage('assets/user.png');
  static const SvgGenImage userSvg = SvgGenImage('assets/user.svg');
  static const SvgGenImage video02 = SvgGenImage('assets/video-02.svg');
  static const SvgGenImage videoAi = SvgGenImage('assets/video-ai.svg');
  static const AssetGenImage wow = AssetGenImage('assets/wow.png');

  /// List of all assets
  static List<dynamic> get values => [
    vector,
    analytics01,
    angry,
    banner,
    camera01,
    care,
    comment,
    commentFilled,
    community,
    doLike,
    fileAttachment,
    haha,
    image02,
    like,
    loginBack,
    logout,
    love,
    sad,
    userPng,
    userSvg,
    video02,
    videoAi,
    wow,
  ];
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
