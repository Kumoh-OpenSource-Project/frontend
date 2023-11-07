import 'package:flutter/material.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Column(
            children: [
              SizedBox(
                height: 100,
                child: Padding(
                  padding: EdgeInsets.only(left: 35),
                  child: Text(
                    '9˚',
                    style: TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 32,
                    child: Icon(
                      Icons.arrow_drop_up,
                      size: 40,
                    ),
                  ),
                  Text(
                    '9˚',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 32,
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: 40,
                    ),
                  ),
                  Text(
                    '6˚',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            width: 30,
          ),
          Container(
            width: 170,
            height: 110,
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.white,
                  width: 1.3,
                ),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '체감 기온 7˚',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '현재 습도 66%',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '바람 세기 3.65km/h',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '바람 방향 북서풍',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
