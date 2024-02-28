void FileCheck() {
    string modWorkPath = IO::FromUserGameFolder("Skins/Stadium/ModWork/");

    if (!IO::FolderExists(modWorkPath)) {
        IO::CreateFolder(modWorkPath);
    }
    if (!IO::FolderExists(modWorkPath + "CarFixImage")) {
        IO::CreateFolder(modWorkPath + "CarFixImage");
    }

}