using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using ToolsLibrary.Helpers;
using Microsoft.Extensions.Logging;

namespace ToolsLibrary
{
  public class PowerShellInstaller : BaseInstaller<PowerShellInstaller>, IInstaller
  {
    public string Repository { get; set; }
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

    public PowerShellInstaller(
      ILogger<PowerShellInstaller> logger,
      IHttpClientFactory clientFactory
    )
      : base(logger, clientFactory)
    {
      Repository = "https://github.com/PowerShell/PowerShell/releases/latest";
    }
  }
}
