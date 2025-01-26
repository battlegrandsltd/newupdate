import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:playground/app/views/admin_tournament_details.dart';

class TournamentList extends StatefulWidget {
  @override
  State<TournamentList> createState() => _TournamentListState();
}

class _TournamentListState extends State<TournamentList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _searchController = TextEditingController();
  String? imageUrl;

  Future<void> _fetchImageUrl() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('images')
          .orderBy('uploaded_at', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          imageUrl = snapshot.docs.first['url'];
        });
      }
    } catch (e) {
      print("Error retrieving image URL: $e");
    }
  }

  String _searchQuery = '';

  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //title: const Text("Tournament List"),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(10),
            child: Padding(
              padding: const EdgeInsets.all(9),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: Icon(Icons.search, color: Colors.grey.shade900),
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade900,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade400,
                ),
              ),
            )),
      ),
      body: StreamBuilder<QuerySnapshot>(
        //Listening to changes in the tournaments collection
        stream: _firestore
            .collection('tournaments')
            .snapshots(includeMetadataChanges: true),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No tournaments found'));
          }

          final filteredDocs = snapshot.data!.docs.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final tournamentName =
                data['tournamentName']?.toString().toLowerCase() ?? '';
            return tournamentName.contains(_searchQuery.toLowerCase());
          }).toList();

          if (filteredDocs.isEmpty) {
            return const Center(child: Text('No matching tournaments found'));
          }
          // Displaying the data in a ListView
          return ListView(
            children: filteredDocs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              // Extracting and formatting the timestamp

              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TournamentDetailsPage(data: data),
                        ),
                      );
                    },
                    child: Container(
                      height: 330,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: imageUrl != null
                                  ? Container(
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(imageUrl!),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    )
                                  : Center(child: CircularProgressIndicator()),
                            ),
                            const SizedBox(height: 15),
                            Text(" ${data['tournamentName']}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text("${data['platform']}"),
                            ),
                            Row(
                              children: [
                                Text(
                                  " ${data['game']}",
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    /*  width: 80,
                                    height: 30, */
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Text('Entry Fee:'),
                                          Text(
                                            " ${data['entryFee']}",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                data['created_at'] != null
                                    ? DateFormat('dd-MM-yyyy').format(
                                        (data['created_at'] as Timestamp)
                                            .toDate())
                                    : 'No Date available',
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.snackbar(
                                  'Success',
                                  'Tournament Deleted',
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );
                                _deleteTournament(document.id, context);
                              },

                              // style: ElevatedButton.styleFrom(primary: Colors.red),
                              child: const Text('Delete Tournament'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            }).toList(),
          );
        },
      ),
    );
  }

  // Function to delete a tournament by its document ID
  Future<void> _deleteTournament(String id, BuildContext context) async {
    try {
      await _firestore.collection('tournaments').doc(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tournament deleted successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to delete tournament: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
