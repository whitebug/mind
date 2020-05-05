import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mind/utils/utils.dart';
import 'package:mind/widgets/widgets.dart';

typedef void OnError(Exception exception);

const kUrl1 = 'https://luan.xyz/files/audio/ambient_c_motion.mp3';
const kUrl2 = 'https://luan.xyz/files/audio/nasa_on_a_mission.mp3';
const kUrl3 = 'http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1xtra_mf_p';

class PlayerScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  final String url;
  final PlayerMode mode;

  PlayerScreen({
    Key key,
    this.url = kUrl1,
    this.mode = PlayerMode.MEDIA_PLAYER,
  }) : super(key: key);

  @override
  _PlayerScreenState createState() => _PlayerScreenState(
        url: url,
        mode: mode,
      );
}

class _PlayerScreenState extends State<PlayerScreen> {
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();

  String url;
  PlayerMode mode;

  AudioPlayer _audioPlayer;
  Duration _duration;
  Duration _position;

  // show player page
  bool _isPlayerPage;

  AudioPlayerState _playerState = AudioPlayerState.STOPPED;
  PlayingRouteState _playingRouteState = PlayingRouteState.SPEAKERS;
  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerStateSubscription;

  get _isPlaying => _playerState == AudioPlayerState.PLAYING;
  get _isPaused => _playerState == AudioPlayerState.PAUSED;

  // sound
  static const platform = const MethodChannel('mindfulness.sodnomov.com/volume');
  String _batteryLevel = 'Unknown battery level.';
  // end of sound

  _PlayerScreenState({
    @required this.url,
    @required this.mode,
  });

  @override
  void initState() {
    super.initState();
    _isPlayerPage = true;

    if (kIsWeb) {
      // Calls to Platform.isIOS fails on web
      return;
    }
    if (Platform.isIOS) {
      if (audioCache.fixedPlayer != null) {
        audioCache.fixedPlayer.startHeadlessService();
      }
      advancedPlayer.startHeadlessService();
    }

    _initAudioPlayer();
    _getBatteryLevel();
  }


  @override
  void dispose() {
    _audioPlayer.stop();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
    super.dispose();
  }

  // sound
  // Get battery level.


  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
  // end of sound

  void _initAudioPlayer() {
    _audioPlayer = AudioPlayer(mode: mode);

    _durationSubscription = _audioPlayer.onDurationChanged.listen(
      (duration) {
        setState(() {
          _duration = duration;
        });

        // TODO implemented for iOS, waiting for android impl
        if (Theme.of(context).platform == TargetPlatform.iOS) {
          // (Optional) listen for notification updates in the background
          _audioPlayer.startHeadlessService();

          // set at least title to see the notification bar on ios.
          _audioPlayer.setNotification(
            title: 'App Name',
            artist: 'Artist or blank',
            albumTitle: 'Name or blank',
            imageUrl: 'url or blank',
            forwardSkipInterval: const Duration(seconds: 30), // default is 30s
            backwardSkipInterval: const Duration(seconds: 30), // default is 30s
            duration: duration,
            elapsedTime: Duration(seconds: 0),
          );
        }
      },
    );

    _positionSubscription =
        _audioPlayer.onAudioPositionChanged.listen((p) => setState(() {
              _position = p;
            }));

    _playerCompleteSubscription =
        _audioPlayer.onPlayerCompletion.listen((event) {
      _onComplete();
      setState(() {
        _position = _duration;
      });
    });

    _playerErrorSubscription = _audioPlayer.onPlayerError.listen((message) {
      print('audioPlayer error : $message');
      setState(() {
        _playerState = AudioPlayerState.STOPPED;
        _duration = Duration(seconds: 0);
        _position = Duration(seconds: 0);
      });
    });

    _playingRouteState = PlayingRouteState.SPEAKERS;
  }

  void _onComplete() {
    setState(() {
      _playerState = AudioPlayerState.STOPPED;
    });
  }

  Future<int> _play() async {
    final playPosition = (_position != null &&
            _duration != null &&
            _position.inMilliseconds > 0 &&
            _position.inMilliseconds < _duration.inMilliseconds)
        ? _position
        : null;
    final result = await _audioPlayer.play(url, position: playPosition);
    if (result == 1) {
      setState(() {
        _playerState = AudioPlayerState.PLAYING;
      });
    }

    _audioPlayer.setPlaybackRate(playbackRate: 1.0);

    return result;
  }

