import 'dart:io';

late personAccount p1;

void main() {
  outMenu();
}

class personAccount{
    late String pname;
    late String pusername;
    late String ppassword;
    double pbalance = 0;

  personAccount(String pname, String pusername, String ppassword, double pbalance){
    this.pname = pname;
    this.pusername = pusername;
    this.ppassword = ppassword;
    this.pbalance = pbalance;
  }
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
      p1 = new personAccount(name, userName, password, balance);
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

  if(username == p1.pusername && password == p1.ppassword){
    print("Logged in succesfully!");
    print("...Loading");
    sleep(Duration(seconds:2));
    print("\x1B[2J\x1B[0;0H");
    // userMenu();
  }
  else{
    print("Double check your password and username");
    print("...Loading");
    sleep(Duration(seconds:2));
    print("\x1B[2J\x1B[0;0H");
    registerMenu();
  }
}


