import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart'; // Import the package
import 'package:url_launcher/url_launcher.dart'; // For launching URLs

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showUpButton = false;

  @override
  void initState() {
    super.initState();

    // Add listener to detect scroll position
    _scrollController.addListener(() {
      setState(() {
        // Show the button after scrolling 100px
        _showUpButton = _scrollController.offset > 100;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B1B40), // Background color #0B1B40

      // Show Floating Action Button only when scrolled more than 100px
      floatingActionButton: _showUpButton
          ? FloatingActionButton(
        backgroundColor: Color(0xFF3A5DB0),
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        },
        child: Icon(Icons.arrow_upward),
      )
          : null,

      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/2.png'), // Replace with your image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Name with Typewriter effect
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Syed Muhammad Askari',
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    speed: Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 1,
              ),

              SizedBox(height: 10),

              // Description Text
              Text(
                'I am highly enthusiastic about becoming a data scientist, driven by my passion for extracting meaningful insights from data...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 50),

              // Education Section
              _buildSectionTitle('Education'),
              _buildInfoBox(
                context,
                content: [
                  'Matric (Science Grade A+)',
                  'HSSC (Pre-Engineering Grade A)',
                  'Bachelors in Computer Science (Grade A+)',
                ],
              ),

              SizedBox(height: 50),

              // Projects Section
              _buildSectionTitle('Projects'),
              _buildInfoBox(
                context,
                content: [
                  'C++ (Banking System)',
                  'Python Full Stack Web App',
                  'Python EDA (Chronic Liver Disease)',
                ],
              ),

              SizedBox(height: 50),

              // Skills Section
              _buildSectionTitle('Skills'),
              _buildInfoBox(
                context,
                content: [
                  'Python(Numpy,Pandas,Seaborn,Matplotlib)        ',
                  'C++(WindowsApi,DSA,Opp,FileHandling)',
                  'Flask(Routes,Session,Token,Authentication,Wt Form)',
                  'Java(Opp,DSA,BootSpring,DataBase Connections)',
                  'Html,CSS(bootStrap,TailWind,React)',
                ],
              ),

              SizedBox(height: 50),

              // Contact Us Section (Only GitHub logo, no colored box)
              _buildSectionTitle('Contact Us'),
              GestureDetector(
                onTap: () => _launchURL('https://github.com/askarikzm'),
                child: Image.asset(
                  'assets/3.png', // GitHub logo
                  width: 120,
                  height: 120,
                ),
              ),

              SizedBox(height: 30),

              // Footer
              Text(
                'All rights reserved',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to create the section title with typewriter effect
  Widget _buildSectionTitle(String title) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          title,
          textStyle: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          speed: Duration(milliseconds: 100),
        ),
      ],
      totalRepeatCount: 1,
    );
  }

  // Function to build a box with content
  Widget _buildInfoBox(BuildContext context, {required List<String> content}) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Color(0xFF3A5DB0), // Box color
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: content
            .map((item) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            item,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ))
            .toList(),
      ),
    );
  }

  // Function to launch a URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
