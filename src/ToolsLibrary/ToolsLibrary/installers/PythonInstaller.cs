using Microsoft.Extensions.Logging;

namespace ToolsLibrary
{
  public class PythonInstaller : BaseInstaller<PythonInstaller>, IInstaller
  {
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
      LogStart();
      LogFinish();
      await Task.Delay(1);
      return -1;
    }

    public PythonInstaller(ILogger<PythonInstaller> logger, IHttpClientFactory clientFactory)
      : base(logger, clientFactory) { }
  }
}
