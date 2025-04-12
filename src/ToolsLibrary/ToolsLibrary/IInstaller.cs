namespace ToolsLibrary
{
    public interface IInstaller
    {
        string Repository { get; set; }
        string Version { get; set; }
        int PreInstall();
        int Install();
        int PostInstall();
        bool Result { get; set; }
    }
}
