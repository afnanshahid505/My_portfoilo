import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shaik Mohammad Afnan Shahid - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: GoogleFonts.interTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatelessWidget {
  const PortfolioHome({super.key});

  final String github = 'https://github.com/afnanshahid505';
  final String linkedin = 'https://www.linkedin.com/in/afnan-shahid-669302349/';
  final String email = 'mailto:afnanshahid744@gmail.com';
  final String phone = 'tel:+918985373780';

  Future<void> _open(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not open $url');
    }
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(width: 4, height: 22, color: Colors.indigo),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget skillChip(String s) => Chip(label: Text(s));

  Widget projectCard(String title, String desc, String? link) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Card(
        elevation: 4,
        shadowColor: Colors.indigo.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text(desc, style: const TextStyle(fontSize: 14)),
                    ]),
              ),
              if (link != null)
                IconButton(
                  tooltip: 'Open link',
                  icon: const Icon(Icons.open_in_new, color: Colors.indigo),
                  onPressed: () => _open(link),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    void scrollTo(double offset) {
      scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      Navigator.pop(context); // close drawer
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE8EAF6), Color(0xFFBBDEFB)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 6,
          backgroundColor: Colors.indigo.shade400,
          title: const Text(
            'SHAIK MOHAMMAD AFNAN SHAHID',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          actions: [
            IconButton(
              tooltip: 'GitHub',
              icon: const Icon(Icons.code, color: Colors.white),
              onPressed: () => _open(github),
            ),
            IconButton(
              tooltip: 'LinkedIn',
              icon: const Icon(Icons.business_center, color: Colors.white),
              onPressed: () => _open(linkedin),
            ),
            IconButton(
              tooltip: 'Email',
              icon: const Icon(Icons.email_outlined, color: Colors.white),
              onPressed: () => _open(email),
            ),
          ],
        ),

        // 👇 Added Drawer Menu
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.indigo.shade400),
                child: const Center(
                  child: Text(
                    'Menu',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('About Me'),
                onTap: () => scrollTo(0),
              ),
              ListTile(
                leading: const Icon(Icons.school),
                title: const Text('Education'),
                onTap: () => scrollTo(600),
              ),
              ListTile(
                leading: const Icon(Icons.build),
                title: const Text('Skills'),
                onTap: () => scrollTo(1100),
              ),
              ListTile(
                leading: const Icon(Icons.folder),
                title: const Text('Projects'),
                onTap: () => scrollTo(1600),
              ),
              ListTile(
                leading: const Icon(Icons.work),
                title: const Text('Experience'),
                onTap: () => scrollTo(2100),
              ),
              ListTile(
                leading: const Icon(Icons.star),
                title: const Text('Honours'),
                onTap: () => scrollTo(2600),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.download),
                title: const Text('Download Resume'),
                onTap: () => _open(
                    'https://drive.google.com/file/d/1u-84S6NbilUS6PAhxtgPp32N_-dIUxVh/view?usp=sharing'),
              ),
            ],
          ),
        ),

        body: LayoutBuilder(builder: (context, constraints) {
          final bool wide = constraints.maxWidth >= 1000;
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: wide ? 1200 : 900),
                child:
                wide ? buildWideLayout(context) : buildNarrowLayout(context),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildWideLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 3,
          child: Column(
            children: [
              profileCard(),
              const SizedBox(height: 20),
              infoCard(title: 'Education', child: educationWidget()),
              const SizedBox(height: 20),
              infoCard(title: 'Skills', child: skillsWidget()),
              const SizedBox(height: 20),
              infoCard(title: 'Honours & Activities', child: honoursWidget()),
            ],
          ),
        ),
        const SizedBox(width: 28),
        Flexible(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              infoCard(title: 'About Me', child: aboutWidget()),
              const SizedBox(height: 18),
              infoCard(title: 'Projects', child: projectsWidget()),
              const SizedBox(height: 18),
              infoCard(title: 'Work & Experience', child: experienceWidget()),
              const SizedBox(height: 18),
              contactCard(),
              const SizedBox(height: 30),
              footerWidget(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildNarrowLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        profileCard(),
        const SizedBox(height: 20),
        infoCard(title: 'About Me', child: aboutWidget()),
        const SizedBox(height: 16),
        infoCard(title: 'Education', child: educationWidget()),
        const SizedBox(height: 16),
        infoCard(title: 'Skills', child: skillsWidget()),
        const SizedBox(height: 16),
        infoCard(title: 'Projects', child: projectsWidget()),
        const SizedBox(height: 16),
        infoCard(title: 'Work & Experience', child: experienceWidget()),
        const SizedBox(height: 16),
        infoCard(title: 'Honours & Activities', child: honoursWidget()),
        const SizedBox(height: 16),
        contactCard(),
        const SizedBox(height: 30),
        footerWidget(),
      ],
    );
  }

  Widget profileCard() {
    return Card(
      color: Colors.white.withOpacity(0.9),
      elevation: 6,
      shadowColor: Colors.indigo.withOpacity(0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
        child: Column(
          children: [
            CircleAvatar(
              radius: 64,
              backgroundImage: const AssetImage('assets/profile.jpg'),
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 14),
            const Text(
              'SHAIK MOHAMMAD AFNAN SHAHID',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              'Flutter Developer • Cybersecurity Enthusiast • CSE (AI & Data Science)',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13, color: Colors.grey.shade800, letterSpacing: 0.2),
            ),
            const SizedBox(height: 12),
            const Divider(thickness: 1.1),
            const SizedBox(height: 8),
            Text(
              '25/9/420, Postal Colony, 7th cross lane, SPSR Nellore District, AP\n'
                  'Phone: +91 8985373780  •  Email: afnanshahid744@gmail.com',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              children: [
                ElevatedButton.icon(
                    onPressed: () => _open(github),
                    icon: const Icon(Icons.code),
                    label: const Text('GitHub')),
                OutlinedButton.icon(
                    onPressed: () => _open(linkedin),
                    icon: const Icon(Icons.business),
                    label: const Text('LinkedIn')),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget infoCard({required String title, required Widget child}) {
    return Card(
      elevation: 3,
      shadowColor: Colors.indigo.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child:
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          sectionTitle(title),
          const SizedBox(height: 12),
          child,
        ]),
      ),
    );
  }

  Widget aboutWidget() {
    return const Text(
      'I am a passionate Computer Science student specializing in Artificial Intelligence and Data Science. '
          'I enjoy building Flutter apps (mobile & web), learning cybersecurity tools, and contributing to open-source projects.',
      style: TextStyle(fontSize: 14),
    );
  }

  Widget educationWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
            '2022 — Bachelor’s Degree, NBKR Institute of Science and Technology (AI & Data Science)',
            style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        Text('2022 — Class 12th, Board of Intermediate Education AP — 972/1000'),
        SizedBox(height: 6),
        Text('2020 — Class 10th, Board of Secondary Education AP — 552/600'),
      ],
    );
  }

  Widget skillsWidget() {
    final skills = [
      'Flutter',
      'Dart',
      'Python',
      'Java',
      'SQL (DBMS)',
      'HTML',
      'CSS',
      'JavaScript',
      'NumPy',
      'Android SDK',
      'Git',
      'Kali Linux',
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: skills.map((s) => skillChip(s)).toList(),
    );
  }

  Widget projectsWidget() {
    return Column(
      children: [
        projectCard(
            'Advanced Password Cracker (2025)',
            'Cybersecurity team project implementing bruteforce, rainbow table, and wordlist strategies (for research use).',
            'https://github.com/afnanshahid505/Advance-Password-Cracker.git'),
        const SizedBox(height: 8),
        projectCard(
            'RealEstate App (2025) ',
            'Android app built with Java & Android Studio: user auth, property listings, search & filters.',
            'https://github.com/afnanshahid505/RealEstateApp.git'),
        const SizedBox(height: 8),
        projectCard(
            'Tic-Tac-Toe (Web)',
            'Browser game built using HTML/CSS/JS. Live demo: https://afnanshahid505.github.io/Tic-Tac-Toe/',
            'https://github.com/afnanshahid505/Tic-Tac-Toe'),
        const SizedBox(height: 8),
        projectCard(
            'AI Chatbot',
            'A  personalized Chatbot built using the relavence AI (tool), that answer the pre-defined questions/',
            null),
      ],
    );
  }

  Widget experienceWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Cybersecurity Intern — Supraja Technologies (Jun 2025 - Aug 2025)',
            style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 6),
        Text(
            '- Hands-on experience with Kali Linux, Nmap, Wireshark, Metasploit.\n'
                '- Performed vulnerability assessment and web testing (OWASP Top 10).'),
      ],
    );
  }

  Widget honoursWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('• Cybersecurity Internship at Supraja Technologies (Jun–Aug 2025)'),
        SizedBox(height: 6),
        Text('• Certificates: 3-Day Cybersecurity Workshop, 1-Day Hackathon'),
        SizedBox(height: 6),
        Text('• NPTEL Certificate — Privacy in Online Social Media'),
      ],
    );
  }

  Widget contactCard() {
    return Card(
      color: Colors.indigo.shade50,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: [
            const Text('Get in touch',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                    onPressed: () => _open(email),
                    icon: const Icon(Icons.email),
                    label: const Text('Email')),
                OutlinedButton.icon(
                    onPressed: () => _open(phone),
                    icon: const Icon(Icons.phone),
                    label: const Text('+91 8985373780')),
                TextButton.icon(
                    onPressed: () => _open(github),
                    icon: const Icon(Icons.code),
                    label: const Text('GitHub')),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget footerWidget() {
    return Center(
      child: Column(
        children: const [
          Divider(thickness: 1),
          SizedBox(height: 10),
          Text(
            '© 2025 Shaik Mohammad Afnan Shahid — Built with Flutter',
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
