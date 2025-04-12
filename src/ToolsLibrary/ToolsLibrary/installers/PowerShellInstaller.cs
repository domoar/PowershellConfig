using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;

namespace ToolsLibrary
{
    public class PowerShellInstaller : IInstaller
    {
        private readonly ILogger<PowerShellInstaller>? _logger;
        public string Repository { get => throw new NotImplementedException(); set => throw new NotImplementedException(); }
        public string Version { get => throw new NotImplementedException(); set => throw new NotImplementedException(); }
        public bool Result { get => throw new NotImplementedException(); set => throw new NotImplementedException(); }

        public int Install()
        {
            throw new NotImplementedException();
        }

        public int PostInstall()
        {
            throw new NotImplementedException();
        }

        public int PreInstall()
        {
            throw new NotImplementedException();
        }
        public PowerShellInstaller() { 
            _logger = null;
        }
    }
}
