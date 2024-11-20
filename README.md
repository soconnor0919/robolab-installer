# robolab-installer

An automated installation script for NAO6 Development Software on Ubuntu 22.04/22.10. This installer streamlines the process of setting up the development environment for NAO robotics programming at Bucknell University.

## Features

- Interactive GUI-based installation using dialog
- Modular installation options:
  - Choregraphe IDE
  - NAOqi Python SDK
  - NAOqi C++ SDK
  - NAO Flasher
  - Robot Settings
- Automatic dependency management
- System compatibility checks
- Clean uninstallation script

## Prerequisites

- Ubuntu 22.04/22.10 (x86_64)
- Internet connection
- Sudo privileges

## Installation

1. Clone the repository:
```bash
git clone https://github.com/soconnor0919/robolab-installer.git
```

2. Navigate to the installer directory:
```bash
cd robolab-installer
```

3. Make the installer executable:
```bash
chmod +x install.sh
```

4. Run the installer:
```bash
./install.sh
```

## Usage

The installer provides a graphical interface that will guide you through:

1. System compatibility checks
2. Software selection menu
3. Automated download and installation
4. Environment configuration

## Uninstallation

To remove all installed NAO software:

1. Make the uninstaller executable:
```bash
chmod +x uninstall.sh
```

2. Run the uninstaller:
```bash
./uninstall.sh
```

## Components

### Installation Scripts

- `install.sh`: Main installer script
- `uninstall.sh`: Complete uninstallation script
- `dev-setup/`: Individual component installers
  - `install-choregraphe.sh`: Choregraphe IDE installer
  - `install-pythonsdk.sh`: Python SDK installer
  - `install-cppsdk.sh`: C++ SDK installer
  - `install-flasher.sh`: NAO Flasher installer
  - `install-robotsettings.sh`: Robot Settings installer

### Features

- Automatic VS Code setup for Python and C++ development
- Environment variable configuration
- QiBuild setup for C++ development
- Zlib compatibility patches
- Desktop shortcut creation

## Troubleshooting

If you encounter issues:

1. Check system architecture compatibility
2. Ensure you're running Ubuntu 22.04/22.10
3. Verify internet connectivity
4. Check available disk space
5. Run the uninstaller and try again

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

Software installer by Sean O'Connor at Bucknell University, 2023

## Contact

Sean O'Connor
- Institution: Bucknell University
- Project: CSCI 278 Independent Study, Spring 2023

## Acknowledgments

This installer builds upon the work of:
- Ryan Mosenkis, '22
- Cole Hausman, '23
- The Aldebaran Developers

Special thanks to Professor Perrone for guidance and support throughout this project.