#!/bin/bash

# Function to install the required dependencies for RISC-V toolchain
install_dependencies() {
    echo "Installing required dependencies for RISC-V toolchain..."

    # Update package list
    sudo apt-get update

    # Install build-essential, gawk, texinfo, bison, flex, zlib, and GMP/MPFR
    sudo apt-get install -y build-essential gawk texinfo bison flex zlib1g-dev libgmp-dev libmpfr-dev

    if [ $? -eq 0 ]; then
        echo "Dependencies installed successfully!"
    else
        echo "Failed to install dependencies. Please check your internet connection or package manager."
        return 1
    fi
}

# Function to install RISC-V toolchain with specified options
install_riscv() {
    echo "Starting RISC-V toolchain installation..."

    # Prompt the user to set an installation path
    read -p "Enter the installation directory for RISC-V toolchain (e.g., /opt/riscv) or leave EMPTY for default option: " install_dir
    if [ -z "$install_dir" ]; then
        install_dir="/opt/riscv" # Default path if the user leaves it empty
    fi
    
    echo "Using installation directory: $install_dir"

    # Clone the repository
    git clone https://github.com/riscv/riscv-gnu-toolchain
    if [ $? -ne 0 ]; then
        echo "Failed to clone the repository. Please check your internet connection or repository URL."
        return 1
    fi
    
    # Change to the cloned directory
    cd riscv-gnu-toolchain || exit

    # Use sudo for the installation step
    sudo ./configure --prefix=$install_dir --with-arch=rv32gc --with-abi=ilp32d
    if [ $? -ne 0 ]; then
        echo "Configuration failed. Please check the error messages."
        return 1
    fi
    
    # Build the toolchain with sudo
    sudo make linux
    if [ $? -ne 0 ]; then
        echo "Build failed. Please check the error messages."
        return 1
    fi

    echo "Build completed successfully!"

    # Immediately add the installation directory to PATH for the current session
    export PATH=$PATH:$install_dir/bin
    echo "RISC-V toolchain installed and PATH updated. You can now use the toolchain."
}

install_caravel_project() {
    echo "Starting clone the project..."
    git clone https://github.com/efabless/caravel_board.git
}

# Function to install some other package
install_other_package() {
    echo "Installing another package..."
    # Add your installation commands here
    echo "Installation complete!"
}

# Function to exit the script
exit_script() {
    echo "Exiting the script. Goodbye!"
    exit 0
}

# Display menu and handle user input
while true; do
    echo "Choose an option:"
    echo "1. Install Dependencies for RISC-V Toolchain"
    echo "2. Install RISC-V Toolchain"
    echo "3. Clone the project for testing"
    echo "4. Install other package"
    echo "5. Exit"
    read -p "Enter your choice [1-5]: " choice

    case $choice in
        1)
            install_dependencies
            ;;
        2)
            install_riscv
            ;;
        3)
            install_caravel_project
            ;;
        4)
            install_other_package
            ;;
        5)
            exit_script
            ;;
        *)
            echo "Invalid choice. Please choose a valid option."
            ;;
    esac
done
