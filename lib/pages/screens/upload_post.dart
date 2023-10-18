// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, void_checks, sort_child_properties_last, prefer_final_fields
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:properties_app/pages/home_page.dart';
import 'package:properties_app/resources/firestore_methods.dart';
import 'package:properties_app/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);
  //final String uid;

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  Uint8List? _file;
  final TextEditingController _aboutHouseController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _bedroomController = TextEditingController();
  final TextEditingController _bathroomController = TextEditingController();
  final TextEditingController _garageController = TextEditingController();
  final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _agentName = TextEditingController();
  final TextEditingController _agentPhoneNumbers = TextEditingController();
  final TextEditingController _agentWhatsApp = TextEditingController();
  final TextEditingController _houseLocationController =
      TextEditingController();

  String? value;
  String? typeOfProperty;
  String? district;

  final listItem = ['Per Month', 'For Sale'];
  final typesOfProperties = [
    'Stand alone House',
    'Townhouse',
    'Duplex',
    'Apartment',
    'Farm',
    'Vacant Land',
    'Commercial Property',
  ];
  final discricts = [
    'Maseru',
    'Leribe',
    'Berea',
    'Butha-Buthe',
    'Quthing',
    'Mohales Hoek',
    'Qachas Neck',
    'Mokhotlong',
    'Quthing',
    'Mafeteng'
  ];

  final ImagePicker _picker = ImagePicker();
  List<File> _selectedFiles = [];
  //FirebaseStorage _storage = FirebaseStorage.instance;
  //late CollectionReference imgRef;
  DateTime _dateTime = DateTime.now();

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
            firstDate: DateTime(2022, 1, 1),
            lastDate: DateTime(2030, 12, 31))
        .then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  bool _isLoading = false;
  bool forRent = true;

  var userData = {};

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ));

  void postImage(String phoneNumbers, String uid, String username,
      String profImage) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FireStoreMethods()
          .uploadPost(
              _houseNameController.text,
              _aboutHouseController.text,
              _houseLocationController.text,
              DateFormat('d/M/y').format(_dateTime).toString(),
              //_dateAvailableController.text,
              //_selectedFiles,
              _file!,
              uid,
              username,
              profImage,
              _bedroomController.text,
              _bathroomController.text,
              _priceController.text,
              _garageController.text,
              _selectedFiles,
              value.toString(),
              _agentName.text,
              _agentPhoneNumbers.text,
              phoneNumbers,
              _agentWhatsApp.text,
              typeOfProperty.toString(),
              district.toString())
          .whenComplete(() {
        return Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      });

      // for (var img in _selectedFiles) {
      //   CollectionReference imgRef = FirebaseFirestore.instance
      //       .collection('posts')
      //       .doc('${_houseNameController.text}')
      //       .collection('collectionPath');

      //   Reference ref = FirebaseStorage.instance
      //       .ref()
      //       .child('houses/${Path.basename(img.path)}');
      //   await ref.putFile(img).whenComplete(() async {
      //     await ref.getDownloadURL().then((value) {
      //       imgRef.add({'url': value});
      //     });
      //   });
      // }

      // CollectionReference imgRef =
      //       FirebaseFirestore.instance.collection('selectedFiles');
      // @override
      // initState() {
      //   super.initState();

      // }

      if (res == "success") {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Posted', context);
        clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  //Selecting an image from camera
  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Upload a house'),
            children: [
              // SimpleDialogOption(
              //   padding: const EdgeInsets.all(20),
              //   child: const Text('Take a photo'),
              //   onPressed: () async {
              //     Navigator.of(context).pop();
              //     Uint8List file = await pickImage(ImageSource.camera);
              //     setState(() {
              //       _file = file;
              //     });
              //   },
              // ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  //Starting the upload proccess from scratch after succefully posted picture
  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _aboutHouseController.dispose();
    _bedroomController.dispose();
    _bathroomController.dispose();
    _priceController.dispose();
    _garageController.dispose();
    _agentName.dispose();
    _agentPhoneNumbers.dispose();
    _agentWhatsApp.dispose();
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<UserProvider>(context).getUser;

    if (userData['paid'] == false) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Text(
          'Only registered agents can list houses, you can list through any of our trusted agents.',
          style: TextStyle(color: Colors.blueGrey),
        )),
      );
    } else {
      return _file == null
          ? Scaffold(
              appBar: AppBar(
                title: Text('Select Images'),
                actions: [
                  GestureDetector(
                      onTap: (() => _selectImage(context)),
                      child: Icon(Icons.upload_file_sharp))
                ],
              ),
              body: _selectedFiles.isEmpty
                  ? Scaffold(
                      body: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Please choose images below then continue to choose the display image at the upload button',
                            style:
                                TextStyle(fontSize: 16, color: Colors.blueGrey),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: GestureDetector(
                                  onTap: () {
                                    chooseImage();
                                  },
                                  child: Icon(Icons.add))),
                        ],
                      ),
                    )
                  : GridView.builder(
                      itemCount: _selectedFiles.length + 1,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return index == 0
                            ? Center(
                                child: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  chooseImage();
                                },
                              ))
                            : Container(
                                margin: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(
                                            _selectedFiles[index - 1]),
                                        fit: BoxFit.cover)),
                              );
                      }),
              // body: Center(
              //   child: IconButton(
              //     icon: const Icon(Icons.upload),
              //     onPressed: () => _selectImage(context),
              //   ),
              // ),
            )
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: clearImage,
                ),
                title: const Text('Post House'),
                centerTitle: false,
                actions: [
                  TextButton(
                    onPressed:
                        // () =>
                        // _houseNameController.text.isEmpty &&
                        //         _aboutHouseController.text.isEmpty &&
                        //         _houseLocationController.text.isEmpty &&
                        //         _bedroomController.text.isEmpty &&
                        //         _bathroomController.text.isEmpty &&
                        //         _priceController.text.isEmpty &&
                        //         _garageController.text.isEmpty &&
                        //         _agentName.text.isEmpty &&
                        //         _agentPhoneNumbers.text.isEmpty &&
                        //         _agentWhatsApp.text.isEmpty
                        //     // &&
                        //     // _dateTime.toString().isEmpty &&
                        //     // _dateTime.toString().isEmpty &&
                        //     // typeOfProperty.toString().isEmpty &&
                        //     // district.toString().isEmpty
                        //     ? {
                        //         //_houseNameController.text = "Not available",
                        //         showSnackBar('Please Fill All Fields', context)
                        //       }
                        //     :
                        () => postImage(
                            userData['phoneNumbers'],
                            userData['uid'],
                            userData['username'],
                            userData['photoUrl']),
                    child: const Text('Post',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                ],
                //system overlay is for making app bar transparent
                systemOverlayStyle: SystemUiOverlayStyle.dark,
              ),
              body: SingleChildScrollView(
                  child: Form(
                child: Column(
                  children: [
                    _isLoading
                        ? const LinearProgressIndicator()
                        :
                        //Container(),
                        Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(children: [
                              Row(
                                //space around avatar and about house info
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // CircleAvatar(
                                  //   backgroundImage:
                                  //       NetworkImage(userData['photoUrl']),
                                  // ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: TextFormField(
                                        onFieldSubmitted: (String _) {
                                          setState(() {
                                            showSnackBar(
                                                'Please enter about house',
                                                context);
                                          });
                                        },
                                        controller: _aboutHouseController,
                                        decoration: const InputDecoration(
                                            hintText: 'Write About House...',
                                            border: InputBorder.none),
                                        maxLines: 5,
                                      )),
                                  SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: AspectRatio(
                                      aspectRatio: 487 / 451,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: MemoryImage(_file!),
                                                fit: BoxFit.fill,
                                                alignment: FractionalOffset
                                                    .topCenter)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButton<String>(
                                    borderRadius: BorderRadius.circular(10),
                                    focusColor: Colors.black,
                                    isExpanded: true,
                                    value: value,
                                    hint: Text('Rent or Sale'),
                                    items: listItem.map(buildMenuItem).toList(),
                                    onChanged: (value) =>
                                        setState(() => this.value = value),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: typeOfProperty,
                                    hint: Text('Type of property'),
                                    items: typesOfProperties
                                        .map(buildMenuItem)
                                        .toList(),
                                    onChanged: (value) =>
                                        setState(() => typeOfProperty = value),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: district,
                                  hint: Text('District'),
                                  items: discricts.map(buildMenuItem).toList(),
                                  onChanged: (value) =>
                                      setState(() => district = value),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                    padding: EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: TextFormField(
                                      // validator: (value) {
                                      //   if (value!.isEmpty) {
                                      //     return 'Fill The Banks';
                                      //   }
                                      // },
                                      keyboardType: TextInputType.text,
                                      controller: _houseLocationController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                              'Please enter location of house'),
                                    )),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                    padding: EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: TextField(
                                      controller: _houseNameController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                              'Please enter name of house'),
                                    )),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                    padding: EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: _priceController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                              'Please enter price of House'),
                                    )),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                    padding: EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: _bedroomController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                              'Please enter number of bedrooms'),
                                    )),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                    padding: EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: _bathroomController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                              'Please enter number of bathrooms'),
                                    )),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                    padding: EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: _garageController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                              'Please enter number garages'),
                                    )),
                              ),
                              // SizedBox(height: 5),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 5.0),
                              //   child: Container(
                              //       padding: EdgeInsets.only(left: 20),
                              //       decoration: BoxDecoration(
                              //           color: Colors.grey[200],
                              //           border: Border.all(color: Colors.white),
                              //           borderRadius: BorderRadius.circular(12)),
                              //       child: TextField(
                              //         keyboardType: TextInputType.text,
                              //         controller: _agentName,
                              //         decoration: InputDecoration(
                              //             border: InputBorder.none,
                              //             hintText: 'Please enter agent name'),
                              //       )),
                              // ),
                              // SizedBox(height: 5),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 5.0),
                              //   child: Container(
                              //       padding: EdgeInsets.only(left: 20),
                              //       decoration: BoxDecoration(
                              //           color: Colors.grey[200],
                              //           border: Border.all(color: Colors.white),
                              //           borderRadius: BorderRadius.circular(12)),
                              //       child: TextField(
                              //         keyboardType: TextInputType.number,
                              //         controller: _agentPhoneNumbers,
                              //         decoration: InputDecoration(
                              //             border: InputBorder.none,
                              //             hintText:
                              //                 'Please enter agent phone numbers'),
                              //       )),
                              // ),
                              // SizedBox(height: 5),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 5.0),
                              //   child: Container(
                              //       padding: EdgeInsets.only(left: 20),
                              //       decoration: BoxDecoration(
                              //           color: Colors.grey[200],
                              //           border: Border.all(color: Colors.white),
                              //           borderRadius: BorderRadius.circular(12)),
                              //       child: TextField(
                              //         keyboardType: TextInputType.number,
                              //         controller: _agentWhatsApp,
                              //         decoration: InputDecoration(
                              //             border: InputBorder.none,
                              //             hintText:
                              //                 'Please enter agent whatsapp numbers'),
                              //       )),
                              // ),
                              SizedBox(height: 5),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: MaterialButton(
                                  onPressed: _showDatePicker,
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text('Date Available',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                  ),
                                  color: Colors.blue,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                    padding: EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Text(
                                      DateFormat('d/M/y').format(_dateTime),
                                      style: TextStyle(fontSize: 30),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ]),
                          ),
                  ],
                ),
              )
                  // child:
                  ),
            );
    }
  }

  chooseImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _selectedFiles.add(File(pickedFile!.path));
    });
    if (pickedFile!.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
  }
}
