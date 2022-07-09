import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifehack22/services/event_database.dart';
import 'package:lifehack22/services/storage.dart';
import 'package:lifehack22/shared/constants.dart';

class NewEvent extends StatefulWidget {
  const NewEvent({Key? key}) : super(key: key);

  @override
  State<NewEvent> createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {

  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // values of the form fields
  String _title = '';
  int _quota = 0;
  DateTime _dateTime = DateTime.now();
  String? _region;
  String? _type;
  String? _community;
  String _description = '';
  String _thumbnail = 'https://ankawahc.org/wp-content/uploads/2021/06/Asset-1@2x-50.jpg';
  XFile? _currImage;

  // if date time chosen is earlier than the current time
  String _error = '';

  final List<String> _regions = ['North', 'South', 'East', 'West', 'Central'];
  final List<String> _types = ['Cooking', 'Packing', 'Delivery', 'Interaction', 'Logistics', 'Others'];
  final List<String> _communityGroups = ['Elderly', 'Youths', 'Disabled', 'Migrants', 'Low-Income', 'Others'];

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 250,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: darkestPink,
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: CupertinoTheme(
            data: const CupertinoThemeData(
              brightness: Brightness.dark // turns the picker text white
            ),
            child: CupertinoDatePicker(
              minimumDate: DateTime.now(),
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (value) async {
                setState(() => _dateTime = value);
              },
            ),
          ),
        ),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: Container(
          color: darkestPink,
          child: SafeArea(
            child: Center(
              child: Container(
                color: darkestPink,
                height: 75,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        iconSize: 45.0,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Text(
                      'New Event',
                      style: helveticaTextStyle.copyWith(fontSize: 36.0),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Column(
              children: <Widget>[
                TextFormField( // title
                  decoration: formFieldDeco.copyWith(hintText: 'Title'),
                  style: formInputTextStyle.copyWith(fontSize: 18.0),
                  validator: (value) =>
                  value!.trim().isEmpty
                      ? 'Enter a title for your event.'
                      : null,
                  onChanged: (value) {
                    setState(() => _title = value.trim());
                  },
                ),
                horizontalGapBox,
                TextFormField( // quota
                  decoration: formFieldDeco.copyWith(hintText: 'Quota'),
                  style: formInputTextStyle.copyWith(fontSize: 18.0),
                  validator: (value) =>
                  value!.trim().isEmpty
                      ? 'Enter the maximum number of volunteers you need.'
                      : int.tryParse(value) == null
                      ? 'Enter an integer.'
                      : int.parse(value) <= 0
                      ? 'Enter a positive integer.'
                      : null,
                  onChanged: (value) {
                    if (int.tryParse(value) != null) {
                      setState(() => _quota = int.parse(value));
                    }
                  },
                ),
                horizontalGapBox,
                Container(
                  width: 300.0,
                  height: 50.0,
                  decoration: const BoxDecoration(
                    color: darkestPink,
                    shape: BoxShape.rectangle,
                  ),
                  child: CupertinoButton(
                    onPressed: () {
                      _showDialog(widget);
                    },
                    child: Text(
                      _dateTime.toString().substring(0, 16),
                      style: helveticaTextStyle.copyWith(fontSize: 18.0),
                    ),
                  ),
                ),
                horizontalGapBox,
                DropdownButtonFormField2( // region
                  decoration: formFieldDeco.copyWith(
                    hintText: 'Region',
                    hintStyle: helveticaTextStyle.copyWith(fontSize: 18.0, color: darkestPink),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_sharp),
                  iconEnabledColor: darkestPink,
                  iconSize: 30,
                  buttonHeight: 27.0,
                  dropdownDecoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.white,
                  ),
                  dropdownElevation: 0,
                  dropdownMaxHeight: 180.0,
                  itemHeight: 35.0,
                  items: _regions.map((region) {
                    return DropdownMenuItem<String>(
                      value: region,
                      child: SizedBox(
                        width: 145.0,
                        height: 27.0,
                        child: Text(
                          region,
                          style: helveticaTextStyle.copyWith(color: darkestPink, fontSize: 18.0),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      setState(() {
                        _region = value as String;
                      }),
                  value: _region,
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a region.';
                    } else {
                      return null;
                    }
                  },
                ),
                horizontalGapBox,
                DropdownButtonFormField2( // type
                  decoration: formFieldDeco.copyWith(
                    hintText: 'Type of Event',
                    hintStyle: helveticaTextStyle.copyWith(fontSize: 18.0, color: darkestPink),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_sharp),
                  iconEnabledColor: darkestPink,
                  iconSize: 30,
                  buttonHeight: 27.0,
                  dropdownDecoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.white,
                  ),
                  dropdownElevation: 0,
                  dropdownMaxHeight: 220.0,
                  itemHeight: 35.0,
                  items: _types.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: SizedBox(
                        width: 145.0,
                        height: 27.0,
                        child: Text(
                          type,
                          style: helveticaTextStyle.copyWith(color: darkestPink, fontSize: 18.0),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      setState(() {
                        _type = value as String;
                      }),
                  value: _type,
                  validator: (value) {
                    if (value == null) {
                      return 'Please select an event type.';
                    } else {
                      return null;
                    }
                  },
                ),
                horizontalGapBox,
                DropdownButtonFormField2( // cause
                  decoration: formFieldDeco.copyWith(
                    hintText: 'Community',
                    hintStyle: helveticaTextStyle.copyWith(fontSize: 18.0, color: darkestPink),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_sharp),
                  iconEnabledColor: darkestPink,
                  iconSize: 30,
                  buttonHeight: 27.0,
                  dropdownDecoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.white,
                  ),
                  dropdownElevation: 0,
                  dropdownMaxHeight: 220.0,
                  itemHeight: 35.0,
                  items: _communityGroups.map((group) {
                    return DropdownMenuItem<String>(
                      value: group,
                      child: SizedBox(
                        width: 145.0,
                        height: 27.0,
                        child: Text(
                          group,
                          style: helveticaTextStyle.copyWith(color: darkestPink, fontSize: 18.0),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      setState(() {
                        _community = value as String;
                      }),
                  value: _community,
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a community your event supports.';
                    } else {
                      return null;
                    }
                  },
                ),
                horizontalGapBox,
                TextFormField( // description
                  maxLines: null,
                  decoration: formFieldDeco.copyWith(hintText: 'Description'),
                  style: formInputTextStyle.copyWith(fontSize: 18.0),
                  validator: (value) =>
                  value!.trim().isEmpty
                      ? 'Please provide more details about your event.'
                      : null,
                  onChanged: (value) {
                    setState(() => _description = value.trim());
                  },
                ),
                horizontalGapBox,
                horizontalGapBox,
                Container(
                  width: 140.0,
                  height: 60.0,
                  decoration: largeRadiusRoundedBox1,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(5.0),
                      primary: Colors.white,
                      textStyle: helveticaTextStyle.copyWith(fontSize: 18.0),
                    ),
                    child: const AutoSizeText(
                      'Attach Thumbnail',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                    onPressed: () async {
                      // open gallery to select an image
                      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

                      if (image != null) { // image selected
                        String newURL = await Storage().uploadFile(image, uid, false);
                        setState(() {
                          _thumbnail = newURL;
                          _currImage = image;
                        });
                      }

                    },
                  ),
                ),
                horizontalGapBox,
                Container(
                  height: 100.0,
                  color: transparent,
                  child: Center(child: Image.network(_thumbnail)),
                ),
                horizontalGapBox,
                horizontalGapBox,
                Text(
                  _error,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                  ),
                  maxLines: 1,
                ),
                horizontalGapBox,
                Container(
                  width: 190.0,
                  height: 55.0,
                  decoration: largeRadiusRoundedBox1,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(5.0),
                      primary: Colors.white,
                      textStyle: helveticaTextStyle.copyWith(fontSize: 25.0),
                    ),
                    child: const AutoSizeText('Create Event', maxLines: 1),
                    onPressed: () async {
                      if (_dateTime.compareTo(DateTime.now()) <= 0) {
                        setState(() => _error = 'Please choose another date and time.');
                      } else if (_formKey.currentState!.validate()) {
                        String url;
                        if (_currImage == null) {
                          url = _thumbnail;
                        } else {
                          url = await Storage().uploadFile(_currImage!, uid, true);
                        }

                        EventDatabase().createNewEvent(
                            url, _title, Timestamp.fromDate(_dateTime), _region!,
                            _quota, _type!, _community!, _description, uid
                        );

                        if (!mounted) return;
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
