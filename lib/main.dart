import 'dart:io';

late User u1;

void main() {
  outMenu();
}

class User{
    late String name;
    late String username;
    late String password;
    double balance = 0;

  User(this.name, this.username, this.password, this.balance);
}

void outMenu(){
    print("\t\t\t\t\tWelcome to Simple Bank!");
    print("[1] Register an Account\n[2] Log In to your account\n[3] Exit");

    stdout.write('Enter your choice (put only the number eg. 1): ');

    String? choice = stdin.readLineSync();
    
    switch(choice){

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
        sleep(Duration(seconds:2));
        print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
        outMenu();
  }
}

void registerMenu(){
  print("\x1B[2J\x1B[0;0H");
  print("\t\t\t\t\tWelcome to Simple Bank!\n\n\tRegister: ");
  print("(Enter your credentials)");
  stdout.write("Name: ");
  String? name = stdin.readLineSync()!;
  stdout.write("Username: ");
  String? userName = stdin.readLineSync()!;
  stdout.write("Password: ");
  String? password = stdin.readLineSync()!;
  stdout.write("Initial Balance: ");
  String? inbalance = stdin.readLineSync()!;
  double balance = double.parse(inbalance);

  int status = 0;

  if(balance < 0){
    status = 0;
  }
  else if(balance >= 0){
    status = 1;
  }


  if(status == 1){
      u1 = User(name, userName, password, balance);
      print("\x1B[2J\x1B[0;0H");
      print("Account succesfully registered!");

      print("What do you want to do:\n\n[1] Register Another Account\n[2] Log In to your account\n[3] Exit Program");

      stdout.write('Enter your choice (put only the number eg. 1): ');

      String? choice = stdin.readLineSync();
      
      switch(choice){

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
          sleep(Duration(seconds:2));
          print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
          outMenu();
    }
  }

  else{
    print("\n\nEnter proper balance (only 0 and above)");
    print("...Loading");
    sleep(Duration(seconds:2));
    print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
    registerMenu();
  }
}

void loginMenu(){
  print("\x1B[2J\x1B[0;0H");
  print("\t\t\t\t\tWelcome to Simple Bank!\n\n\tLog In: ");

  stdout.write("Username: ");
  String? username = stdin.readLineSync()!;
  stdout.write("Password: ");
  String? password = stdin.readLineSync()!;

  if(username == u1.username && password == u1.password){
    print("Logged in succesfully!");
    print("...Loading");
    sleep(Duration(seconds:2));
    print("\x1B[2J\x1B[0;0H");
    userMenu();
  }
  else{
    print("Double check your password and username");
    print("...Loading");
    sleep(Duration(seconds:2));
    print("\x1B[2J\x1B[0;0H");
    registerMenu();
  }
}




void userMenu(){

  print("\x1B[2J\x1B[0;0H");
  print("\t\t\t\t\tWelcome ${u1.name}!\n\n");

  print("Username: ${u1.username}");
  print("Name: ${u1.name}");
  
  print("[1] Check Balance\n[2] Deposit Money\n[3] Withdraw Money\n[4] Transaction History\n[5] Log Out\n[6] Exit");

    stdout.write('Enter your choice (put only the number eg. 1): ');

    String? choice = stdin.readLineSync();
    
    switch(choice){

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
        sleep(Duration(seconds:2));
        print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
        userMenu();
  }
}

// User Options
void checkBalance(){

  print("\x1B[2J\x1B[0;0H");
  print("\t\t\t\t\tCheck Balance\n\n");

  print("Username: ${u1.username}");
  print("Balance: ${u1.balance}");
  
  print("[1] Return to Menu\n[2] Deposit Money\n[3] Withdraw Money\n[4] Transaction History\n[5] Log Out\n[6] Exit");

    stdout.write('Enter your choice (put only the number eg. 1): ');

    String? choice = stdin.readLineSync();
    
    switch(choice){

      case '1':
      userMenu();
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
        print("Enter only from 1 to 3");
        print("...Loading");
        sleep(Duration(seconds:2));
        print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
        outMenu();
  }
}

void deposit(){
  print("\x1B[2J\x1B[0;0H");
  print("\t\t\t\t\tDeposit Money\n\n");

  print("Username: ${u1.username}");
  stdout.write("Enter Ammount: ");
  String? amount = stdin.readLineSync()!;
  if(double.parse(amount) < 0){
    print("Enter above 0 money");
    print("...Loading");
    sleep(Duration(seconds:2));
    print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
    deposit();
  }
  else{
    u1.balance += double.parse(amount);
  }
  print("Deposit Successful\n\n");

  
  print("[1] Check Balance\n[2] Return to Menu\n[3] Withdraw Money\n[4] Transaction History\n[5] Log Out\n[6] Exit");

    stdout.write('Enter your choice (put only the number eg. 1): ');

    String? choice = stdin.readLineSync();
    
    switch(choice){

      case '1':
      checkBalance();
        break;

      case '2':
      userMenu();
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
        print("Enter only from 1 to 3");
        print("...Loading");
        sleep(Duration(seconds:2));
        print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
        outMenu();
  }
}

void withdraw(){
  print("\x1B[2J\x1B[0;0H");
  print("\t\t\t\t\tWithdraw Money\n\n");

  print("Username: ${u1.username}");
  stdout.write("Enter amount to withdraw: ");
  String? amount = stdin.readLineSync()!;
  if(double.parse(amount) < 0){
    print("Enter above 0 amount");
    print("...Loading");
    sleep(Duration(seconds:2));
    print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
    deposit();
  }
  else{
    if(double.parse(amount) > u1.balance){
      print("Insufficient Balance, try again!");
      print("...Loading");
      sleep(Duration(seconds:2));
      print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
      withdraw();
    }
    else{
      u1.balance -= double.parse(amount);
    }
  }

  print("Withdraw Successful\n\n");

  
  print("[1] Check Balance\n[2] Return to Menu\n[3] Withdraw Money\n[4] Transaction History\n[5] Log Out\n[6] Exit");

    stdout.write('Enter your choice (put only the number eg. 1): ');

    String? choice = stdin.readLineSync();
    
    switch(choice){

      case '1':
      checkBalance();
        break;

      case '2':
      deposit();
        break;

      case '3':
      userMenu();
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
        print("Enter only from 1 to 3");
        print("...Loading");
        sleep(Duration(seconds:2));
        print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
        outMenu();
  }
}

void transactionHistory(){

}