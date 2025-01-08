# Docker-Colima

This script provides a simple interface for managing Colima, a lightweight virtual machine for macOS. It offers the following commands:

- **`install`:** Installs the necessary dependencies:

  - Docker
  - Colima

- **`start`:** Starts the Colima VM.

  - Supports two modes:
    - **QEMU:** (default) Starts Colima in QEMU mode.
    - **VZ (with Rosetta):** Starts Colima in VZ mode with Rosetta translation enabled for improved performance with Apple Silicon.
    - You can specify the VZ mode by passing the `--vz-rosetta` flag to the `start` command.

- **`stop`:** Stops the running Colima VM.

## Usage

1. **Install Dependencies:**

   ```bash
   ./run.sh install
   ```

2. **Start Colima:**

   ```bash
   ./run.sh start
   ```

   or

   ```bash
   ./run.sh start --vz-rosetta
   ```

3. **Stop Colima:**
   ```bash
   ./run.sh stop
   ```

## Note

- This script requires `brew` (Homebrew) to be installed on your macOS system.
- The default configuration uses 4 CPUs and 8GB of memory for the Colima VM. You can adjust these values by modifying the `colima start` commands within the script.

This script simplifies the process of managing your Colima VM, providing a convenient way to start and stop the VM and switch between QEMU and VZ modes as needed.
