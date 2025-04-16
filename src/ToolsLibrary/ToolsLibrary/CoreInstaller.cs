using Helpers;

namespace ToolsLibrary;
public class CoreInstaller
{
    public void Run()
    {
        var tools = new[] { "git", "powershell" }; //TODO dynamic
        var installedTools = JsonHelper.LoadTools();

        foreach (var tool in tools)
        {
            var installer = InstallerFactory.CreateInstaller(tool);
            var existingTool = installedTools.FirstOrDefault(t => t.Name.Equals(tool, StringComparison.OrdinalIgnoreCase));

            if (existingTool != null && CheckLatestVersion(existingTool, installer))
                continue;

            installer.PreInstall();
            installer.Install();
            installer.PostInstall();

            if (installer.Result)
            {
                var updatedTool = new ToolInfo
                {
                    Name = tool,
                    Version = installer.Version,
                    Installed = true
                };

                installedTools.RemoveAll(t => t.Name == tool);
                installedTools.Add(updatedTool);
            }
        }

        JsonHelper.SaveTools(installedTools);
    }

    private bool CheckLatestVersion(ToolInfo tool, IInstaller installer)
    {
        //TODO SemVer
        return tool.Version == installer.Version;
    }
}