  Future<int> _pause() async {
    final result = await _audioPlayer.pause();
    if (result == 1) {
      setState(() {
        _playerState = AudioPlayerState.PAUSED;
      });
    }
    return result;
  }

  Future<int> _stop() async {
    final result = await _audioPlayer.stop();
    if (result == 1) {
      setState(() {
        _playerState = AudioPlayerState.STOPPED;
        _position = Duration();
      });
    }
    return result;
  }

  Widget buttonBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: _isPlaying
          ? Container(
              width: SizeConfig.safeBlockHorizontal * 40,
              height: SizeConfig.safeBlockHorizontal * 12,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: Colors.white),
                ),
                child: Text(
                  'Pause',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.safeBlockHorizontal * 4.1,
                  ),
                ),
                onPressed: _isPlaying ? () => _pause() : null,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: SizeConfig.safeBlockHorizontal * 40,
                  height: SizeConfig.safeBlockHorizontal * 12,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      side: BorderSide(color: Colors.white),
                    ),
                    child: Text(
                      'Stop',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.safeBlockHorizontal * 4.1,
                      ),
                    ),
                    onPressed: _isPlaying || _isPaused ? () => _stop() : null,
                  ),
                ),
                Container(
                  width: SizeConfig.safeBlockHorizontal * 40,
                  height: SizeConfig.safeBlockHorizontal * 12,
                  child: FlatButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      side: BorderSide(color: Colors.white),
                    ),
                    child: Text(
                      'Resume',
                      style: TextStyle(
                        color: Color(0xFF0C2830),
                        fontSize: SizeConfig.safeBlockHorizontal * 4.1,
                      ),
                    ),
                    onPressed: _isPlaying ? null : () => _play(),
                  ),
                )
              ],
            ),
    );
  }

  Future<int> _earpieceOrSpeakersToggle() async {
    final result = await _audioPlayer.earpieceOrSpeakersToggle();
    if (result == 1)
      setState(() => _playingRouteState =
          _playingRouteState == PlayingRouteState.SPEAKERS
              ? PlayingRouteState.EARPIECE
              : PlayingRouteState.SPEAKERS);
    return result;
  }

  MindAppBar mindAppBar() {
    return MindAppBar(
      onBackPressed: () {},
      onMutePressed: _earpieceOrSpeakersToggle,
      onSettingsPressed: () {
        setState(() {
          _isPlayerPage = !_isPlayerPage;
        });
      },
      playerPage: _isPlayerPage,
    );
  }

  Widget playerPage() {
    // player's time
    String playerTime = '00:00';
    // track progress
    double progress = 0;
    if (_position != null &&
        _duration != null &&
        _position.inMilliseconds > 0 &&
        _position.inMilliseconds <= _duration.inMilliseconds) {
      String _minutes = _position.inMinutes.toString().padLeft(2, '0');
      String _seconds = (_position.inSeconds % 60).toString().padLeft(2, '0');
      playerTime = '$_minutes:$_seconds';
      progress = (_position.inMilliseconds / _duration.inMilliseconds) * 100;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        mindAppBar(),
        Text(
          _batteryLevel,
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 10,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        Player(
          time: playerTime,
          progress: progress,
        ),
        SizedBox(
          height: 1,
        ),
        buttonBar(),
      ],
    );
  }

  // player's settings
  Widget settingsPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        mindAppBar(),
        Container(
          width: SizeConfig.safeBlockHorizontal * 90,
          child: Column(
            children: <Widget>[
              Container(
                width: SizeConfig.safeBlockHorizontal * 90,
                child: Text(
                  _batteryLevel /*'VOLUME'*/,
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 4,
                    color: Colors.white,
                  ),
                ),
              ),
              SliderWidget(
                min: 0,
                max: 10,
                icon: Icons.volume_up,
                iconColor: Colors.black,
                activeTrackColor: Colors.white,
                inactiveTrackColor: Colors.white38,
                sliderHeight: SizeConfig.safeBlockVertical * 5,
                sliderWidth: SizeConfig.safeBlockHorizontal * 90,
                fontSizeIcon: SizeConfig.safeBlockVertical * 3,
                code: 'someCode',
                value: 0.5,
                onChange: (value, code) {
                  _getBatteryLevel();
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 1,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black45,
              BlendMode.darken,
            ),
            image: AssetImage('assets/design/background.png'),
          ),
        ),
        child: SafeArea(
          child: _isPlayerPage ? playerPage() : settingsPage(),
        ),
      ),
    );
  }
}
