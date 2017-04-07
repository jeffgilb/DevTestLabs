# Hello world!
You've found my repo's documentation area. This is where I tell you what all these Azure DevTest Labs artifacts do and how to tweak them to do your bidding.

If you're wondering how to use these with Azure DevTest labs, go check out my blogs.
- [Getting to know Azure DevTest Labs](https://blogs.technet.microsoft.com/jeffgilb/2017/03/10/getting-to-know-azure-devtest-labs/)
- [Creating your first VMs with Azure DevTest Labs](https://blogs.technet.microsoft.com/jeffgilb/2017/03/16/creating-your-first-vms-with-azure-devtest-labs/)
- [Connect your GitHub repo to Azure DevTest Labs](https://blogs.technet.microsoft.com/jeffgilb/2017/03/20/connect-your-github-repo-to-azure-devtest-labs/)
- [Getting to work with GitHub and Azure DevTest Labs](https://blogs.technet.microsoft.com/jeffgilb/2017/03/31/getting-to-work-with-github-and-azure-devtest-labs/)
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
| windows-config-ms | &nbsp; |
| windows-configdc-all | &nbsp; |
| windows-install-ATA1.7.2 | &nbsp; |
| windows-ipconfig | &nbsp; |
| windows-pause | &nbsp; |
| windows-populateadds | &nbsp; |
| windows-restartvm | &nbsp; |
