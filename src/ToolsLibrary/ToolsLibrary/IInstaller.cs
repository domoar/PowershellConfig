namespace ToolsLibrary
{
  public interface IInstaller
  {
    string Repository { get; set; }
    string Version { get; set; }
    Task<int> PreInstall();
    Task<int> Install();
    Task<int> PostInstall();
    bool Result { get; set; }
  }
}
