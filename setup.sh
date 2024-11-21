#!/bin/bash

# Function to install RISC-V toolchain with specified options
install_riscv() {
    echo "Starting RISC-V toolchain installation..."
    
    # Clone the repository
    git clone https://github.com/riscv/riscv-gnu-toolchain
    if [ $? -ne 0 ]; then
        echo "Failed to clone the repository. Please check your internet connection or repository URL."
        return 1
    fi
    
    # Change to the cloned directory
    cd riscv-gnu-toolchain || exit

    # Configure the build
    ./configure --prefix=/opt/riscv --with-arch=rv32gc --with-abi=ilp32d
    ./configure --prefix=/opt/riscv
    if [ $? -ne 0 ]; then
        echo "Configuration failed. Please check the error messages."
        return 1
    fi
    
    # Build the toolchain
    make linux
    if [ $? -ne 0 ]; then
        echo "Build failed. Please check the error messages."
        return 1
    fi

    echo "Build completed successfully!"
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
    echo "1. Install RISC-V Toolchain"
    echo "2. Install Another Package"
    echo "3. Exit"
    read -p "Enter your choice [1-3]: " choice

    case $choice in
        1)
            install_riscv
            ;;
        2)
            install_other_package
            ;;
        3)
            exit_script
            ;;
        *)
            echo "Invalid choice. Please enter 1, 2, or 3."
            ;;
    esac
done
