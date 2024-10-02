import 'dart:io';
import 'dart:convert';

User? u1;

void main() {
  outMenu();
}

class User {
  late String name;
  late String username;
  late String password;
  num balance = 0;
  List<String> transactions = []; // New field for transaction history

  User({
    required this.name,
    required this.username,
    required this.password,
    required this.balance,
    this.transactions = const [], // Default to empty list if not provided
  });

  // Save user to JSON, including transactions
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'password': password,
      'balance': balance,
      'transactions': transactions, // Include transaction history
    };
  }

  // Create a User object from a map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      username: json['username'],
      password: json['password'],
      balance: (json['balance'] as num).toDouble(),
      transactions: List<String>.from(json['transactions'] ?? []), // Ensure transactions are loaded
    );
  }
}



// Function to register a new user and save to a file
User? registerUser(String name, String username, String password, num balance) {
  // Basic validation
  if (name.isEmpty || username.isEmpty || password.isEmpty || balance < 0) {
    print('Invalid input. Registration failed.');
    return null;
  }

  // File path (users.json)
  File file = File('users.json');

  // If the file already exists, append the user data
  if (file.existsSync()) {
    // Read existing data
    List<dynamic> existingUsers = jsonDecode(file.readAsStringSync());

    // Check if the username is already registered
    for (var data in existingUsers) {
      User user = User.fromJson(data);
      if (user.username == username) {
        print('Username already registered.');
        return null;
      }
    }

    // Create a new user object
    User newUser = User(
      name: name,
      username: username,
      password: password,
      balance: balance,
    );

    // Add the new user to the existing list
    existingUsers.add(newUser.toJson());

    // Write the updated data back to the file
    file.writeAsStringSync(jsonEncode(existingUsers));

    print('User registered successfully.');
    return newUser;
  } else {
    // Create a new list with the new user and write to the file
    User newUser = User(
      name: name,
      username: username,
      password: password,
      balance: balance,
    );
    List<Map<String, dynamic>> users = [newUser.toJson()];
    file.writeAsStringSync(jsonEncode(users));

    print('User registered successfully.');
    return newUser;
  }
}

// Function to log in a user by checking the username and password
User? loginUser(String username, String password) {
  // File path (users.json)
  File file = File('users.json');

  // Check if the file exists
  if (!file.existsSync()) {
    print('No users registered yet.');
    return null;
  }

  // Read the JSON data from the file
  String jsonString = file.readAsStringSync();

  // Decode the JSON data to a list of dynamic objects
  List<dynamic> userData = jsonDecode(jsonString);

  // Convert the list of dynamic objects to a list of User objects
  List<User> users = userData.map((data) => User.fromJson(data)).toList();

  // Search for the user with the matching username and password
  for (User user in users) {
    if (user.username == username && user.password == password) {
      return user; // Return the matched user object
    }
  }
  return null; // Return null if no match is found
}

void outMenu() {
  print("\t\t\t\t\tWelcome to Simple Bank!");
  print("[1] Register an Account\n[2] Log In to your account\n[3] Exit");

  stdout.write('Enter your choice (put only the number eg. 1): ');

  String? choice = stdin.readLineSync();

  switch (choice) {
    case '1':
      registerMenu();
      break;

    case '2':
      loginMenu();
      break;

    case '3':
      exit(0);

    default:
      print("Enter only from 1 to 3");
      print("...Loading");
      sleep(Duration(seconds: 2));
      print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
      outMenu();
  }
}



bool isAlpha(String input) {
  for (int i = 0; i < input.length; i++) {
    if (!((input.codeUnitAt(i) >= 65 && input.codeUnitAt(i) <= 90) || // A-Z
          (input.codeUnitAt(i) >= 97 && input.codeUnitAt(i) <= 122))) { // a-z
      return false;
    }
  }
  return true;
}

bool isNumeric(String input) {
  for (int i = 0; i < input.length; i++) {
    if (input.codeUnitAt(i) < 48 || input.codeUnitAt(i) > 57) { // ASCII code for '0' is 48, '9' is 57
      return false;
    }
  }
  return true;
}


