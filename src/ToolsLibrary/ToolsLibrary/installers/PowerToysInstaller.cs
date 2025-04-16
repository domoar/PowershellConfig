using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using Helpers;
using Microsoft.Extensions.Logging;

namespace ToolsLibrary
{
  public class PowerToysInstaller : BaseInstaller<PowerToysInstaller>, IInstaller
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
      LogStart();
      var client = _clientFactory.CreateClient();
      var response = await client.GetAsync(Repository);

      if (
        response.StatusCode == HttpStatusCode.Found
        || response.StatusCode == HttpStatusCode.Moved
      )
      {
        var redirectUrl = response.Headers.Location?.ToString();
        _logger.LogDebug("Redirect URL: {URL}", redirectUrl);

        if (redirectUrl != null && redirectUrl.Contains("/tag/"))
        {
          var version = redirectUrl.Split("/tag/").Last();
          _logger.LogDebug("Latest version: {Version}", version);
          Version = version;
          return 1;
        }
      }
      else
      {
        _logger.LogError("Unhandled statuscode: {StatusCode}", response.StatusCode);
        return -1;
      }
      LogFinish();
      return -1;
    }

    public PowerToysInstaller(ILogger<PowerToysInstaller> logger, IHttpClientFactory clientFactory)
      : base(logger, clientFactory)
    {
      Repository = "https://github.com/microsoft/PowerToys/releases/latest";
    }
  }
}
