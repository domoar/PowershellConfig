using Microsoft.Extensions.Logging;

namespace ToolsLibrary;

public abstract class BaseInstaller<T> {
    protected readonly ILogger<T> _logger;
    protected readonly IHttpClientFactory _clientFactory;
    protected BaseInstaller(ILogger<T> logger, IHttpClientFactory clientFactory){
        _logger = logger;
        _clientFactory = clientFactory;
    }
        
    public abstract int Install();
    public abstract int PreInstall();
    public abstract int PostInstall();
    }
}