void registerMenu() {
  print("\x1B[2J\x1B[0;0H");
  print("\t\t\t\t\tWelcome to Simple Bank!\n\n\tRegister: ");
  print("(Enter your credentials)");
  stdout.write("Name: ");
  String? name = stdin.readLineSync()!;
  if(!isAlpha(name)){
    print("\n\nEnter only characters");
    print("...Loading");
    sleep(Duration(seconds: 2));
    print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
    registerMenu();
  }

  stdout.write("Username: ");
  String? userName = stdin.readLineSync()!;

  if(userExist(userName)){
    print("\n\nUsername already exists, try putting another username)");
    print("...Loading");
    sleep(Duration(seconds: 2));
    print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
    registerMenu();
  }

  stdout.write("Password: ");
  String? password = stdin.readLineSync()!;

  stdout.write("Initial Balance: ");
  String? inbalance = stdin.readLineSync()!;
  num balance = 0;
  if(isNumeric(inbalance)){
    balance = num.parse(inbalance);
  }
  else{
    print("\n\nEnter proper balance (only numbers from 0 and above)");
    print("...Loading");
    sleep(Duration(seconds: 2));
    print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
    registerMenu();
  }

  User? registeredUser = registerUser(name, userName, password, balance);
  print("\x1B[2J\x1B[0;0H");
  print("Account successfully registered!");

  print("What do you want to do:\n\n[1] Register Another Account\n[2] Log In to your account\n[3] Exit Program");

  stdout.write('Enter your choice (put only the number eg. 1): ');

  String? choice = stdin.readLineSync();

  switch (choice) {
    case '1':
      registerMenu();
      break;

    case '2':
      loginMenu();
      break;

    case '3':
      exit(0);

    default:
      print("Enter only from 1 to 3");
      print("...Loading");
      sleep(Duration(seconds: 2));
      print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
      outMenu();
    
  }
}

void loginMenu() {
  print("\x1B[2J\x1B[0;0H");
  print("\t\t\t\t\tWelcome to Simple Bank!\n\n\tLog In: ");

  stdout.write("Username: ");
  String? username = stdin.readLineSync()!;
  stdout.write("Password: ");
  String? password = stdin.readLineSync()!;

  u1 = loginUser(username, password);

  if (u1 != null) {
    print("Logged in successfully!");
    print("...Loading");
    sleep(Duration(seconds: 2));
    print("\x1B[2J\x1B[0;0H");
    userMenu();
  } 
  else if(userExist(username) == false){
    print("User does not exist, try again!");
    print("...Loading");
    sleep(Duration(seconds: 2));
    print("\x1B[2J\x1B[0;0H");
    loginMenu();
  }
  else {
    print('Login failed. Invalid username or password.');
    print("...Loading");
    sleep(Duration(seconds: 2));
    print("\x1B[2J\x1B[0;0H");
    loginMenu();
  }
}

void userMenu() {
  print("\x1B[2J\x1B[0;0H");
  print("\t\t\t\t\tWelcome ${u1?.name}!\n\n");

  print("Username: ${u1?.username}");
  print("Name: ${u1?.name}");

  print("[1] Check Balance\n[2] Deposit Money\n[3] Withdraw Money\n[4] Transaction History\n[5] Log Out\n[6] Exit");

  stdout.write('Enter your choice (put only the number eg. 1): ');

  String? choice = stdin.readLineSync();

  switch (choice) {
    case '1':
      checkBalance();
      break;

    case '2':
      deposit();
      break;

    case '3':
      withdraw();
      break;

    case '4':
      transactionHistory();
      break;

    case '5':
      outMenu();
      break;

    case '6':
      exit(0);

    default:
      print("Enter only from 1 to 6");
      print("...Loading");
      sleep(Duration(seconds: 2));
      print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
      userMenu();
  }
}

// User Options
void checkBalance() {
  print("\x1B[2J\x1B[0;0H");
  print("\t\t\t\t\tCheck Balance\n\n");

  print("Username: ${u1?.username}");
  print("Balance: ${u1?.balance}");

  print("\n\n[1] Back to User Menu\n[2] Exit");
  stdout.write('Enter your choice (put only the number eg. 1): ');

  String? choice = stdin.readLineSync();

  switch (choice) {
    case '1':
      userMenu();
      break;

    case '2':
      exit(0);

    default:
      print("Enter only from 1 to 2");
      print("...Loading");
      sleep(Duration(seconds: 2));
      print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
      userMenu();
  }
}

