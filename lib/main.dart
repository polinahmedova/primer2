import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:faker/faker.dart'; // Импортируем библиотеку faker

//cоздание сервиса UserService, который используется для работы с пользователями

class UserService with ChangeNotifier {
  void addUser() {
    final faker = Faker(); // создаем экземпляр faker
    final username =
        faker.person.firstName(); // генерируем случайное имя пользователя
    print('User added: $username');
    notifyListeners(); // уведомляем слушателей об изменениях
  }
}

//создание класса, который используется для взаимодействия с сервисом UserService

class UserClient {
  final UserService _userService;

  UserClient(
      this._userService); //внедрение зависимости UserService через конструктор

  void addUser() {
    _userService.addUser(); //вызов метода addUser у сервиса
  }
}

//инициализация приложения и предоставление зависимости UserService
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserService>(
      create: (_) => UserService(), // предоставляем UserService через Provider
      child: MaterialApp(
        title: 'Dependency Injection Example',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //использование клиента UserClient
    final userClient =
        UserClient(Provider.of<UserService>(context, listen: false)!);

    return Scaffold(
      appBar: AppBar(
        title: Text('Dependency Injection Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Add a User:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                userClient.addUser();
              },
              child: Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }
}
