ini_open("saveData.ini");
ini_write_string("Option", "language", (options[3].data.index == 0) ? "esp" : "eng");
var fullscreen = options[0].data.toggle;
ini_write_real("Option", "fullscreen", fullscreen);
var resolution = options[2].data.index;
ini_write_real("Option", "resolution", resolution);
ini_close();
load_options();
