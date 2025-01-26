import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TournamentDetailsPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const TournamentDetailsPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: ListView(children: [
        Stack(
          children: [
            Container(
              height: 380,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/pubg-game-banner.png'), // Update with the correct path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 15, right: 15),
              child: Container(
                height: 280,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      data['tournamentName'] ?? 'Tournament Name',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      data['leagueType'] ?? 'One-on-One',
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    const SizedBox(height: 20),

                    // const SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Text('Platform:'),
                        SizedBox(width: 10),
                        Text(
                          data['platform'] ?? 'platform',
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Text('Entry Fee: '),
                        Text(
                          data['entryFee'] ?? 'Entry fee',
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Text('Cashout Prize: '),
                        Text(
                          data['cashoutPrize'] ?? 'prize',
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Text('Date: '),
                        Text(
                          data['created_at'] != null
                              ? DateFormat('dd-MM-yyyy').format(
                                  (data['created_at'] as Timestamp).toDate())
                              : 'No Date available',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage:
                                AssetImage('assets/images/logo.png'),
                          ),
                          SizedBox(width: 5),
                          Text('Organizer: '),
                          Text(
                            data['organizer'] ?? 'Admin',
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 16),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              child: ElevatedButton(
                                  onPressed: () {}, child: const Text('Enter')),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.shade300),
                  child: Icon(Icons.arrow_back_ios_new),
                ),
              ),
            )
            /*   // Background Image
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/logo.png'), // Update with the correct path
                  fit: BoxFit.cover,
                ),
              ),
            ),
        
            // Back Button
            Positioned(
              top: 40,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
        
            // Details Content
            Positioned(
              top: 200,
              left: 0,
              right: 0,
              bottom: 100,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tournament Name and Type
                    Text(
                      data['tournamentName'] ?? 'Tournament Name',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      data['leagueType'] ?? 'One-on-One',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    SizedBox(height: 10),
        
                    // Additional Information Row
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.black54),
                        SizedBox(width: 5),
                        Text("10 hours ago",
                            style: TextStyle(
                                color: Colors
                                    .black54)), // Replace with actual data if available
                        SizedBox(width: 15),
                        Icon(Icons.attach_money, color: Colors.black54),
                        SizedBox(width: 5),
                        Text("\$${data['cashoutPrize']}",
                            style: TextStyle(color: Colors.black54)),
                        SizedBox(width: 15),
        
                        SizedBox(width: 5),
                        /*  Text(
                          "https://www.twitch.tv/example",
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ), */
                      ],
                    ),
                    SizedBox(height: 10),
        
                    // Organizer Info and Accept Button
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                              'assets/images/logo.png'), // Update the path as needed
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            data['organizer'] ?? 'Organizer Name',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Accept button action
                          },
                          child: Text("ACCEPT"),
                          style: ElevatedButton.styleFrom(
                            // primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
        
                    // Tabs for About, Chat, and Result
                    DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
                          TabBar(
                            indicatorColor: Colors.blue,
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            tabs: [
                              Tab(text: "About"),
                              Tab(text: "Chat"),
                              Tab(text: "Result"),
                            ],
                          ),
                          SizedBox(
                            height: 300,
                            child: TabBarView(
                              children: [
                                // About Tab Content
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data['tournamentDescription'] ??
                                        "Tournament details go here.",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ),
        
                                // Chat Tab Content (Placeholder for now)
                                Center(
                                    child: Text("Chat functionality will go here",
                                        style: TextStyle(color: Colors.black))),
        
                                // Result Tab Content (Placeholder for now)
                                Center(
                                    child: Text("Result details will go here",
                                        style: TextStyle(color: Colors.black))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),*/
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 700,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Colors.blue,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(text: "Description"),
                        Tab(text: "Rules"),
                        Tab(text: "Result"),
                      ],
                    ),
                    SizedBox(
                      height: 300,
                      child: TabBarView(
                        children: [
                          // About Tab Content
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              data['tournamentDescription'] ??
                                  "Tournament details.",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              data['tournamentRules'] ?? "Rules",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),

                          // Result Tab Content (Placeholder for now)
                          Center(
                              child: Text("Indicate whether you lost or won",
                                  style: TextStyle(color: Colors.black))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
