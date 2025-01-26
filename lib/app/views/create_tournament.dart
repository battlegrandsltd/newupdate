import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:playground/app/views/Admin_Home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class CreateTournament1 extends StatefulWidget {
  const CreateTournament1({super.key});

  @override
  State<CreateTournament1> createState() => _CreateTournament1State();
}

class FormData {
  String? leagueType;
  String? tournamentName;
  String? platform;
  String? game;
  String? tournamentDescription;
  String? tournamentRules;
  String? organizer;
  String? entryType;
  String? entryFee;
  String? cashoutPrize;
  String? rounds;
  String? pointsforwins;
  String? pointsforties;
  String? imageUrl;
}

class _CreateTournament1State extends State<CreateTournament1> {
  final PageController _pageController = PageController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FormData _formData = FormData();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int _currentPage = 0;

  File? _imageFile;
  String? imageUrl;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  /*  Future<void> _uploadImage() async {
    if (_image == null) return;

    try {
      // Create a reference to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Upload the file
      await storageRef.putFile(_image!);

      // Get the download URL
      final downloadUrl = await storageRef.getDownloadURL();

      // Save URL to Firestore
      await FirebaseFirestore.instance.collection('images').add({
        'url': downloadUrl,
        'uploaded_at': Timestamp.now(),
      });

      setState(() {
        imageUrl = downloadUrl;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image uploaded successfully!')),
      );
    } catch (e) {
      print("Error uploading image: $e");
    }
  } */