void deposit() {
  print("\x1B[2J\x1B[0;0H");
  print("\t\t\t\t\tDeposit Money\n\n");

  print("Username: ${u1?.username}");

  stdout.write("Enter the amount to deposit: ");
  String? amountInput = stdin.readLineSync()!;
  num amount = 0;
  if (isNumeric(amountInput)) {
    amount = num.parse(amountInput);
  } else {
    print("\n\nEnter proper amount (only numbers from 0 and above)");
    print("...Loading");
    sleep(Duration(seconds: 2));
    print("\x1B[2J\x1B[0;0H");
    deposit();
  }

  u1!.balance += amount;
  u1!.transactions.add("Deposited: $amount"); // Log transaction
  updateUserData(u1!); // Save user data, including the transaction

  print("Deposit successful!");

  print("\n\n[1] Back to User Menu\n[2] Exit");
  stdout.write('Enter your choice (put only the number eg. 1): ');
  String? choice = stdin.readLineSync();
  switch (choice) {
    case '1':
      userMenu();
      break;
    case '2':
      exit(0);
    default:
      print("Enter only from 1 to 2");
      print("...Loading");
      sleep(Duration(seconds: 2));
      print("\x1B[2J\x1B[0;0H");
      userMenu();
  }
}

void withdraw() {
  print("\x1B[2J\x1B[0;0H");
  print("\t\t\t\t\tWithdraw Money\n\n");

  print("Username: ${u1?.username}");

  stdout.write("Enter the amount to withdraw: ");
  String? amountInput = stdin.readLineSync()!;
  num amount = 0;
  if (isNumeric(amountInput)) {
    amount = num.parse(amountInput);
  } else {
    print("\n\nEnter proper amount (only numbers from 0 and above)");
    print("...Loading");
    sleep(Duration(seconds: 2));
    print("\x1B[2J\x1B[0;0H");
    withdraw();
  }

  if (amount > u1!.balance) {
    print("Insufficient balance. Current balance: ${u1!.balance}");
  } else {
    u1!.balance -= amount;
    u1!.transactions.add("Withdrew: $amount"); // Log transaction
    updateUserData(u1!); // Save user data, including the transaction
    print("Withdrawal successful!");
  }

  print("\n\n[1] Back to User Menu\n[2] Exit");
  stdout.write('Enter your choice (put only the number eg. 1): ');
  String? choice = stdin.readLineSync();
  switch (choice) {
    case '1':
      userMenu();
      break;
    case '2':
      exit(0);
    default:
      print("Enter only from 1 to 2");
      print("...Loading");
      sleep(Duration(seconds: 2));
      print("\x1B[2J\x1B[0;0H");
      userMenu();
  }
}


void updateUserData(User user) {
  File file = File('users.json');

  if (file.existsSync()) {
    List<dynamic> existingUsers = jsonDecode(file.readAsStringSync());

    for (int i = 0; i < existingUsers.length; i++) {
      if (existingUsers[i]['username'] == user.username) {
        existingUsers[i] = user.toJson(); // Update the user's data, including transactions
        break;
      }
    }

    file.writeAsStringSync(jsonEncode(existingUsers));
  }
}


bool userExist(String username) {
  File file = File('users.json');

  if (file.existsSync()) {
    // Read existing data
    List<dynamic> existingUsers = jsonDecode(file.readAsStringSync());

    // Find the user and update the balance
    for (int i = 0; i < existingUsers.length; i++) {
      if (existingUsers[i]['username'] == username) {
        return true;
      }
    }
    return false;
  }
  return false;
}


void transactionHistory() {
  print("\x1B[2J\x1B[0;0H");
  print("\t\t\t\t\tTransaction History\n\n");

  if (u1!.transactions.isEmpty) {
    print("No transactions available.");
  } else {
    for (var transaction in u1!.transactions) {
      print(transaction); // Print each transaction
    }
  }

  print("\n\n[1] Back to User Menu\n[2] Exit");
  stdout.write('Enter your choice (put only the number eg. 1): ');

  String? choice = stdin.readLineSync();
  switch (choice) {
    case '1':
      userMenu();
      break;
    case '2':
      exit(0);
    default:
      print("Enter only from 1 to 2");
      print("...Loading");
      sleep(Duration(seconds: 2));
      print("\x1B[2J\x1B[0;0H");
      userMenu();
  }
}
