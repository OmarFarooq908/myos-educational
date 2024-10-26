Here's a comprehensive `design_doc.md` for your Microkernel OS project. This document focuses on the design and architectural decisions for the system, emphasizing modularity, scalability, and performance.

---

# MicrokernelOS Design Document

## Table of Contents
1. [Introduction](#introduction)
2. [Objectives](#objectives)
3. [System Overview](#system-overview)
4. [Key Components](#key-components)
    - [Bootloader](#bootloader)
    - [Microkernel](#microkernel)
    - [Inter-process Communication (IPC)](#inter-process-communication-ipc)
    - [Memory Management](#memory-management)
    - [Process Management](#process-management)
    - [System Calls](#system-calls)
    - [Device Drivers](#device-drivers)
    - [File System](#file-system)
    - [Networking](#networking)
    - [Shell](#shell)
5. [Detailed Design](#detailed-design)
6. [Build System](#build-system)
7. [Testing Strategy](#testing-strategy)
8. [Future Enhancements](#future-enhancements)

## Introduction

The **MicrokernelOS** project aims to develop a lightweight, modular operating system using a microkernel architecture. The primary focus is on keeping the kernel minimalistic, implementing only the core functionalities, while moving other services (like file systems, networking, and drivers) to user space.

This document outlines the design and architecture of the system, highlighting each component and its purpose.

## Objectives

The key objectives of the MicrokernelOS are:
- **Modularity**: Each component should be independent and replaceable.
- **Security**: A smaller kernel footprint reduces the potential attack surface.
- **Scalability**: The OS should be adaptable for different hardware and use cases.
- **Reliability**: Provide a stable and predictable system behavior with efficient resource management.

## System Overview

The MicrokernelOS is structured as follows:

- **Kernel Layer**: Responsible for core functionalities such as process management, memory management, IPC, and handling system calls.
- **User Space**: Contains all other services including device drivers, file systems, networking, and user applications.
- **Shell**: A command-line interface to interact with the system, execute commands, and manage processes.

The system’s modular nature allows for easier updates, testing, and debugging.

## Key Components

### Bootloader

- **Location**: `src/boot/`
- **Files**: `boot.asm`, `loader.c`
- **Description**: The bootloader initializes the hardware, sets up the environment, and loads the kernel into memory. It’s a minimal assembly and C-based loader focusing on getting the kernel up and running.

### Microkernel

- **Location**: `src/kernel/`
- **Files**: `kernel.c`, `arch/x86.c`
- **Description**: The microkernel is the core of the OS, responsible for:
  - **Process scheduling**.
  - **Memory management**.
  - **IPC mechanisms**.
  - **Basic interrupt handling**.

### Inter-process Communication (IPC)

- **Location**: `src/kernel/ipc/`
- **Files**: `message_queue.c`, `shared_mem.c`
- **Description**: The IPC mechanisms provide message queues and shared memory for communication between processes, adhering to the microkernel philosophy of isolating services in user space.

### Memory Management

- **Location**: `src/kernel/memory/`
- **Files**: `paging.c`, `memory_alloc.c`
- **Description**: This module manages virtual memory, implements paging, and handles dynamic memory allocation. The system relies on paging for memory protection and efficient address translation.

### Process Management

- **Location**: `src/kernel/process/`
- **Files**: `scheduler.c`, `process.c`
- **Description**: Handles process creation, deletion, and context switching. Implements a round-robin scheduler for time-sharing among processes.

### System Calls

- **Location**: `src/kernel/syscall/`
- **Files**: `syscall.c`, `syscall_table.c`
- **Description**: Provides a controlled interface between user space and the kernel. System calls include file operations, process control, memory management, and device I/O.

### Device Drivers

- **Location**: `src/kernel/drivers/`
- **Files**: `timer.c`, `keyboard.c`
- **Description**: Device drivers are implemented in user space but interfaced through the kernel using system calls. This abstraction ensures that device management is modular and can be updated independently.

### File System

- **Location**: `src/fs/`
- **Files**: `fs.c`, `drivers/fat_driver.c`
- **Description**: Implements a simple file system interface. The FAT driver supports basic file operations, including read, write, and delete.

### Networking

- **Location**: `src/net/`
- **Files**: `net.c`, `tcp.c`
- **Description**: A basic network stack supporting TCP/IP protocols. This component is designed to handle network communication in user space while interacting with hardware through drivers.

### Shell

- **Location**: `src/shell/`
- **Files**: `shell.c`, `commands.c`, `parser.c`
- **Description**: The shell is a command-line interface for interacting with the OS. It supports basic built-in commands and handles user input.

## Detailed Design

### 1. **Memory Layout**
   - Kernel space and user space are separated to ensure protection.
   - Paging is used for memory management.
   - A dynamic memory allocator is implemented using a simple first-fit algorithm.

### 2. **Process Scheduling**
   - The scheduler uses a round-robin algorithm.
   - Each process has a priority level and is assigned a time slice.
   - Context switching is achieved by saving and restoring registers.

### 3. **Interrupt Handling**
   - Interrupts are managed using the Interrupt Descriptor Table (IDT).
   - Critical interrupts (e.g., keyboard input) are handled in the kernel.

### 4. **System Call Interface**
   - A simple system call interface provides access to kernel functionalities.
   - The syscall table maps system call numbers to their corresponding handler functions.

## Build System

- **Makefile**: Automates the build process, compiling source files and linking them into the final kernel image.
- **Scripts**:
  - `build.sh`: Builds the entire OS.
  - `clean.sh`: Cleans up build artifacts.
  - `run.sh`: Launches the OS in QEMU for testing.

## Testing Strategy

- **Unit Testing**: Tests individual modules (e.g., memory management, IPC) in isolation (`tests/`).
- **Integration Testing**: Ensures that components work together correctly.
- **User Acceptance Testing**: Validates the OS's functionality from a user’s perspective using the shell.

## Future Enhancements

1. **Advanced File System**: Implement support for more advanced file systems like ext2/3.
2. **Networking**: Expand the network stack to support more protocols (e.g., UDP, HTTP).
3. **Graphical User Interface (GUI)**: Develop a simple GUI for user interaction.
4. **Virtualization**: Introduce support for virtualization for running virtual machines.
5. **Security Enhancements**: Implement user authentication and permission-based access control.

---

This design document aims to serve as a guide for developers working on MicrokernelOS, providing clarity on architectural decisions and a roadmap for future enhancements.
