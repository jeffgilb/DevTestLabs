# Hello world!
You've found my repo's documentation area. This is where I tell you what all these Azure DevTest Labs artifacts do and how to tweak them to do your bidding.

If you're wondering how to use these with Azure DevTest labs, go check out my blogs.
- [Getting to know Azure DevTest Labs](https://blogs.technet.microsoft.com/jeffgilb/2017/03/10/getting-to-know-azure-devtest-labs/)
- [Creating your first VMs with Azure DevTest Labs](https://blogs.technet.microsoft.com/jeffgilb/2017/03/16/creating-your-first-vms-with-azure-devtest-labs/)
- [Connect your GitHub repo to Azure DevTest Labs](https://blogs.technet.microsoft.com/jeffgilb/2017/03/20/connect-your-github-repo-to-azure-devtest-labs/)
- [Getting to work with GitHub and Azure DevTest Labs](https://blogs.technet.microsoft.com/jeffgilb/2017/03/31/getting-to-work-with-github-and-azure-devtest-labs/)\
- [Your first DevTest Labs artifact--JSON file](https://blogs.technet.microsoft.com/jeffgilb/2017/04/07/your-first-devtest-labs-artifact-json-file/)
- ...more to come.

> **IMPORTANT**:
> Use these at your own risk. No guarantees these will even work :)

## Azure artifacts
These artifacts interact with Azure in some form or fashion. You'll most likely need Azure AD global admin credentials for them to work.

|**Artifact name**|Description|
|---|---|
| [azure-enable-directory-sync](https://github.com/jeffgilb/DevTestLabs/tree/master/artifacts/azure-enable-directory-sync) | This artifact enables directory synchronization in the Azure portal. You'll need your Azure AD global admin credentials to run this one. It must be done before you use Azure AD Connect to synchronize an on-premises AD DS with Azure AD. |
| [azure-install-cmdlets](https://github.com/jeffgilb/DevTestLabs/tree/master/artifacts/azure-install-cmdlets) | Installs the Microsoft Online Services Sign-In Assistant for IT Professionals RTW from http://go.microsoft.com/fwlink/?LinkID=286152 and then installs Azure AD PowerShell cmdlets from http://go.microsoft.com/fwlink/p/?linkid=236297. Best to run with no one logged in." |



## Windows artifacts
These artifacts work on Windows-based VMs.

|**Artifact name**|Description|
|---|---|
| [windows-add-upn-suffix](https://github.com/jeffgilb/DevTestLabs/tree/master/artifacts/windows-add-upn-suffix) | Adds a specified alternate UPN suffix to Active Directory Domains and Trusts and then assigns it to all users. Sets the users' email address properties to use the new alternate UPN suffix. Don't forget to Use this in preparation for synchronizing users to Azure AD. |
| [windows-autostartbginfo](https://github.com/jeffgilb/DevTestLabs/tree/master/artifacts/windows-autostartbginfo) | Creates a custom Startup shortcut for bginfo from Sysinternals (by Mark Russinovich). Uses a custom config file (.bgi) co-located with bginfo.exe. IMPORTANT: This requires that the Sysinternals Artifact has been run first. |
| [windows-azure-ad-connect](https://github.com/jeffgilb/DevTestLabs/tree/master/artifacts/windows-azure-ad-connect) | Downloads and installs the latest version of Azure AD Connect. |
| [windows-azure-app-proxy](https://github.com/jeffgilb/DevTestLabs/tree/master/artifacts/windows-azure-app-proxy) | Installs and registers the AAD App Proxy Connector to enable a secure connection between applications inside your network and the Application Proxy & Azure. Only one installation is necessary to service all your published applications; a second connector can be installed for high availability purposes. |
| [windows-config-dc](https://github.com/jeffgilb/DevTestLabs/tree/master/artifacts/windows-config-dc) | Performs base configurations on domain controller VMs: turns off IE advanced security, enables downloads from IE, installs Active Directory Users and Computers snap-in, creates a custom Startup shortcut for bginfo from Sysinternals (by Mark Russinovich) using a custom config file (.bgi) co-located with bginfo.exe, and then restarts the VM. **IMPORTANT**: This requires that the Sysinternals Artifact has been run first! |
| [windows-config-ms](https://github.com/jeffgilb/DevTestLabs/tree/master/artifacts/windows-config-ms) | Performs base configurations on member servers: joins the specified domain, turns off IE advanced security, enables downloads from IE, creates a custom Startup shortcut for bginfo from Sysinternals (by Mark Russinovich) using a custom config file (.bgi) co-located with bginfo.exe, and then restarts the VM. **IMPORTANT**: This requires that the Sysinternals Artifact has been run first!|
| [windows-configdc-all](https://github.com/jeffgilb/DevTestLabs/tree/master/artifacts/windows-configdc-all) | Performs base configurations on domain controller VMs: turns off IE advanced security, enables downloads from IE, installs Active Directory Users and Computers snap-in, creates a custom Startup shortcut for bginfo from Sysinternals (by Mark Russinovich) using a custom config file (.bgi) co-located with bginfo.exe, and then restarts the VM. Creates custom organizational units for ten business functional units, adds 1,000 ficticious user names (100 to each business unit OU), creates a security group in each OU that includes all members of that OU. Optionally, you can change all users' UPN suffix and emali address properties to the suffix provided. Fictitious names courtesy of fakenamegenerator.com and licensed under a Creative Commons Attribution-Share Alike 3.0 United States License: http://creativecommons.org/licenses/by-sa/3.0/us/. **IMPORTANT**: This requires that the Sysinternals Artifact has been run first! |
| [windows-install-ATA1.7.2](https://github.com/jeffgilb/DevTestLabs/tree/master/artifacts/windows-install-ATA1.7.2) | Installs ATA 1.7.2 at the IP address provided for the local VM the script is run on and then adds the specified user to the ATA Administrator's Group. |
| [windows-ipconfig](https://github.com/jeffgilb/DevTestLabs/tree/master/artifacts/windows-ipconfig) | Returns IPCONFIG information for the local VM. |
| [windows-pause](https://github.com/jeffgilb/DevTestLabs/tree/master/artifacts/windows-pause) | Inserts a pause between steps and records pause actions in artifact installation record (viewable from within a VM's DevTest Labs artifact history). |
| [windows-populateadds](https://github.com/jeffgilb/DevTestLabs/tree/master/artifacts/windows-populateadds) | Creates custom organizational units for ten business functional units, adds 1,000 ficticious user names (100 to each business unit OU), creates a security group in each OU that includes all members of that OU. Optionally, you can change all users' UPN suffix and emali address properties to the suffix provided. Fictitious names courtesy of fakenamegenerator.com and licensed under a Creative Commons Attribution-Share Alike 3.0 United States License: http://creativecommons.org/licenses/by-sa/3.0/us/. |
| [windows-restartvm](https://github.com/jeffgilb/DevTestLabs/tree/master/artifacts/windows-restartvm) | Restarts the VM running the article. After the restart, the VM will automatically continue with the next article in the formula. |
