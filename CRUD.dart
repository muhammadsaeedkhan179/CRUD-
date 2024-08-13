import 'dart:io';

void main() async {
  final File file = File('Confidential.txt');
  List<String> list = await readFile(file);
  bool running = true;

  while (running) {
    print("Which CRUD Operation do you want to perform?");
    print("Press 1: For Add Data");
    print("Press 2: For Update Data");
    print("Press 3: For Delete Data");
    print("Press 4: For Read Data");
    print("Press 5: To Exit");

    String? input = stdin.readLineSync();
    int? choice = int.tryParse(input!);

    if (choice == null) {
      print("Invalid input. Please enter a number between 1 and 5.");
      continue;
    }

    switch (choice) {
      case 1:
        print("Enter your name:");
        String? name = stdin.readLineSync();
        if (name != null) {
          list.add(name);
        }

        print("Enter your ID:");
        String? id = stdin.readLineSync();
        if (id != null) {
          list.add(id);
        }

        print("Data added successfully!");
        await writeFile(file, list);
        break;

      case 2:
        if (list.isEmpty) {
          print("List is empty. No data to update.");
        } else {
          print("Enter index to update:");
          String? indexInput = stdin.readLineSync();
          int? indexToUpdate = int.tryParse(indexInput!);

          if (indexToUpdate != null && indexToUpdate >= 0 && indexToUpdate < list.length) {
            print("Enter new value:");
            String? newValue = stdin.readLineSync();
            if (newValue != null) {
              list[indexToUpdate] = newValue;
              print("Data updated successfully!");
              await writeFile(file, list);
            }
          } else {
            print("Invalid index. No data updated.");
          }
        }
        break;

      case 3:
        if (list.isEmpty) {
          print("List is empty. No data to delete.");
        } else {
          print("Enter index to delete:");
          String? indexInput = stdin.readLineSync();
          int? indexToDelete = int.tryParse(indexInput!);

          if (indexToDelete != null && indexToDelete >= 0 && indexToDelete < list.length) {
            list.removeAt(indexToDelete);
            print("Data deleted successfully!");
            await writeFile(file, list);
          } else {
            print("Invalid index. No data deleted.");
          }
        }
        break;

      case 4:
        if (list.isEmpty) {
          print("List is empty.");
        } else {
          print("Data in the list:");
          for (var item in list) {
            print(item);
          }
        }
        break;

      case 5:
        running = false;
        print("Exiting the program. Goodbye!");
        break;

      default:
        print("Invalid input. Please enter a number between 1 and 5.");
        break;
    }
  }
}

Future<List<String>> readFile(File file) async {
  try {
    if (await file.exists()) {
      return await file.readAsLines();
    } else {
      return [];
    }
  } catch (e) {
    print("Error reading file: $e");
    return [];
  }
}

Future<void> writeFile(File file, List<String> list) async {
  try {
    await file.writeAsString(list.join('\n'));
  } catch (e) {
    print("Error writing to file: $e");
  }
}
