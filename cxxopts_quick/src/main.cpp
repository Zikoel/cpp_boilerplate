#include <cxxopts.hpp>

int main(int argc, char** argv) {

    cxxopts::Options options("App name here", "Description here");
    options.add_options()
            ("o,option1", "description here", cxxopts::value<std::string>())
            ("option2", "description here", cxxopts::value<std::string>()->default_value("value"))
            ("h,help", "Show this help");

    auto result = options.parse(argc, argv);
    if ( result.count("help") != 0 || argc < 2 ) {
        std::cout << options.help() << std::endl;
        return 0;
    }

    std::string option1 = result["option1"].as<std::string>();
    std::string option2 = result["option2"].as<std::string>();

    std::cout << "Option1" << option1 << std::endl;
    std::cout << "Option2" << option1 << std::endl;

    return 0;
}
