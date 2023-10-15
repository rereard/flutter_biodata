import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:photo_view/photo_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHome());
  }
}

class MyHome extends StatelessWidget {
  final biodata = <String, String>{};

  MyHome({super.key}) {
    biodata['name'] = 'Skipper';
    biodata['email'] = 'skipper69@gmail.com';
    biodata['phone'] = '+628123456789';
    biodata['image'] = 'profil_pic.jpg';
    biodata['hobby'] = 'Memata-matai orang';
    biodata['address'] = 'Kebun Binatang Central Park Amerika Serikat';
    biodata['desc'] =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut euismod eros urna, a venenatis turpis dignissim nec. Suspendisse non purus felis. Donec faucibus ex ante, sed viverra tellus venenatis at. Nulla facilisi. Maecenas luctus id sapien at lacinia. Cras quis dapibus massa. Sed vulputate metus at mi lacinia convallis. Vivamus tellus ipsum, pellentesque vitae lectus vitae, venenatis lobortis dolor. Donec dapibus ut lectus nec laoreet.';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Biodata',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Aplikasi Biodata'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBox(Colors.black, biodata['name']!),
              InkWell(
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhotoViewPage(
                              imageUrl: 'assets/${biodata['image']}'),
                        ),
                      ),
                  child: Hero(
                      tag: 'pp_img',
                      child: Image(
                          image: AssetImage('assets/${biodata['image']}')))),
              spacingBox(),
              Row(
                children: [
                  eleBtn(Icons.email, Colors.redAccent,
                      "mailto:${biodata['email']}"),
                  eleBtn(Icons.phone, Colors.green,
                      "https://wa.me/${biodata['phone']}"),
                  eleBtn(Icons.phone_in_talk_rounded, Colors.blueAccent,
                      "tel:${biodata['phone']}"),
                ],
              ),
              spacingBox(),
              textData('Hobi', biodata['hobby']!),
              spacingBox(),
              textData('Alamat', biodata['address']!),
              spacingBox(),
              textBox(Colors.grey, 'Deskripsi'),
              spacingBox(),
              Text(
                biodata['desc']!,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.justify,
              )
            ],
          ),
        ),
      ),
    );
  }

  Container textBox(Color bgColor, String text) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(color: bgColor),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  SizedBox spacingBox() {
    return const SizedBox(
      height: 10,
    );
  }

  Row textData(String title, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80,
          child: Text(
            '• $title',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        const Text(': ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }

  Expanded eleBtn(IconData icon, Color bgColor, String uri) {
    return Expanded(
      child: ElevatedButton(
          onPressed: () {
            launch(uri);
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: bgColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0))),
          child: Icon(icon)),
    );
  }

  void launch(String uri) async {
    if (!await launchUrl(Uri.parse(uri))) {
      throw Exception('Tidak dapat memanggil $uri');
    }
  }
}

class PhotoViewPage extends StatelessWidget {
  final String imageUrl;
  const PhotoViewPage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: PhotoView(
        imageProvider: AssetImage(imageUrl),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2.0,
        initialScale: PhotoViewComputedScale.contained,
        heroAttributes: const PhotoViewHeroAttributes(tag: "pp_img"),
      ),
    );
  }
}
