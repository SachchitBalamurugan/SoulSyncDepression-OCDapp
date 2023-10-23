import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MaterialApp(
    home: MeditationVideoScreen5(),
  ));
}

class MeditationVideoScreen5 extends StatefulWidget {
  @override
  _MeditationVideoScreen5State createState() => _MeditationVideoScreen5State();
}

class _MeditationVideoScreen5State extends State<MeditationVideoScreen5> with TickerProviderStateMixin {
  late VideoPlayerController _videoController;
  bool _isPlaying = false;

  late AnimationController _animationController;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();

    // Replace 'assets/sample_video.mp4' with your video file path or URL
    _videoController = VideoPlayerController.asset('videos/medlove.mp4')
      ..initialize().then((_) {
        setState(() {});
      });

    // Initialize animation controller with a duration of 10 minutes
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(minutes: 10),
    );

    // Add a listener to update the progress as the animation progresses
    _animationController.addListener(() {
      setState(() {
        _progress = _animationController.value;
      });
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _playPause() {
    setState(() {
      if (_isPlaying) {
        _videoController.pause();
        _animationController.stop(); // Pause the animation when video is paused
      } else {
        _videoController.play();
        _animationController.forward(); // Start or resume the animation when video is playing
      }
      _isPlaying = !_isPlaying;
    });
  }

  void _rewind() {
    setState(() {
      final Duration newPosition = _videoController.value.position - Duration(seconds: 10);
      _videoController.seekTo(newPosition);
    });
  }

  void _fastForward() {
    setState(() {
      final Duration newPosition = _videoController.value.position + Duration(seconds: 10);
      _videoController.seekTo(newPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: _buildCustomAppBar(),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF044051),
              Color(0xFF135263),
              Color(0xFF35788A),
              Color(0xFF35778A),
              Color(0xFF43879A),
              Color(0xFF5AA1B5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Hide the video player and show an empty container
            _videoController.value.isInitialized
                ? Container() // Replace AspectRatio with an empty container
                : CircularProgressIndicator(),
            SizedBox(height: 16),
            // Custom circular progress bar with number in center
            Container(
              width: 300,
              height: 300,
              child: ClipOval(
                child: CustomPaint(
                  painter: CircleProgressPainter(
                    progress: _progress, // Use the animation progress as the circle progress
                    progressColor: Color(0xFF04323F),
                    backgroundColor: Colors.white,
                    strokeWidth: 30,
                    textStyle: TextStyle(
                      color: Colors.white, // Set the font color to white
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Rewind icons
                IconButton(
                  onPressed: _rewind,
                  icon: Icon(Icons.replay_10, color: Colors.white, size: 40),
                ),
                SizedBox(width: 16),
                IconButton(
                  onPressed: _playPause,
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, size: 60, color: Colors.white),
                ),
                SizedBox(width: 16),
                IconButton(
                  onPressed: _fastForward,
                  icon: Icon(Icons.forward_10, color: Colors.white, size: 40),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Thicker linear progress bar
            Container(
              width: 200,
              height: 0, // Set height to 0 to remove the visible line
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey, width: 3),
              ),
              child: LinearProgressIndicator(
                value: _progress, // Use the animation progress as the linear progress value
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Rest of the code remains the same...

Widget _buildCustomAppBar() {
  return AppBar(
    title: SizedBox.shrink(), // Set the default title to null
    backgroundColor: Color(0xFF04323F),
    elevation: 50,
    // Add any other customization you want for the app bar
    // ...
    flexibleSpace: Align(
      alignment: Alignment.bottomLeft, // Align the title to the right
      child: Padding(
        padding: EdgeInsets.only(right: 20), // Add padding to shift it right
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '',
              style: TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              '   Lets Meditate',
              style: TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              '   Beginner Guide',
              style: TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class CircleProgressPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;
  final TextStyle textStyle;

  CircleProgressPainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
    required this.strokeWidth,
    required this.textStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;
    final startAngle = -90.0;
    final sweepAngle = 360.0 * progress;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      radians(startAngle),
      radians(sweepAngle),
      false,
      progressPaint,
    );

    // Draw the number inside the circle with percentage symbol
    final textSpan = TextSpan(text: '${(progress * 100).toInt()}%', style: textStyle);
    final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout();
    final textCenter = Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2);
    textPainter.paint(canvas, textCenter);
  }

  @override
  bool shouldRepaint(CircleProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.textStyle != textStyle;
  }
}

double radians(double degrees) {
  return degrees * (3.141592653589793) / 180;
}
