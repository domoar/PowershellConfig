using Helpers;
using Microsoft.Extensions.Logging;

namespace ToolsLibrary;

public abstract class BaseInstaller<T>
{
  protected readonly ILogger<T> _logger;
  protected readonly IHttpClientFactory _clientFactory;

  protected BaseInstaller(ILogger<T> logger, IHttpClientFactory clientFactory)
  {
    _logger = logger;
    _clientFactory = clientFactory;
  }

  public abstract Task<int> Install();
  public abstract Task<int> PreInstall();
  public abstract Task<int> PostInstall();

  protected void LogStart() => _logger.LogStart<T>();

  protected void LogFinish() => _logger.LogFinish<T>();
}
