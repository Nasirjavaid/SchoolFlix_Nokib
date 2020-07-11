//import 'package:youtube_player/youtube_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_flix_flutter/Models/videoInformation.dart';
import 'package:school_flix_flutter/util/appTheme.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerScreen extends StatefulWidget {
  Item item;
// constructor
  PlayerScreen({Key key, this.item});

  @override
  _PlayerPlayerScreenState createState() => _PlayerPlayerScreenState();
}

class _PlayerPlayerScreenState extends State<PlayerScreen> {
  YoutubePlayerController _controller;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;

  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  final List<String> _ids = [
    'gQDByCdjUXw',
    'iLnmTe5Q2Qw',
    '_WoCV4c6XOE',
    'KmzdUe0RSJo',
    '6jZDSSZZxjQ',
    'p2lYr3vM_1w',
    '7QUtEmBT_-w',
    '34_PXCzGw1M',
  ];

  int count = 0;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.item.contentDetails.upload.videoId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        // forceHideAnnotation: true,
      ),
    )..addListener(listener);
    _videoMetaData = YoutubeMetaData();
    _playerState = PlayerState.unknown;

    // TODO: implement initState
    super.initState();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

 SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
 

    
    return Container(
      alignment: Alignment.center,
      child:  YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
            // topActions: <Widget>[
            //   SizedBox(width: 8.0),
            //   Expanded(
            //     child: Text(
            //       _controller.metadata.title,
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 18.0,
            //       ),
            //       overflow: TextOverflow.ellipsis,
            //       maxLines: 1,
            //     ),
            //   ),
            //   IconButton(
            //     icon: Icon(
            //       Icons.settings,
            //       color: Colors.white,
            //       size: 25.0,
            //     ),
            //     onPressed: () {
            //       _showSnackBar('Settings Tapped!');
            //     },
            //   ),
            // ],
            onReady: () {
              _isPlayerReady = true;
            },
            onEnded: (id) {
              _controller.load(_ids[count++]);
              // _showSnackBar('Next Video Started!');
            },
          ),
        
      
    );

    // YoutubePlayerController(
    //     initialVideoId: "QFlRzcZoNoA", flags: YoutubePlayerFlags()));
  }
}
