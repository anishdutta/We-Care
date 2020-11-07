import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:documents_picker/documents_picker.dart';

int _selectedItemIndex = 2;

class FormHere extends StatefulWidget {
  @override
  _FormHereState createState() => _FormHereState();
}

class _FormHereState extends State<FormHere> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final picker = ImagePicker();
  File _imageFile;
  List<String> docPaths;

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  Future pickImage2() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  void _getDocuments() async {
    docPaths = await DocumentsPicker.pickDocuments;
    if (!mounted) return;
    setState(() {
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: new Text('Document Uploaded!')));
    });
  }

  GestureDetector buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        height: 60,
        decoration: index == _selectedItemIndex
            ? BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 4, color: Colors.green)),
                gradient: LinearGradient(colors: [
                  Colors.green.withOpacity(0.3),
                  Colors.green.withOpacity(0.016),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter))
            : BoxDecoration(),
        child: Icon(
          icon,
          color: index == _selectedItemIndex ? Color(0XFF00B868) : Colors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          buildNavBarItem(Icons.home, 0),
          buildNavBarItem(Icons.map, 1),
          buildNavBarItem(Icons.monetization_on, 2),
          buildNavBarItem(Icons.person, 3),
        ],
      ),
      appBar: new AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, '/dashboard', (route) => false),
        ),
        title: new Text('Ask to Donate'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: new SafeArea(
            top: false,
            bottom: false,
            child: new Form(
                key: _formKey,
                // ignore: deprecated_member_use
                autovalidate: true,
                child: new ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: <Widget>[
                    new TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.attach_file),
                        hintText: '',
                        labelText: 'Funds For',
                      ),
                    ),
                    new TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.location_on),
                        hintText: '',
                        labelText: 'Location',
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    new TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.description),
                        hintText: '',
                        labelText: 'Description',
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 9,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.monetization_on),
                        hintText: '',
                        labelText: 'Total funds required',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: _imageFile != null
                                ? Image.file(_imageFile)
                                : FlatButton(
                                    child: Icon(
                                      Icons.add_a_photo,
                                      size: 50,
                                    ),
                                    onPressed: pickImage,
                                  ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: _imageFile != null
                                ? Image.file(_imageFile)
                                : FlatButton(
                                    child: Icon(
                                      Icons.filter,
                                      size: 50,
                                    ),
                                    onPressed: pickImage2,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Center(
                        child: RaisedButton(
                          onPressed: () => _getDocuments(),
                          child: Text('Upload Document'),
                        ),
                      ),
                    ),
                    new TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.supervised_user_circle),
                        hintText: '',
                        labelText: 'Name',
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    new TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.email),
                        hintText: '',
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.phone),
                        hintText: 'Enter a phone number',
                        labelText: 'Phone',
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        // ignore: deprecated_member_use
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                    ),
                    Container(
                        padding: const EdgeInsets.only(
                            left: 40.0, top: 20.0, bottom: 20.0, right: 40.0),
                        child: new RaisedButton(
                          color: Colors.green,
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () => uploadToFirebase(context),
                        )),
                  ],
                ))),
      ),
    );
  }

  Future uploadToFirebase(BuildContext context) async {
    //   String fileName = basename(_imageFile.path);
    //   StorageReference firebaseStorageRef =
    //   FirebaseStorage.instance.ref().child('Contests/$fileName');
    //   StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    //   StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    //   taskSnapshot.ref.getDownloadURL().then(
    //
    //
    //         (value) {
    //       Flushbar(
    //         title:  "Success",
    //         message:  "Your image has been added !",
    //         duration:  Duration(seconds: 3),
    //       )..show(context);
    //       print(value);
    //       url= value;
    //     },
    //
    //   );
  }
}
