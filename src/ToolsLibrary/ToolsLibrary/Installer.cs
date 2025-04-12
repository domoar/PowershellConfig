using System;
using System.Collections.Generic;

namespace ToolsLibrary {
public interface IInstaller {
        int Setup();
        int Install();
        int CleanUp();
        bool Result { get; set; }
    }

    public class PowerShellInstaller : IInstaller
    {
        public bool Result {
            get => throw new NotImplementedException();
            set => throw new NotImplementedException();
        }

        public int CleanUp()
        {
            throw new NotImplementedException();
        }

        public int Install()
        {
            throw new NotImplementedException();
        }

        public int Setup()
        {
            throw new NotImplementedException();
        }
    }
}

