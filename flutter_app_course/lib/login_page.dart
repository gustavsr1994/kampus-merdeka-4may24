import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? username;
  String? password;
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    var sizeWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
        title: const Text('Login Page'),
        actions: const [Icon(Icons.star), Icon(Icons.alarm)],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: [
              SizedBox(
                  width: sizeWidth / 2,
                  child: Image.asset('lib/assets/images/logo-coursenet.png')),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blue),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Row(
                  children: [
                    Image.network(
                      'https://cdn-images-1.medium.com/v2/resize:fit:1200/1*5-aoK8IBmXve5whBQM90GA.png',
                      fit: BoxFit.cover,
                      height: sizeWidth / 6,
                    ),
                    const Expanded(
                      child: Text(
                        'Selamat Datang di Kampus Merdeka',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'Username',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10))))),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          icon: Icon(obscurePassword == true
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10))))),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Phone',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10))))),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, elevation: 5),
                onPressed: () {
                  setState(() {
                    username = usernameController.text;
                    password = passwordController.text;
                  });
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'lib/assets/icons/gmail.svg',
                    ),
                    const Text("Login",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ],
                ),
              ),
              Text(
                  'Hello, ${username ?? 'N/A'} dengan password sebagai berikut ${password ?? 'xxx'}')
            ],
          ),
        ),
      ),
    );
  }
}
