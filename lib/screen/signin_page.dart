import 'package:flutter/material.dart';
import 'package:knitting_production_planning/model/machine_model.dart';
import 'package:knitting_production_planning/screen/dashboard_page.dart';
import 'package:knitting_production_planning/screen/floor_page.dart';
import 'package:knitting_production_planning/screen/home_page.dart';
import 'package:knitting_production_planning/screen/machine_admin_page.dart';
import 'package:knitting_production_planning/screen/planner_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.blueGrey.shade900,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.business, size: 80, color: Colors.white),
                    SizedBox(height: 10),
                    Text(
                      "Epyllion R&D and Knitting",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Sign In",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 30),
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = !rememberMe;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("This feature is coming. Stay tune"),
                                ),
                              );
                            },
                          ),
                          const Text("Remember Me"),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("This feature is coming. Stay tune"),
                            ),
                          );
                        },
                        child: const Text("Forgot Password?"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (usernameController.text == "executive" &&
                            passwordController.text == "123") {
                          usernameController.text == "";
                          passwordController.text == "";
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (Route<dynamic> route) => false,
                          );
                        } else if (usernameController.text == "machine-admin" &&
                            passwordController.text == "123") {
                          usernameController.text == "";
                          passwordController.text == "";
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MachineAdminPage()),
                            (Route<dynamic> route) => false,
                          );
                        } else if (usernameController.text == "planner" &&
                            passwordController.text == "123") {
                          usernameController.text == "";
                          passwordController.text == "";
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PlannerPage()),
                            (Route<dynamic> route) => false,
                          );
                        } else if (usernameController.text == "efl-ext-floor" &&
                            passwordController.text == "123") {
                          usernameController.text == "";
                          passwordController.text == "";
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FloorPage(
                                      floorName: Floor.EFL_Extension,
                                    )),
                            (Route<dynamic> route) => false,
                          );
                        } else if (usernameController.text == "sr. manager" &&
                            passwordController.text == "123") {
                          usernameController.text == "";
                          passwordController.text == "";
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DashboardPage()),
                            (Route<dynamic> route) => false,
                          );
                        }
                      },
                      child:
                          const Text("Sign In", style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
