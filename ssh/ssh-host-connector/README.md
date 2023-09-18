# SSH Connection Manager

This script is a simple SSH connection manager. It reads entries from a file, `entries.txt`, where each entry represents a server to which you can connect using SSH. The script presents these entries in a formatted table, asks you to choose an entry by its index, then initiates an SSH connection to the chosen server.

## How to Use

1. **Prepare the SSH List file**: Create a text file named `ssh_list.txt` in the same directory as the script. Each line in this file should represent a server and be in the following format: `alias|username@hostname port`. The `alias` is a user-friendly name you choose for the server. The `username@hostname` is the standard SSH login identifier. The `port` is optional; if not provided, the script defaults to port 22.

Here's an example of what entries might look like:

```
myserver|john@192.168.1.100 2222
workserver|doe@work.example.com
```

2. **Run the script**: In a terminal, navigate to the directory containing the script and `entries.txt`. Run the script with this command:
```
bash scriptname.sh
```
or
```
./scriptname.sh
```
where `scriptname.sh` is the name of the script file.

3. **Choose a server**: The script will display a table of servers and ask you to enter the index of the server to which you want to connect. Enter the index number and press `Enter`.

4. **Connect**: The script will initiate an SSH connection to the chosen server.

## Requirements

- The script requires Bash to run. Most Unix-like operating systems, including Linux distributions and MacOS, come with Bash preinstalled.
- The script uses the `ssh` command to initiate SSH connections. Ensure SSH is installed and in your system's PATH.
- The script expects an `entries.txt` file in the same directory. This file should contain the servers to which you want to connect.

## Notes

- The script does not handle SSH authentication. You'll need to authenticate with the server after the SSH connection is initiated. Consider using SSH keys for password-less logins.
- The script does not validate entries in the `entries.txt` file. Ensure these entries are valid and correctly formatted.
```