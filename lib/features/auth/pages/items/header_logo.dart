import 'package:flutter/material.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFFf1f1f1), Color(0xFFdedede)],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 80.0, bottom: 20),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: 100,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "TOKO KLONTONG GEMA",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
