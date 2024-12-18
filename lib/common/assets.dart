

abstract class Assets {
  const Assets._();

  // ignore: library_private_types_in_public_api
  static _Icons get icons => const _Icons();

  // ignore: library_private_types_in_public_api
  static _Images get images => const _Images();

  // ignore: library_private_types_in_public_api
  // static _Videos get videos => const _Videos();

// ignore: library_private_types_in_public_api
  static _Audios get audios => const _Audios();
}

abstract class _AssetsHolder {
  final String basePath;

  const _AssetsHolder(this.basePath);
}

class _Icons extends _AssetsHolder {
  const _Icons() : super('assets/icons');

  ///bottom nav bar
  String get icMic => 'assets/icons/ic_mic.svg';
  String get icTrash => 'assets/icons/ic_trash.svg';
  String get icPause => 'assets/icons/ic_pause.svg';


}

class _Images extends _AssetsHolder {
  const _Images() : super('assets/images');

  String get imgNfc => 'assets/images/img_nfc.webp';
  String get imgNfc2 => 'assets/images/4373043.png';

}

class _Audios extends _AssetsHolder {
  const _Audios() : super('audio');

  String get truckSoundEffect => '$basePath/truck_sound_effect.mp3';

  String get orderEffect => '$basePath/new_order_effect.mp3';
// String get one => "audio/1.mp3";
}
