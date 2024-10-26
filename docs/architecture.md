Here’s a comprehensive `architecture.md` that provides a detailed architecture overview for your `MicrokernelOS` project:

---

# MicrokernelOS Architecture

## Overview
The `MicrokernelOS` project is an operating system built around a microkernel architecture, emphasizing simplicity, modularity, and robustness. The core responsibilities of the OS are handled by a minimal kernel, while most system services are implemented as user-space components, enhancing stability and maintainability.

This document provides an in-depth description of the architecture, including the main components, system interactions, and structural design.

## Key Components

### 1. **Kernel**
   The core of `MicrokernelOS`, responsible for essential services such as low-level hardware management, process scheduling, inter-process communication (IPC), and memory management. The kernel is minimalistic and focuses on the following components:

   - **Bootloader** (`boot/`): 
     - **boot.asm**: Assembly code responsible for loading the OS from the disk into memory.
     - **loader.c**: If applicable, a C implementation for loading the kernel and initializing essential components.
   - **Kernel Core** (`kernel/`):
     - **arch/x86.c**: Contains architecture-specific code for x86 platforms.
     - **drivers/**: Hardware drivers including timers and keyboards.
     - **interrupts/**: Handles interrupt processing, including IDT (Interrupt Descriptor Table) and ISR (Interrupt Service Routines).
     - **ipc/**: Implementation of IPC mechanisms using message queues and shared memory.
     - **memory/**: Paging and dynamic memory allocation.
     - **process/**: Process management, scheduling, and context switching.
     - **syscall/**: System call interface for interacting with user-space programs.
     - **utils/**: Utility functions like `printf` and string manipulation.

### 2. **Shell**
   - Provides a command-line interface to the user.
   - Allows users to execute built-in commands and interact with the file system and kernel.

### 3. **File System** (`fs/`)
   - Manages files, directories, and related operations.
   - Implements a simple file system structure, with support for the FAT file system via the `fat_driver.c`.

### 4. **Networking** (`net/`)
   - A basic TCP/IP stack to enable networking capabilities.
   - Handles low-level networking tasks and offers fundamental communication services to user-space applications.

### 5. **User Space Programs** (`user/`)
   - Sample user applications, demonstrating how processes interact with the kernel using system calls.
   - Includes examples like `hello.c` and a simple calculator program.

### 6. **Test Suite** (`tests/`)
   - Contains unit tests for different components such as kernel processes, memory, IPC, file systems, and networking.
   - Ensures each module functions correctly in isolation and as part of the OS.

## Kernel Design

### 1. **Microkernel Philosophy**
The `MicrokernelOS` is built on a microkernel design philosophy:
   - **Minimal Kernel**: Contains only essential components like scheduling, IPC, and memory management.
   - **User-Space Services**: Most traditional kernel functionalities (drivers, file systems, networking) are implemented in user-space.

### 2. **Boot Process**
   - The **bootloader** initializes the system, sets up the memory, and loads the kernel into memory.
   - The kernel takes over and initializes its components (memory manager, scheduler, IPC) and starts user-space services.

### 3. **Interrupt Handling**
   - The kernel sets up an **Interrupt Descriptor Table (IDT)** and installs handlers for hardware interrupts and exceptions.
   - **Interrupt Service Routines (ISRs)** manage interrupts, enabling preemptive multitasking and system responses to hardware events.

### 4. **Memory Management**
   - Paging is implemented to manage memory efficiently.
   - A custom memory allocator handles dynamic memory requests from kernel and user-space programs.

### 5. **Process Management**
   - The kernel manages processes using a **scheduler**, implementing basic round-robin or priority-based scheduling.
   - Process control includes creating, terminating, and switching contexts between processes.

### 6. **Inter-Process Communication (IPC)**
   - The kernel provides IPC mechanisms, allowing safe data exchange between processes:
     - **Message Queues**: Structured communication channels.
     - **Shared Memory**: Directly accessible memory regions for faster data sharing.

### 7. **System Calls**
   - The kernel exposes a **system call interface** for user programs to interact with the kernel.
   - The system call handler processes requests, offering services like file operations, memory allocation, and process management.

## Directory Structure

### 1. **Source Code (src/)**
   - **boot/**: Code related to system booting and initialization.
   - **kernel/**: Core kernel source files, handling processes, memory, and hardware interaction.
   - **shell/**: Command-line interface code.
   - **fs/**: File system code, supporting file operations and FAT file system management.
   - **user/**: Sample user-space applications.
   - **net/**: Networking stack, enabling basic network communication.

### 2. **Header Files (include/)**
   - Contains all the headers required for kernel, shell, file system, and networking modules.
   - Facilitates modularity and code reusability.

### 3. **Build System (build/, Makefile)**
   - Contains scripts to compile and link the kernel, resulting in a final bootable image (`kernel.img`).
   - **Makefile**: Automates the compilation process, managing dependencies.

### 4. **Documentation (docs/)**
   - **architecture.md**: This document—detailed architectural overview.
   - **user_guide.md**: User manual, covering how to operate the OS.
   - **design_doc.md**: Design specifications, constraints, and decisions.
   - **api_reference.md**: Reference for developers, outlining the API available for user-space programs.

### 5. **Scripts (scripts/)**
   - **build.sh**: Compiles the OS kernel and user-space programs.
   - **clean.sh**: Cleans up build artifacts.
   - **run.sh**: Launches the OS in a QEMU virtual machine for testing.

### 6. **Tests (tests/)**
   - Automated tests for verifying the correctness of different OS components.
   - Includes tests for kernel, file system, shell, and networking.

### 7. **Tools (tools/)**
   - Contains debugging tools and GDB initialization files for kernel debugging.

## Interaction Flow

### 1. **System Boot**
   - The bootloader is loaded by the BIOS.
   - The kernel initializes its core components, including memory, interrupt handlers, and scheduler.
   - User-space services (e.g., shell, file system) are started by the kernel.

### 2. **User Commands**
   - The user inputs commands via the shell.
   - Commands are parsed and either handled directly by the shell or delegated to the kernel through system calls.

### 3. **File Access**
   - User-space programs request file operations through system calls.
   - The file system module handles these requests, utilizing FAT drivers if necessary.

### 4. **Process Management**
   - New processes can be created by user commands or user-space programs.
   - The kernel's scheduler allocates CPU time to processes and handles context switching.

### 5. **Networking**
   - User-space networking programs communicate with the network stack via system calls.
   - The kernel processes these requests and manages network interactions.

## Future Enhancements
   - Advanced memory management (e.g., segmentation).
   - Support for additional file systems.
   - Improved networking capabilities with UDP and DNS support.
   - Enhanced shell with scripting capabilities.
   - Better security through user permissions and access control.

---

This document offers a detailed architectural overview of `MicrokernelOS`, ensuring clarity for developers and contributors. Further details and updates can be added as the project evolves.
