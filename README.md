# CloudUploader

CloudUploader is a Bash script that allows users to securely upload files to Azure Blob Storage. It supports multiple file uploads, encryption, progress display, and more.

## Features

- **Multiple file uploads**: Upload more than one file at a time.
- **Real-time upload progress bar**: Track the progress of your file uploads.
- **Encryption of files before upload**: Secure your files with encryption before sending them to the cloud.
- **Generation of shareable links after upload**: Easily share your uploaded files with others.
- **File synchronization options**: Choose to overwrite, skip, or rename files if they already exist in the storage.

## Prerequisites

Ensure you have the following installed:

- Azure CLI
- GNU Privacy Guard (GPG)
- Pipe Viewer (pv)
- An Azure account with Blob Storage access

## Setup Instructions

### Install Dependencies

1. **Azure CLI**: Install the Azure CLI tool to interact with Azure services.
   - Installation guide: [Install Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

2. **GPG**: Used for encrypting files before upload.
   ```bash
   sudo apt install gpg
   ```

3. **PV**: Used for showing progress bars during file uploads.
   ```bash
   sudo apt install pv
   ```

### Configure Azure

1. **Log into Azure**:
   ```bash
   az login
   ```

2. **Create a Resource Group** (if necessary):
   ```bash
   az group create --name MyResourceGroup --location eastus
   ```

3. **Create a Storage Account**:
   ```bash
   az storage account create --name mystorageaccount --resource-group MyResourceGroup --location eastus --sku Standard_LRS
   ```

4. **Create a Blob Container**:
   ```bash
   az storage container create --name mycontainer --account-name mystorageaccount
   ```

## Usage

Here's how you can use CloudUploader:

- **Upload a Single File**:
  ```bash
  ./clouduploader.sh /path/to/your/file.txt
  ```

- **Upload Multiple Files**:
  ```bash
  ./clouduploader.sh /path/to/your/file1.txt /path/to/your/file2.txt
  ```

- **Handling Existing Files**:
  The script will prompt you to overwrite, skip, or rename if a file already exists in the storage.

## Troubleshooting Common Issues

- **Authentication Failure**: Make sure you are logged into Azure CLI and have the necessary permissions to access the storage account.
- **Missing Dependencies**: Check if Azure CLI, GPG, and PV are installed on your machine.
- **Upload Failures**: Review your Azure Blob Storage settings, the connection string, and ensure the storage account and container names are correctly configured in the script.
- **Encryption Errors**: Ensure GPG is properly set up and that you have the necessary keys.

## Contributing

Contributions to CloudUploader are welcome! Here's how you can contribute:

1. Fork the project to your GitHub account.
2. Create a new branch for your modifications (`git checkout -b feature-branch`).
3. Make changes and test them thoroughly.
4. Commit your changes (`git commit -am 'Add some feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Create a new Pull Request.

## License

CloudUploader is provided under the MIT License. See the LICENSE file for more information.
