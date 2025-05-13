using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToolsLibrary.installers
{
    public class NpmInstaller : IInstaller
    {
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
    }
}
