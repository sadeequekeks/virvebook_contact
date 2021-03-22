import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpHelper {
  Future getRequest(String url) async {
    Uri uri = Uri.parse(url);
    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        String data = response.body;

        var decodedData = jsonDecode(data)['payload'];

        return decodedData;
      } else {
        return 'failed';
      }
    } catch (e) {
      return 'failed $e';
    }
  }

  Future getRequestDelete(String url) async {
    Uri uri = Uri.parse(url);
    try {
      http.Response response = await http.delete(uri);
      if (response.statusCode == 200) {
        String data = response.body;

        var decodedData = jsonDecode(data)['payload'];

        return decodedData;
      } else {
        return 'failed';
      }
    } catch (e) {
      return 'failed $e';
    }
  }

  Future postRequest(
      {String fname, String lname, String phone, String url}) async {
    Uri uri = Uri.parse(url);
    try {
      http.Response response = await http.post(uri,
          body: {'fname': '$fname', 'lname': '$lname', 'phone': '$phone'});
      if (response.statusCode == 200) {
        String data = response.body;

        var decodedData = jsonDecode(data);

        return decodedData;
      } else {
        return 'failed';
      }
    } catch (e) {
      return 'failed $e';
    }
  }

  Future getUsersByID(String id) async {
    Map result;
    await HttpHelper()
        .getRequest('http://192.168.43.186:3000/api/v1/contact/$id')
        .then((res) {
      result = res;
      return res;
    });
    return result;
  }

  Future putRequest(
      {String fname, String lname, String phone, String url}) async {
    Uri uri = Uri.parse(url);
    try {
      http.Response response = await http.put(uri,
          body: {'fname': '$fname', 'lname': '$lname', 'phone': '$phone'});
      if (response.statusCode == 200) {
        String data = response.body;

        var decodedData = jsonDecode(data);

        return decodedData;
      } else {
        return 'failed';
      }
    } catch (e) {
      return 'failed $e';
    }
  }

  Future getDeleteUser(String id) async {
    Map result;
    await HttpHelper()
        .getRequestDelete('http://192.168.43.186:3000/api/v1/contact/$id')
        .then((res) {
      result = res;
      return res;
    });
    return result;
  }
}
