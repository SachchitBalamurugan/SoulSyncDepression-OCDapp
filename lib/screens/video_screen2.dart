import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MaterialApp(
    home: VideoScreenDepression(),
  ));
}

class VideoScreenDepression extends StatefulWidget {
  @override
  _VideoScreenDepressionState createState() => _VideoScreenDepressionState();
}

class _VideoScreenDepressionState extends State<VideoScreenDepression> {
  VideoPlayerController? _videoController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    // Replace 'assets/sample_video.mp4' with your video file path or URL
    _videoController = VideoPlayerController.asset('videos/RightMind.mp4')
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
        title: Text("Patterns and Recurrence"),
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
              "Understanding the patterns and recurrence of depression is crucial for individuals dealing with this mental health condition. Depression can manifest and recur in various ways, and recognizing these patterns can aid in early detection, coping strategies, and seeking appropriate support. Here are some key insights into how depression may manifest and recur in one's life: Episodic Nature: Depression often follows an episodic pattern. Individuals may experience periods of deep sadness, low energy, and loss of interest in activities, known as depressive episodes. These episodes can vary in duration and intensity. Triggers and Stressors: Depression can be triggered or exacerbated by various factors, such as major life changes, traumatic events, chronic stress, loss, or significant personal challenges. Identifying these triggers can be crucial in managing and preventing recurrence. High-Risk Periods: Some individuals may experience higher vulnerability to depression during specific life stages, such as adolescence, postpartum, or late adulthood. Recognizing these high-risk periods can help in providing targeted support. Chronic Depression: For some individuals, depression may persist over an extended period, leading to chronic depression. This condition requires ongoing treatment and management to improve the quality of life. Seasonal Patterns: Seasonal Affective Disorder (SAD) is a subtype of depression that follows a seasonal pattern, usually occurring during fall and winter when there is less sunlight. Recognizing and addressing SAD can be essential in managing its impact. Cycle of Recurrence: For some individuals, depression may recur in a cyclical manner, with periods of remission followed by relapses. Understanding these cycles can help individuals prepare for potential recurrences. Genetic Predisposition: There may be a genetic component to depression, making some individuals more susceptible to the condition. Having a family history of depression can increase the risk of experiencing depression. Comorbidity: Depression often co-occurs with other mental health conditions, such as anxiety, substance abuse, or eating disorders. Treating coexisting conditions is vital for comprehensive care. Personal Coping Strategies: Understanding one's coping mechanisms and learning healthy ways to manage stress and emotions can help reduce the likelihood of depression recurrence. Support System: A strong support system, including friends, family, and mental health professionals, can be instrumental in managing depression and preventing recurrence. Treatment Adherence: Consistency in adhering to treatment plans, including therapy, medication, or other interventions, can significantly impact the likelihood of recurrence. Self-awareness: Being attuned to one's emotions and recognizing early signs of depression can empower individuals to seek help and implement coping strategies proactively.",
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
