using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Helpers;
using Microsoft.Extensions.Logging;

namespace ToolsLibrary
{
    public class GitInstaller : BaseInstaller<GitInstaller>, IInstaller
    {
        public string Repository { get => throw new NotImplementedException(); set => throw new NotImplementedException(); }
        public string Version { get => throw new NotImplementedException(); set => throw new NotImplementedException(); }
        public bool Result { get => throw new NotImplementedException(); set => throw new NotImplementedException(); }

        public override int Install()
        {
            _logger?.LogInstall("foo");
            return -1;
        }

        public override int PostInstall()
        {
            _logger?.LogPostInstall("");
            return -1;
        }

        public override int PreInstall()
        {
            _logger?.LogPreInstall("");
            return -1;
        }

        public GitInstaller(ILogger<GitInstaller> logger, IHttpClientFactory clientFactory) : base(logger, clientFactory) { 
        }
    }
}