  Future<void> _submitToFirebase(FormData formData) async {
    try {
      if (_imageFile != null) {
        // Upload image to Firebase Storage
        final storageRef = FirebaseStorage.instance.ref().child(
            'tournament_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

        // Upload the image and wait for the completion
        final uploadTask = await storageRef.putFile(_imageFile!);
        if (uploadTask.state == TaskState.success) {
          // Get the download URL for the uploaded image
          formData.imageUrl = await storageRef.getDownloadURL();
          print("Image uploaded successfully: ${formData.imageUrl}");
        } else {
          print("Image upload failed");
          return; // Exit the function if the image upload fails
        }
      } else {
        print("No image file provided");
      }

      // Add form data to Firestore
      await FirebaseFirestore.instance.collection('tournaments').add({
        'tournamentName': formData.tournamentName,
        'leagueType': formData.leagueType,
        'platform': formData.platform,
        'game': formData.game,
        'tournamentDescription': formData.tournamentDescription,
        'tournamentRules': formData.tournamentRules,
        'organizer': formData.organizer,
        'entryType': formData.entryType,
        'entryFee': formData.entryFee,
        'cashoutPrize': formData.cashoutPrize,
        'rounds': formData.rounds,
        'pointsforwins': formData.pointsforwins,
        'pointsforties': formData.pointsforties,
        'created_at': DateTime.now(),
        'imageUrl': formData.imageUrl, // Include image URL from formData
      });

      // Show success message
      Get.snackbar(
        'Success',
        'Tournament Created',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print(
          "Error during upload or database submission: $e"); // Print the error
      Get.snackbar(
        'Failed',
        'Failed to create tournament: $e', // Show error in snackbar for easier debugging
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _submitForm() {
    Navigator.pop(context);

    _submitToFirebase(_formData); // Call the Firebase submission function
  }

  void initState() {
    super.initState();
    // Firebase initialization can be done here if not done in main()
  }

  void _nextPage() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      if (_currentPage < 3) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        setState(() => _currentPage++);
      } else {
        _submitForm();
      }
    }
  }

  int counter1 = 0;
  int counter2 = 0;
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Tournament')),
      body: Form(
        key: _formKey,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(), // Disable swiping
          children: [
            _buildPage1(),
            _buildPage2(),
            _buildPage3(),
            _buildPage4(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _nextPage,
        child: Icon(_currentPage < 3 ? Icons.arrow_forward : Icons.check),
      ),
    );
  }

  String? _selectedValue;
  Widget _buildPage1() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.shade300,
                  ),
                  height: 40,
                  width: 40,
                  child: const Center(
                    child: Text(
                      '1',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text('Choose a Tournament type')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              child: RadioListTile<String>(
                  title: const Text(
                    'League',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    'Competitors are ranked on a table based on total number of points or average points earned per fixture',
                    style: TextStyle(color: Colors.grey),
                  ),
                  groupValue: _selectedValue,
                  value: 'League',
                  onChanged: (value) {
                    setState(() {
                      _formData.leagueType = value;
                      _selectedValue = value;
                    });
                  }),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              child: RadioListTile<String>(
                  title: const Text(
                    'Knock-Out',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    'Competitors are ranked on a table based on total number of points or average points earned per fixture',
                    style: TextStyle(color: Colors.grey),
                  ),
                  groupValue: _selectedValue,
                  value: 'Knock-Out',
                  onChanged: (value) {
                    setState(() {
                      _formData.leagueType = value;
                      _selectedValue = value;
                    });
                  }),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              child: RadioListTile<String>(
                  title: const Text(
                    'Multi-Stage',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    'Competitors are matched in group stages and qualifiers from each groups progress into the Knockout stage',
                    style: TextStyle(color: Colors.grey),
                  ),
                  groupValue: _selectedValue,
                  value: 'Multi-Stage',
                  onChanged: (value) {
                    setState(() {
                      _formData.leagueType = value;
                      _selectedValue = value;
                    });
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage3() {
    final List<String> _items = ['Free', 'Paid'];
    String? _selectedItem;
    return StatefulBuilder(builder: (context, setState) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.shade300,
                    ),
                    height: 40,
                    width: 40,
                    child: const Center(
                      child: Text(
                        '3',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('Entry Settings')
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select Entry Type';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Entry Type',
                          // hintText: 'Entry Type',
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedItem,
                        icon: const Icon(Icons.arrow_drop_down),
                        onChanged: (String? newValue) {
                          setState(() {
                            _formData.entryType = newValue;
                          });
                        },
                        items: _items
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'What is the Entry fee';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Entry Fee',
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => _formData.entryFee = value,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'What is the Cashout Prize';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Cashout Prize',
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => _formData.cashoutPrize = value,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildPage2() {
    final List<String> _items = ['Xbox', 'Mobile', 'PC', 'Plasystation'];
    String? _selectedItem1;

    final List<String> _items2 = ['COD', 'Free fire', 'Fortnite', 'PUBG'];
    String? _selectedItem2;

    return StatefulBuilder(builder: (context, setState) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.shade300,
                    ),
                    height: 40,
                    width: 40,
                    child: const Center(
                      child: Text(
                        '2',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('Tournament Information')
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 600,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: ListView(
                  children: [
                    // const SizedBox(height: 10),
                    GestureDetector(
                      onTap: _pickImage,
                      child: _imageFile != null
                          ? Image.file(_imageFile!,
                              height: 100, width: 100, fit: BoxFit.cover)
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100],
                              ),
                              height: 100,
                              width: 100,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera_alt, size: 50),
                                  Text('Upload your Banner')
                                ],
                              ),
                            ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Tournament Name',
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'What is the name of the Tournament';
                        }
                        return null;
                      },
                      onSaved: (value) => _formData.tournamentName = value,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a game';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          // labelText: 'Game',
                          hintText: 'Game',
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedItem2,
                        icon: const Icon(Icons.arrow_drop_down),
                        onChanged: (String? newValue) {
                          setState(() {
                            _formData.game = newValue;
                            //  _selectedItem2 = newValue;
                          });
                        },
                        items: _items2
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a Platform';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Platform',
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedItem1,
                        icon: const Icon(Icons.arrow_drop_down),
                        onChanged: (String? newValue) {
                          setState(() {
                            // _selectedItem1 = newValue;
                            _formData.platform = newValue;
                          });
                        },
                        items: _items
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'What is the Tournament Description';
                        }
                        return null;
                      },
                      minLines: 3,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'Tournament Description',
                        // hintText: 'Tournament Description',
                        border: InputBorder.none,
                      ),
                      onSaved: (value) =>
                          _formData.tournamentDescription = value,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'What are the Rules of the Tournament';
                        }
                        return null;
                      },
                      minLines: 3,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        //hintText: 'Tournament Rules',
                        labelText: 'Tournament Rules',
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => _formData.tournamentRules = value,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Who is the Organizer of this Tournament';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Organizer',
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => _formData.organizer = value,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildPage4() {
    // int counter = 0;
    // int counter1 = 0;
    // int counter2 = 0;

    return StatefulBuilder(builder: (context, setState) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.shade300,
                    ),
                    height: 40,
                    width: 40,
                    child: const Center(
                      child: Text(
                        '4',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('League Settings')
                ],
              ),
            ),
            Container(
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                      child: Row(
                        children: [
                          const Text(
                            'Rounds',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (counter > 0) {
                                  counter--;
                                }
                              });
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 31,
                                    width: 31,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '-',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            '$counter',
                          ),
                          const SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                counter++;
                              });
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 31,
                                    width: 31,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '+',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 30)
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Competitors are faced twice against eachother. with the next feature being in the other half of the league',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const Divider(color: Colors.grey),
                    Row(
                      children: [
                        const Text(
                          'Points for Wins',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (counter1 > 0) {
                                counter1--;
                              }
                            });
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 31,
                                  width: 31,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '-',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          '$counter1',
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              counter1++;
                            });
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 31,
                                  width: 31,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '+',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 30)
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Points for Ties',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (counter2 > 0) {
                                counter2--;
                              }
                            });
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 31,
                                  width: 31,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '-',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          '$counter2',
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              counter2++;
                            });
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 31,
                                  width: 31,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '+',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 30)
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const Text('Single Player')
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
