import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MaterialApp(
    home: VideoScreen(),
  ));
}

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController? _videoController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    // Replace 'assets/sample_video.mp4' with your video file path or URL
    _videoController = VideoPlayerController.asset('videos/MedTest.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoController!.dispose();
    super.dispose();
  }

  void _playPause() {
    setState(() {
      if (_isPlaying) {
        _videoController!.pause();
      } else {
        _videoController!.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  void _rewind() {
    setState(() {
      final Duration newPosition = _videoController!.value.position - Duration(seconds: 10);
      _videoController!.seekTo(newPosition);
    });
  }

  void _fastForward() {
    setState(() {
      final Duration newPosition = _videoController!.value.position + Duration(seconds: 10);
      _videoController!.seekTo(newPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF04323F),
        title: Text("Guided Meditation"),
      ),
      body: _videoController!.value.isInitialized
          ? Column(
        children: [
          AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: VideoPlayer(_videoController!),
          ),
          SizedBox(height: 20),
          Center( // Center the description text
            child: Text(
              "This is an Original 10 minute guided morning meditation recorded by us. As the morning unfolds, may you walk this path of inner peace with unwavering grace and unshakable resolve. Know that you are not alone, for the universe conspires to support your journey towards self-discovery. Trust in the wisdom of your intuition, and allow the symphony of your soul to guide you towards a deeper understanding of who you truly are. May your journey be filled with serenity, profound insights, and boundless joy. And may the morning sun illuminate your path, reminding you of the infinite possibilities that lie within your grasp. Wishing you a morning filled with peace and inner harmony.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center, // Center the text content
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _rewind,
                icon: Icon(Icons.fast_rewind),
              ),
              IconButton(
                onPressed: _playPause,
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              ),
              IconButton(
                onPressed: _fastForward,
                icon: Icon(Icons.fast_forward),
              ),
            ],
          ),
        ],
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
