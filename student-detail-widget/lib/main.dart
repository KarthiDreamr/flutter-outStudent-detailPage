import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animate Run',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StudentDetailList(),
    );
  }
}

class StudentDetailList extends StatefulWidget {
  const StudentDetailList({super.key});

  @override
  State<StudentDetailList> createState() => _StudentDetailListState();
}

class _StudentDetailListState extends State<StudentDetailList> {
  late Map<String, Map<String, Map<String, String>>> hjson;
  late Map<String, Map<String, String>> snih;
  late List<String> snihKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hjson = {
      "students_not_in_hostel": {
        "Nandhana": {
          "name": "Nandhana",
          "uid": "20BCS028",
          "hostel_block": "WH1",
          "hostel_room_number": "105",
          "last_check_out": "2023-08-13T10:23:45.678901",
          "status": "Dinner",
          "phone": "8637497248"
        },
        "Riya Sharma": {
          "name": "Riya Sharma",
          "uid": "20BCE034",
          "hostel_block": "WH2",
          "hostel_room_number": "312",
          "last_check_out": "2023-08-15T14:56:12.345678",
          "status": "Library",
          "phone": "9876543210"
        },
        "Priya Jain": {
          "name": "Priya Jain",
          "uid": "20BCA056",
          "hostel_block": "WH3",
          "hostel_room_number": "205",
          "last_check_out": "2023-08-17T18:34:56.123456",
          "status": "Movie Night",
          "phone": "7654321987"
        },
        "Rajesh Kumar": {
          "name": "Rajesh Kumar",
          "uid": "20BME012",
          "hostel_block": "MH1",
          "hostel_room_number": "101",
          "last_check_out": "2023-08-23T06:23:45.678912",
          "status": "Gym",
          "phone": "8765432190"
        },
        "Saai Vignesh": {
          "name": "Saai Vignesh",
          "uid": "20BIT045",
          "hostel_block": "MH2",
          "hostel_room_number": "204",
          "last_check_out": "2023-08-04T19:28:24.523461",
          "status": "Purchasing Essentials",
          "phone": "9514698718"
        },
        "Karthik Raja": {
          "name": "Karthik Raja",
          "uid": "20BIT023",
          "hostel_block": "MH3",
          "hostel_room_number": "303",
          "last_check_out": "2023-08-21T02:45:67.891234",
          "status": "Birthday Party",
          "phone": "6543219876"
        },
        "Ramya Raju": {
          "name": "Ramya Raju",
          "uid": "22BIN008",
          "hostel_block": "MH4",
          "hostel_room_number": "407",
          "last_check_out": "2023-08-11T12:45:32.789012",
          "status": "Study Group",
          "phone": "9876543210"
        },
        "Surya Prakash": {
          "name": "Surya Prakash",
          "uid": "21BIP019",
          "hostel_block": "MH5",
          "hostel_room_number": "502",
          "last_check_out": "2023-08-19T22:12:34.567890",
          "status": "Gaming Session",
          "phone": "8765432190"
        }
      }
    };
    snih = hjson["students_not_in_hostel"]!;
    snihKey = snih.keys.toList();
  }

  bool hasTextOverflow(String text, TextStyle style,
      {double minWidth = 0,
      double maxWidth = double.infinity,
      int maxLines = 1}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      // textDirection: TextDirection.LTR ,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
    return textPainter.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Details"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Future<void>.delayed(const Duration(seconds: 10));
        },
        child: ListView.builder(
          itemCount: snih.length,
          itemBuilder: (context, index) {
            String name = snih.keys.elementAt(index);
            Map details = snih[name]!;
            String rollno = details["uid"];
            String block = details["hostel_block"];
            String roomno = details["hostel_room_number"];
            DateFormat dateFormat = DateFormat("yyyy-MM-dd");
            DateFormat timeFormat = DateFormat("HH:mm:ss");
            DateTime dateTime = DateTime.parse(details["last_check_out"]);
            String checkout = dateFormat.format(dateTime);
            String checkin = timeFormat.format(dateTime);
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [Text(block), Text(roomno)],
                  ),
                  title: TextScroll(
                    "$name-$rollno  ",
                    mode: TextScrollMode.endless,
                    pauseBetween: const Duration(seconds: 10),
                    // textDirection: TextDirection.LTR ?? ,
                    textAlign: TextAlign.left,
                  ),
                  subtitle: Text("$checkout  $checkin"),
                  trailing: IconButton(
                    icon: const Icon(Icons.call),
                    onPressed: () {
                      launchUrlString("tel:${details["phone"]}");
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
