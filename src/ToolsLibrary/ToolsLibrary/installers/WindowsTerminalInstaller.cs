using Microsoft.Extensions.Logging;
using ToolsLibrary.Helpers;

namespace ToolsLibrary;

public class WindowsTerminalInstaller : BaseInstaller<WindowsTerminalInstaller>, IInstaller{
    public string Repository
    {
      get => throw new NotImplementedException();
      set => throw new NotImplementedException();
    }
    public string Version
    {
      get => throw new NotImplementedException();
      set => throw new NotImplementedException();
    }
    public bool Result
    {
      get => throw new NotImplementedException();
      set => throw new NotImplementedException();
    }

    public override async Task<int> Install()
    {
      LogStart();
      LogFinish();
      await Task.Delay(1);
      return -1;
    }

    public override async Task<int> PostInstall()
    {
      LogStart();
      LogFinish();
      await Task.Delay(1);
      return -1;
    }

    public override async Task<int> PreInstall()
    {
      var client = _clientFactory.CreateClient();
      LogStart();
      var res = await GithubApiHelper.GetFromGithub(Repository, client, _logger);
      LogFinish();
      if(Version != "NotFound"){
        // TODO use enum
        Version = res.Item2;
      }
      return res.Item1;
    }

    public WindowsTerminalInstaller(ILogger<WindowsTerminalInstaller> logger, IHttpClientFactory clientFactory)
      : base(logger, clientFactory) { 
        Repository = "https://github.com/microsoft/terminal/releases/latest";
      }
}