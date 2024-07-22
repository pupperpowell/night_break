import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class AudioButton extends StatefulWidget {
  final int minuteGoal;
  const AudioButton({super.key, required this.minuteGoal});

  @override
  AudioButtonState createState() => AudioButtonState();
}

class AudioButtonState extends State<AudioButton> with WidgetsBindingObserver {
  DateTime? _startTime;
  Duration _totalForegroundTime = Duration.zero;
  Timer? _timer;

  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _timerDone = false;
  bool _audioEnabled = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startTracking();
    _startTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopTimer();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _stopTracking();
      _stopTimer();
      debugPrint("timer stopped");
    } else if (state == AppLifecycleState.resumed) {
      _startTracking();
      _startTimer();
      debugPrint("timer (re?)started");
    }
  }

  void _startTracking() {
    _startTime = DateTime.now().toUtc();
  }

  void _stopTracking() {
    if (_startTime != null) {
      _totalForegroundTime += DateTime.now().difference(_startTime!);
      _startTime = null;
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        // play bell at timer done
        if (currentForegroundTime.inMinutes >= widget.minuteGoal) {
          playBellAudio();
          _timerDone = true;
        }
        // play censer at start, or every minute after timer is done
        if (currentForegroundTime.inSeconds < 2 ||
            (_timerDone &&
                currentForegroundTime.inSeconds % 60 == 0 &&
                currentForegroundTime.inMinutes != widget.minuteGoal)) {
          playCenserAudio();
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  Duration get currentForegroundTime {
    return _totalForegroundTime +
        (_startTime != null
            ? DateTime.now().difference(_startTime!)
            : Duration.zero);
  }

  Future<void> playBellAudio() async {
    if (_timerDone) return;
    if (!_audioEnabled) return;
    try {
      await _audioPlayer.play(AssetSource('audio/bell.mp3'));
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }

  Future<void> playCenserAudio() async {
    if (!_audioEnabled) return;
    try {
      await _audioPlayer.play(AssetSource('audio/censer2.mp3'));
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }

  void stopAllAudio() {
    _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        setState(() {
          if (_audioEnabled) {
            _audioEnabled = false;
            stopAllAudio();
          } else {
            _audioEnabled = true;
          }
        });
      },
      child: Text(
        _audioEnabled ? 'mute' : 'unmute',
      ),
    );
  }
}
