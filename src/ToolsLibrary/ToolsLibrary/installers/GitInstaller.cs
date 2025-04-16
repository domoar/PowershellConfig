using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Helpers;
using Microsoft.Extensions.Logging;
using Serilog;

namespace ToolsLibrary
{
  public class GitInstaller : BaseInstaller<GitInstaller>, IInstaller
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

    public GitInstaller(ILogger<GitInstaller> logger, IHttpClientFactory clientFactory)
      : base(logger, clientFactory) { }
  }
}
