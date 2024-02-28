string[] asphaltTextures;
string[] dirtTextures;
string[] grassTextures;

int currentTextureIndex = 0;
const int updateFrameInterval = 2;
int frameCounter = 0;

string defaultSkidTexture = "src/Textures/default_skid.dds";

void Main() {
    FileCheck();

    ApplySkidTexture(defaultSkidTexture, "Default");

    LoadTextures(asphaltTextures, "asphalt");
    LoadTextures(dirtTextures, "dirt");
    LoadTextures(grassTextures, "grass");
}


void LoadTextures(string[]& textureArray, const string &in surfaceType) {
    for (int i = 1; i <= 200; ++i) {
        textureArray.InsertLast("src/Textures/" + surfaceType + "/" + surfaceType + "_skid_" + i + ".dds");
    }
}

void Render() {
    frameCounter++;
    if (frameCounter >= updateFrameInterval) {
        frameCounter = 0;
        UpdateSkidTextures();
    }
}

void UpdateSkidTextures() {
    currentTextureIndex = (currentTextureIndex + 1) % asphaltTextures.Length;

    ApplySkidTexture(asphaltTextures[currentTextureIndex], "Asphalt");
    ApplySkidTexture(dirtTextures[currentTextureIndex], "Dirt");
    ApplySkidTexture(grassTextures[currentTextureIndex], "Grass");
}

void ApplySkidTexture(const string &in texturePath, const string &in surfaceType) {
    string modWorkPath = IO::FromUserGameFolder("Skins/Stadium/ModWork/");
    string targetPath;

    if (surfaceType == "Asphalt") {
        targetPath = modWorkPath + "CarFxImage/CarAsphaltMarks.dds";
    } else if (surfaceType == "Dirt") {
        targetPath = modWorkPath + "DirtMarks.dds";
    } else if (surfaceType == "Grass") {
        targetPath = modWorkPath + "CarFxImage/CarGrassMarks.dds";
    }

    CopyAndRenameTextureFile(texturePath, targetPath);
}

void CopyAndRenameTextureFile(const string &in sourcePath, const string &in targetPath) {
    IO::File sourceFile(sourcePath, IO::FileMode::Read);

    string fileContent;
    sourceFile.Read(fileContent, sourceFile.Size());

    IO::File targetFile(targetPath, IO::FileMode::Write);

    targetFile.Open();
    targetFile.Write(fileContent);
    targetFile.Close();
    // log("Texture file copied successfully.", LogLevel::Info, 23);

    sourceFile.Close();
}