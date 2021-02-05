import 'package:flutter/widgets.dart';

class MyContactSelection extends ChangeNotifier {
  List<String> _selectedId;
  String _selectedName;
  List<String> _selectedPhoto;

  MyContactSelection(this._selectedId, this._selectedPhoto);

  void selectContacts(String id, String photo) {
    if (!_selectedId.contains(id)) {
      _selectedId.add(id);
      print(_selectedId);
    } else {
      _selectedId.remove(id);
      print(_selectedId);
    }

    if (!_selectedPhoto.contains(photo)) {
      _selectedPhoto.add(photo);
      print(_selectedPhoto);
    } else {
      _selectedPhoto.remove(photo);
      print(_selectedPhoto);
    }
    notifyListeners();
  }

  void selectOneContact(String id, String name, String photo) {
    if (_selectedId.isEmpty) {
      _selectedId.add(id);
      _selectedName = name;
      print(_selectedId);
    } else {
      _selectedId.remove(id);
      _selectedName = '';
      print(_selectedId);
    }

    if (_selectedPhoto.isEmpty) {
      _selectedPhoto.add(photo);
      print(_selectedPhoto);
    } else {
      _selectedPhoto.remove(photo);
      print(_selectedPhoto);
    }
    notifyListeners();
  }

  void clearContactSelection() {
    _selectedId.clear();
    _selectedPhoto.clear();
    _selectedName = '';
  }

  List<String> get selectedId => _selectedId;

  List<String> get selectedPhoto => _selectedPhoto;

  String get selectedName => _selectedName;
}
